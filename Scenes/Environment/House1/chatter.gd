extends AudioStreamPlayer3D

func _ready():
	self.play(randf() * self.stream.get_length())
	if self.name != "Chatter0":
		self.volume_db = -12.0
