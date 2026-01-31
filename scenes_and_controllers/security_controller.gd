extends CharacterBody2D
class_name SecurityController

#region Enums
#endregion

#region Parameters (consts and exportvars)
@onready var area_of_sight: AreaOfSight2D = %AreaOfSight2D
#@onready var close_sight: Area2D = %CloseSight
@export var rotate_speed := 45.0
#endregion

#region Signals
#endregion

#region Variables
var players_on_sight : Array[PlayerController] = []
#endregion

#region Computed properties
#endregion

#region Default functions
#func _init(): pass
	
#func _enter_tree(): pass
	
func _ready():
	area_of_sight.node_entered_area.connect(_on_sight_body_entered)
	#close_sight.body_entered.connect(_on_sight_body_entered)
	area_of_sight.node_exited_area.connect(_on_sight_body_exited)
	#close_sight.body_exited.connect(_on_close_sight_body_exited)
	
#func _process(_delta): pass
	
func _physics_process(_delta):
	_rotate_sight(_delta)
	
#func _input(_event: InputEvent): pass

# unc _exit_tree(): pass
#endregion

#region Public functions
#endregion

#region Overridable functions
#endregion

#region Private functions
func _on_sight_body_entered(body:Node2D):
	if !(body is PlayerController):
		return
	var player := body as PlayerController
	if !(player in players_on_sight):
		players_on_sight.append(player)
	print(players_on_sight)
	
func _on_sight_body_exited(body:Node2D):
	if !(body is PlayerController):
		return
	var player := body as PlayerController
	if player in players_on_sight:
		players_on_sight.remove_at(players_on_sight.find(player))
	print(players_on_sight)
	
func _rotate_sight(delta:float):
	area_of_sight.rotate(deg_to_rad(delta*rotate_speed))
#endregion

#region Subclasses
#endregion
