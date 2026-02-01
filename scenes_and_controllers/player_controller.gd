extends CharacterBody2D
class_name PlayerController

#region Enums
#endregion

#region Parameters (consts and exportvars)
@onready var interact_area: Area2D = %InteractArea
@export var max_speed_default := 100.0
@export var max_speed_running := 150.0
@export var acceleration := 50.0
@export var friction := 80.0
@onready var dash_audio_player: AudioStreamPlayer = %DashAudioPlayer

#endregion

#region Signals
signal item_picked(player:PlayerController)
#endregion

#region Variables
var focused_item : PocketItemController
var items_pocketed : Array[PocketItem]
#endregion

#region Computed properties
#endregion

#region Default functions
#func _init(): pass
#func _enter_tree(): pass

func _ready():
	interact_area.area_entered.connect(_on_area_entered)
	interact_area.area_exited.connect(_on_area_exited)
	
#func _process(_delta): pass

func _physics_process(_delta):
	_move(_delta)

func _input(_event: InputEvent):
	_check_pickup(_event)
	_has_started_running(_event)
	
#func _exit_tree(): pass
#endregion

#region Public functions
#endregion

#region Overridable functions
#endregion

#region Private functions
func _check_pickup(input : InputEvent):
	if !Input.is_action_just_pressed("pick_up"): return
	if !focused_item: return
	items_pocketed.append(focused_item.resource)
	focused_item.pick_up()
	item_picked.emit(self)
	
func _get_max_speed() -> float:
	if Input.is_action_pressed("run"):
		return max_speed_running
	return max_speed_default

func _has_started_running(event: InputEvent):
	if Input.is_action_just_pressed("run"):
		dash_audio_player.pitch_scale = randf_range(0.9, 1.15)
		dash_audio_player.play()

func _move(delta:float):
	var input := Vector2(
		Input.get_axis("move_left","move_right"),
		Input.get_axis("move_up","move_down")
	).normalized()
	var lerp_weight := delta * (acceleration if input else friction)
	velocity = lerp(velocity, input*_get_max_speed(), lerp_weight)
	move_and_slide()
	
func _on_area_entered(area : Area2D):
	if !(area is PocketItemController):
		return
	var pocket_item := area as PocketItemController
	pocket_item.focus()
	focused_item = pocket_item
	
func _on_area_exited(area : Area2D):
	if !(area is PocketItemController):
		return
	var pocket_item := area as PocketItemController
	if focused_item == pocket_item:
		focused_item.unfocus()
		focused_item = null
#endregion

#region Subclasses
#endregion
