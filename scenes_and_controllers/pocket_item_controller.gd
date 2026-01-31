@tool
extends Area2D
class_name PocketItemController

#region Enums
#endregion

#region Parameters (consts and exportvars)
@onready var main_sprite: Sprite2D = %MainSprite
@onready var collision_shape: CollisionShape2D = %CollisionShape2D
@onready var dotted_outline: Sprite2D = %DottedOutline
@export var resource: PocketItem:
	get: return resource
	set(value):
		resource = value
		if Engine.is_editor_hint():
			_resource_updated()
#endregion

#region Signals
#endregion

#region Variables
var value : int
#endregion

#region Computed properties
#endregion

#region Default functions
# func _init(): pass
	
# func _enter_tree(): pass
	
func _ready():
	if Engine.is_editor_hint(): return
	if resource:
		_resource_updated()
	
	
# func _process(_delta): pass
	
# func _physics_process(_delta): pass
	
# func _input(_event: InputEvent): pass

# func _exit_tree(): pass
#endregion

#region Public functions
func focus():
	dotted_outline.show()
	
func pick_up():
	unfocus()
	queue_free()

func unfocus():
	dotted_outline.hide()
#endregion

#region Overridable functions
#endregion

#region Private functions
func _change_pickup_radius(radius:float):
	(collision_shape.shape as CircleShape2D).radius = radius
	
func _resource_updated():
	if !resource:
		value = 0
		main_sprite.texture = null
		dotted_outline.texture = null
		_change_pickup_radius(100.0)
		return
	value = resource.value
	if !main_sprite: return
	main_sprite.texture = resource.texture
	dotted_outline.texture = resource.texture
	_change_pickup_radius(resource.size)
#endregion

#region Subclasses
#endregion
