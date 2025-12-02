extends Panel

@export var track_name = ""

func _ready() -> void:
	$Label.text = track_name

func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	self.get_parent().get_parent().get_parent().add_child(load("res://tracks/" + self.track_name + ".tscn").instantiate())
	self.get_parent().get_parent().queue_free()
