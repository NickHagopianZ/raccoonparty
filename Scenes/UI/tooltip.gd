extends Control


var preview : Control = null
@export var duplicate_node : Control

@export_multiline var tip_string : String = ""
@export var string_node : Label
@export var default_preview_node : Control
func _ready() -> void:
	return
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	generate_preview()


var display_preview : bool = false
func _on_mouse_entered() -> void:
	display_preview = true
	preview.visible = true
	update_preview_position()

func _on_mouse_exited() -> void:
	display_preview = false
	preview.visible = false

func _process(_delta):
	if display_preview:
		update_preview_position()
	


func generate_preview() -> void:
	if duplicate_node:
		preview = duplicate_node.duplicate()
		add_child(preview)
	else:
		preview = default_preview_node
		string_node.text = tip_string
		# Force the parent PanelContainer to resize based on the new text
		default_preview_node.reset_size()




func update_preview_position():
	# preview to right side of mouse if there is space, otherwise left side
	var mouse_position = get_global_mouse_position()
	var screen_size = get_viewport_rect().size
	var preview_rect = preview.get_global_rect()
	# Check if there is space on the right side
	if mouse_position.x + preview_rect.size.x < screen_size.x:
		preview.global_position = Vector2(
			mouse_position.x, 
			mouse_position.y
			)
	else: # Position on the left side
		preview.global_position = Vector2(
			mouse_position.x - preview_rect.size.x, mouse_position.y)
