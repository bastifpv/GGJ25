extends Node
var file_path = "user://save_game.dat"

func save_highscore(name, score):
	var actual_highscore = load_highscore()
	actual_highscore[name] = score
	var json = JSON.new()  # Erstelle eine Instanz von JSON
	var json_string = json.stringify(actual_highscore)  # Wandle das Dictionary in einen JSON-String um
	var file = FileAccess.open(file_path, FileAccess.WRITE)		
	file.store_string(json_string)

func load_highscore():
	var file = FileAccess.open(file_path, FileAccess.READ)
	var content = file.get_as_text()
	var json = JSON.new()  # Erstelle eine Instanz von JSON
	var parse_result = json.parse(content)  # JSON-Text parsen
	if parse_result == OK:
		var parsed_data = json.get_data()		
		var sorted_data = sort_by_value(parsed_data)
		print(sorted_data)
		return sorted_data
	else:
		return json.parse_string("{}")
	
		
func sort_by_value(data: Dictionary) -> Dictionary:
	var sorted_list = []
	for key in data.keys():
		sorted_list.append([key, data[key]])
	sorted_list.sort_custom(func(a, b):
		return a[1] > b[1]  # Aufsteigend nach Wert (Punkte)
	)
	var sorted_dict = {}
	for item in sorted_list:
		sorted_dict[item[0]] = item[1]
	return sorted_dict

func _ready() -> void:
	actualize()

func actualize():	
	var counter = 5
	var high = ""
	var scores = load_highscore()
	for line in scores:
		counter -= 1
		if counter >= 0:
			var length = len(line) + len(str(scores[line]))
			high += line
			for i in range ((24-length)*2):
				high += "." 
			high += str(scores[line]) + "\n"
	print (high)
	$".".text = high
		
	

func _on_name_text_submitted(new_text: String) -> void:
	
	var score = Global.population
	if score == null:
		score = 0
	save_highscore(new_text,score)
	actualize()
