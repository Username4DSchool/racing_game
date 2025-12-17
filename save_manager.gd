extends Node

var pb = {"Wicked winds": -1, "Antonstreet": -1, "Cruise kingdom": -1}

func _ready() -> void:
	load_state()


func _process(delta: float) -> void:
	pass
	
func save_state():
	await get_tree().process_frame
	var file = FileAccess.open("user://save.dat", FileAccess.WRITE)
	file.store_var(pb)
	print("content")

func load_state():
	var file = FileAccess.open("user://save.dat", FileAccess.READ)
	if !file: return
	pb = file.get_var()
	print(pb)
