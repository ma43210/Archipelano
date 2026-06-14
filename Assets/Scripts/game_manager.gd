extends Node
var archipelago = false
var current_level = ""
var level_path = "res://Assets/Scenes/Levels/"
var current_level_in_array = 0
var level_list = []
var key = 0
var all_keys = []
var connection = ConnectionInfo.new()
var ap_items_recieved = []
var ap_locations_checked = []
	
func randomize_levels():
	var all_levels = ["1A", "1B", "2A", "2B", "3A", "3B", "4A", "4B", "5A", "5B"]
	all_levels.shuffle()
	for i in 10:
		level_list.append(all_levels.pop_front())
	if archipelago:
		#take level list out of save file
		#put it in the save file
		pass
	print(level_list)
#DEBUG, DELETE PRINT LATER
#KEEP DUPES, THERE IS NO TIME


func _ready():
	Archipelago.connected.connect(connect_script)
	randomize_levels()
	reset_key()
	
	
func connect_script(_conn: ConnectionInfo, _json: Dictionary) -> void:
	archipelago = true
	Archipelago.set_client_status(Archipelago.ClientStatus.CLIENT_PLAYING)
	Archipelago.conn.obtained_item.connect(func(item): all_keys.append(item))
	get_tree().change_scene_to_file("res://Assets/Scenes/Levels/Menu.tscn")
	ap_items_recieved = Archipelago.conn.received_items
#Level locations will be #
func next_level():
	if current_level_in_array == 10:
		WinnerisYou.you_win()
		if archipelago:
			Archipelago.collect_location(10000)
			Archipelago.set_client_status(Archipelago.ClientStatus.CLIENT_GOAL)
	else:
		if archipelago:
			if current_level not in ap_locations_checked:
				Archipelago.collect_location(current_level_in_array)
				ap_locations_checked.append(current_level_in_array)
		current_level = level_list[current_level_in_array]
		current_level_in_array += 1
		var full_path = level_path + "level_" + current_level + ".tscn"
		get_tree().change_scene_to_file(full_path)
		set_up_level()
	
	
func set_up_level():
	reset_key()
	if archipelago:
		if current_level_in_array + 100 in all_keys:
			current_level_in_array += 1
			var door = get_tree().get_first_node_in_group("level_exits") as LevelExit
			door.open()

#Key locations will be 10#
func add_key():
	if archipelago:
		Archipelago.collect_location(current_level_in_array + 100)
	else:
		key += 1
		if key == 1:
			var door = get_tree().get_first_node_in_group("level_exits") as LevelExit
			door.open()
	
	
func reset_key():
	key = 0

func dead(from_deathlink := false):
	get_tree().change_scene_to_file("res://Assets/Scenes/Levels/level_" + level_list[0] + ".tscn")
	reset_key()
	current_level_in_array = 1
	if not from_deathlink:
		pass
