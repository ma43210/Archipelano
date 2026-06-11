extends Node
var archipelago = false
var current_level = ""
var level_path = "res://Assets/Scenes/Levels/"
var current_level_in_array = 1
var level_list = []
var key = 0
var all_keys = []

func randomize_levels():
	var all_levels = ["1A", "1B", "2A", "2B", "3A", "3B", "4A", "4B"]
	all_levels.shuffle()
	for i in 10:
		level_list.append(all_levels.pop_front())
	if archipelago:
		#take level list out of save file
		#put it in the save file
		pass
	print(level_list)
#DEBUG, DELETE PRINT LATER


func _ready():
	Archipelago.connected.connect(start_archipelago_game)
	randomize_levels()
	reset_key()

func start_archipelago_game():
	archipelago = true
	get_tree().change_scene_to_file("res://Assets/Scenes/Levels/Menu.tscn")
	
#Level locations will be #
func next_level():
	if current_level_in_array == 10:
		WinnerisYou.you_win()
	if archipelago:
		Archipelago.collect_location(current_level_in_array)
	current_level = level_list[current_level_in_array]
	current_level_in_array += 1
	var full_path = level_path + "level_" + current_level + ".tscn"
	get_tree().change_scene_to_file(full_path)
	set_up_level()
	
	
func set_up_level():
	reset_key()
	if archipelago:
		if current_level_in_array in all_keys:
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

func dead():
	get_tree().change_scene_to_file("res://Assets/Scenes/Levels/level_" + level_list[0] + ".tscn")
	reset_key()
	current_level_in_array = 1


#ARCHIPELAGO TESTING:
func obtained_items(items: Array[NetworkItem]):
	for i in items:
			all_keys.append(i)


func obtained_item(item: NetworkItem):
		all_keys.append(item)
