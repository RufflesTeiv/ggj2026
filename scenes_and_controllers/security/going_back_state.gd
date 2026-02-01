extends SecurityState
class_name GoingBackSecurityState

@export var move_speed := 30.0
@onready var area_of_sight: AreaOfSight2D = %AreaOfSight2D
@onready var nav2d: NavigationAgent2D = %NavigationAgent2D

var players_on_sight : Array[PlayerController] = []

#region Overrides
func start(cont : SecurityController):
	super.start(cont)
	area_of_sight.node_entered_area.connect(_on_sight_body_entered)
	area_of_sight.node_exited_area.connect(_on_sight_body_exited)
	area_of_sight.show()
	nav2d.target_position = controller.initial_position

func phys_proc(_delta:float):
	_move_back()

func exit():
	area_of_sight.hide()
	Utility.disconect_all_from_signal(area_of_sight.node_entered_area)
	Utility.disconect_all_from_signal(area_of_sight.node_exited_area)
	_disconnect_all_players()
	players_on_sight = []
	super.exit()
#endregion

#region Private functions
func _disconnect_all_players():
	for player in players_on_sight:
		Utility.disconnect_from_signal_safe(player.item_picked,_on_player_item_picked)
		
func _move_back():
	var direction = (nav2d.get_next_path_position() - controller.position).normalized()
	var angle_to_direction = Vector2.RIGHT.angle_to(direction)
	area_of_sight.rotation = angle_to_direction / 2.0
	controller.velocity = direction*move_speed
	controller.move_and_slide()
	if nav2d.is_target_reached():
		controller.change_state(controller.patrol_state)
		
func _on_player_item_picked(player:PlayerController):
	controller.pursuing_state.pursued_player = player
	controller.change_state(controller.pursuing_state)

func _on_sight_body_entered(body:Node2D):
	if !(body is PlayerController):
		return
	var player := body as PlayerController
	if !(player in players_on_sight):
		players_on_sight.append(player)
		player.item_picked.connect(_on_player_item_picked)
	
func _on_sight_body_exited(body:Node2D):
	if !(body is PlayerController):
		return
	var player := body as PlayerController
	if player in players_on_sight:
		players_on_sight.remove_at(players_on_sight.find(player))
		player.item_picked.disconnect(_on_player_item_picked)
#endregion
