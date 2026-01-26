extends Node2D


@export var room_handlers : Array[RoomHandler] = []
var current_room_handler : RoomHandler = null
func _ready() -> void:
	for handler in room_handlers:
		handler.body_entered.connect(_on_room_handler_body_entered.bind(handler))


func show_all() -> void:
	for handler in room_handlers:
		for sprite in handler.show_sprites:
			if sprite:
				sprite.visible = true
		for sprite in handler.hide_sprites:
			if sprite:
				sprite.visible = true

func _on_room_handler_body_entered(body: Node, handler: RoomHandler) -> void:
	if handler == current_room_handler:
		return
	if body is not PlayerCharacter:
		return
	print("Entered room handler: ", handler.name)

	show_all()
	
	if body is PlayerCharacter:
		for sprite in handler.show_sprites:
			sprite.visible = true
		for sprite in handler.hide_sprites:
			sprite.visible = false
