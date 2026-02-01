extends Node


const bus: AudioBusLayout = preload("res://Resources/default_bus_layout.tres")

const BG_MUSIC_DB = -2.386
const BATTLE_MUSIC_DB = -15.744
const SILENCE_DB = -80.0
const MUSIC_FADE_TIMER = 0.5

func _ready():
	GameManager.play_sfx.connect(play_sfx)
	GameManager.pausing.connect(_handle_pause)
	GameManager.unpausing.connect(_handle_unpause)
	GameManager.starting_battle.connect(_handle_start_battle)
	GameManager.ending_battle.connect(_handle_end_battle)
	#$BackgroundMusic.play()

func play_sfx(which: GameManager.SFX):
	if which == GameManager.SFX.Interact:
		$Interact2.play()
	elif which == GameManager.SFX.Descent:
		$Descent.play()

func _handle_start_battle(_enemy):
	var tween = create_tween().set_parallel(true)
	$BattleMusic.play()
	tween.tween_property($BattleMusic, "volume_db", BATTLE_MUSIC_DB, MUSIC_FADE_TIMER).from(SILENCE_DB)

func _handle_end_battle():
	var tween = create_tween().set_parallel(true)
	tween.tween_property($BattleMusic, "volume_db", SILENCE_DB, MUSIC_FADE_TIMER).from(BATTLE_MUSIC_DB)
	tween.chain().tween_callback($BattleMusic.stop)

func _handle_pause():
	# the game manager pauses the entire subtree, we need to restart the music here
	#$BackgroundMusic.play($BackgroundMusic.get_playback_position())
	$BackgroundMusic.stream_paused = false
	$BattleMusic.stream_paused = false
	var bus_index = AudioServer.get_bus_index("Music")
	var lpf = AudioEffectLowPassFilter.new()
	lpf.cutoff_hz = 600.0
	lpf.resonance = 1.5
	AudioServer.add_bus_effect(bus_index, lpf)

func _handle_unpause():
	var bus_index = AudioServer.get_bus_index("Music")
	for i in AudioServer.get_bus_effect_count(bus_index):
		if AudioServer.get_bus_effect(bus_index, i) is AudioEffectLowPassFilter:
			AudioServer.remove_bus_effect(bus_index, i)
