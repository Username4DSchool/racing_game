extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$time.text = var_to_str(floori(self.get_parent().time / 60))  + ":" + var_to_str(roundi(self.get_parent().time) % 60) + "." + var_to_str(self.get_parent().time - floor(self.get_parent().time)).substr(2,2)
	$checkpoints.text = var_to_str(self.get_parent().checkpoints) + "/" + var_to_str(self.get_parent().get_node("checkpoints").get_child_count())

func shown(shown: int) -> void:
	$"3".visible = false
	$"2".visible = false
	$"1".visible = false
	
	match shown:
		1:
			$"1".show()
		2:
			$"2".show()
		3:
			$"3".show()
