extends Button



@export var method_name : String
@export var args : Array = []
func _pressed() -> void:
	GameManager.play_sfx.emit(GameManager.SFX.Interact)
	if GameManager.has_method(method_name):
		GameManager.callv(method_name, args)
