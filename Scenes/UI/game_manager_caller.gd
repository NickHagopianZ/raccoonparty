extends Button



@export var method_name : String
@export var args : Array = []
func _pressed() -> void:
	if GameManager.has_method(method_name):
		GameManager.callv(method_name, args)