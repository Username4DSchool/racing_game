extends Node2D

var main_menu = preload("res://main_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_to_track_pressed() -> void:
	self.get_parent().close_pause()


func _on_exit_pressed() -> void:
	self.get_parent().close_pause()
	self.get_parent().get_parent().get_parent().add_child(main_menu.instantiate())
	self.get_parent().get_parent().queue_free()
