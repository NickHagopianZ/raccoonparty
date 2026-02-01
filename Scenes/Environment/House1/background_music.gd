extends AudioStreamPlayer3D

func _ready():
	GameManager.starting_battle.connect(_handle_start_battle)
	GameManager.ending_battle.connect(_handle_end_battle)
	GameManager.continue_music_from.connect(_music_start_position)
	GameManager.pausing.connect(_handle_pause)
	process_mode = Node.PROCESS_MODE_ALWAYS


func _handle_pause():
	# the game manager pauses the entire subtree, we need to restart the music here
	#self.stream_paused = false
	pass


func _handle_start_battle(_enemy):
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "volume_db", -80.0, 1.0).from(0.0)
	tween.chain().tween_callback(self.stop)


func _handle_end_battle(_was_victory: bool):
	self.play()
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "volume_db", 0.0, 1.0).from(-80.0)


func _music_start_position(from: float):
	self.play(from)
