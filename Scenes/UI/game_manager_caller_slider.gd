extends Slider



@export var method_name : String
@export var args : Array = []

func _value_changed(new_value: float) -> void:
	if GameManager.has_method(method_name):
		GameManager.callv(method_name, [new_value] + args)