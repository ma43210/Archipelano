extends Node
var archipelago = false
var current_level = ""
var level_path = "res://Assets/Scenes/Levels/"
var current_level_in_array = 0
var level_list = []
var key = 0
var all_keys = []
var gamestart = true
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
	
	
func connect_script(_conn: ConnectionInfo, _json: Dictionary) -> void:
	Archipelago.conn.obtained_item.connect(get_item)
	Archipelago.set_client_status(Archipelago.ClientStatus.CLIENT_PLAYING)
	archipelago = true
	get_tree().change_scene_to_file("res://Assets/Scenes/Levels/Menu.tscn")
#Level locations will be #
func get_item(item: NetworkItem):
	self.all_keys.append(int(item.id))
	print(all_keys)

func start_game():
	current_level = level_list[current_level_in_array]
	var full_path = level_path + "level_" + current_level + ".tscn"
	get_tree().change_scene_to_file(full_path)

func next_level():
	print("YA")
	if current_level_in_array == 9:
		WinnerisYou.you_win()
		if archipelago:
			Archipelago.collect_location(10000)
			Archipelago.set_client_status(Archipelago.ClientStatus.CLIENT_GOAL)
	else:
		if archipelago:
				Archipelago.collect_location(current_level_in_array + 1)
		self.current_level_in_array += 1
		current_level = level_list[current_level_in_array]
		print(current_level)
		var full_path = level_path + "level_" + current_level + ".tscn"
		get_tree().change_scene_to_file(full_path)
		set_up_level()

		
func set_up_level():
	reset_key()


#Key locations will be 10#
func add_key():
	print(current_level_in_array)
	if archipelago:
		Archipelago.collect_location(current_level_in_array + 101)
		if int(current_level_in_array + 101) in all_keys:
			Exit.open()
			print("YAY")
	else:
		key += 1
		if key == 1:
			var door = get_tree().get_first_node_in_group("level_exits") as LevelExit
			door.open()
	
	
func reset_key():
	key = 0

func dead(from_deathlink := false):
	get_tree().change_scene_to_file("res://Assets/Scenes/Levels/level_" + level_list[0] + ".tscn")
	self.current_level_in_array = 0
	set_up_level()
	if not from_deathlink:
		pass
