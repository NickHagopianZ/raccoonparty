extends Node2D


@export var room_handlers : Array[RoomHandler] = []
var current_room_handler : RoomHandler = null
func _ready() -> void:
	for handler in room_handlers:
		handler.body_entered.connect(_on_room_handler_body_entered.bind(handler))



func update_visibility(handler, force_show_all : bool = false) -> void:
	for sprite in handler.background_sprites:
		if sprite:
			sprite.visible = true
			sprite.z_index = 2
	for sprite in handler.foreground_sprites:
		if sprite:
			sprite.visible = false or force_show_all


func reset(handler: RoomHandler) -> void:
	for sprite in handler.background_sprites:
		if sprite:
			sprite.visible = false
	for sprite in handler.foreground_sprites:
		if sprite:
			sprite.visible = true


func _on_room_handler_body_entered(body: Node, handler: RoomHandler) -> void:
	if handler == current_room_handler:
		return
	if body is not PlayerEntity:
		return

	update_visibility(handler)
