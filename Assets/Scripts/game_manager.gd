extends Node
var archipelago = false
var current_level = ""
var level_path = "res://Assets/Scenes/Levels/"
var current_level_in_array = 0
var level_list = []
var key = 0
var all_keys = []
var gamestart = true
var exit_is_open = false
var win = false
var music: AudioStreamPlayer
var background_music = preload("res://Assets/Sounds/Music/Fens-of-Fog.mp3")

func randomize_levels():
	var all_levels = ["1A", "1B", "2A", "2B", "3A", "3B", "4A", "4B", "5A", "5B"]
	all_levels.shuffle()
	for i in 10:
		level_list.append(all_levels.pop_front())
	if archipelago:
		#take level list out of save file
		#put it in the save file
		pass



func _ready():
	Archipelago.connected.connect(connect_script)
	randomize_levels()
	reset_key()
	music = AudioStreamPlayer.new()
	add_child(music)

func play_music(track: AudioStream):
	music.stream = track
	music.play()
	
	
func connect_script(_conn: ConnectionInfo, _json: Dictionary) -> void:
	Archipelago.conn.obtained_item.connect(get_item)
	Archipelago.set_client_status(Archipelago.ClientStatus.CLIENT_PLAYING)
	archipelago = true
	get_tree().change_scene_to_file("res://Assets/Scenes/start_lore.tscn")

func get_item(item: NetworkItem):
	self.all_keys.append(int(item.id))

func start_game():
	current_level = level_list[current_level_in_array]
	var full_path = level_path + "level_" + current_level + ".tscn"
	get_tree().change_scene_to_file(full_path)
	play_music(background_music)

func next_level():
	if current_level_in_array == 9:
		get_tree().change_scene_to_file("res://Assets/Scenes/end_lore.tscn")
	else:
		if archipelago:
				Archipelago.collect_location(current_level_in_array + 1)
		self.current_level_in_array += 1
		current_level = level_list[current_level_in_array]
		var full_path = level_path + "level_" + current_level + ".tscn"
		get_tree().change_scene_to_file(full_path)
		set_up_level()

		
func set_up_level():
	exit_is_open = false
	reset_key()

func winner_is_you():
	win = true
	if archipelago:
		Archipelago.collect_location(10000)
		Archipelago.set_client_status(Archipelago.ClientStatus.CLIENT_GOAL)


func add_key():
	if archipelago:
		Archipelago.collect_location(current_level_in_array + 101)
		if int(current_level_in_array + 101) in all_keys:
			exit_is_open = true
	else:
		key += 1
		if key == 1:
			exit_is_open = true
	
	
func reset_key():
	key = 0

func dead(from_deathlink := false):
	get_tree().change_scene_to_file("res://Assets/Scenes/Levels/level_" + level_list[0] + ".tscn")
	self.current_level_in_array = 0
	set_up_level()
	if not from_deathlink:
		pass
