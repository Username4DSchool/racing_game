extends Node2D

var main_menu = preload("res://main_menu.tscn")

@export var time = 0
@export var old = 0
@export var medal = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update():
	var delta = (old - time) * -1
	var str = "+" if delta >= 0 else ""
	$time.text = var_to_str(floori(time / 60))  + ":" + var_to_str(floori(time) % 60) + "." + var_to_str(time - floor(time)).substr(2,2) + " (" + str+var_to_str(round(delta * 100) / 100) + ")" 
	
	if medal == 3:
		$medals.modulate = Color.GOLDENROD
		$medals/Label.text = "Gold"
	elif medal == 2:
		$medals.modulate = Color.SILVER
		$medals/Label.text = "Silver"
	elif medal == 1:
		$medals.modulate = Color.SADDLE_BROWN
		$medals/Label.text = "Bronze"
	else:
		$medals.modulate = Color.TRANSPARENT
		$medals/Label.text = ""


func _on_retry_pressed() -> void:
	self.get_parent().get_parent().retire()
	self.visible = false



func _on_exit_pressed() -> void:
	self.get_parent().get_parent().get_parent().add_child(main_menu.instantiate())
	self.get_parent().get_parent().queue_free()
