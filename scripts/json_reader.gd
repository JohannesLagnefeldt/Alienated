extends Node

func load(JSON_FILE_PATH : String) -> Array:
	var json = JSON.new()
	var file = FileAccess.open(JSON_FILE_PATH, FileAccess.READ)
	var json_text = file.get_as_text()
	var error = json.parse(json_text)
	var answer : Array = []
	print(error)
	if error == OK:
		answer = json.data["secret"]
	return answer
