extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$time.text = var_to_str(floori(self.get_parent().time / 60))  + ":" + var_to_str(roundi(self.get_parent().time) % 60) + "." + var_to_str(self.get_parent().time - floor(self.get_parent().time)).substr(2,2)
	$checkpoints.text = var_to_str(self.get_parent().checkpoints) + "/" + var_to_str(self.get_parent().get_node("checkpoints").get_child_count())
