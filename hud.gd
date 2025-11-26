extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$time.text = var_to_str(floori(self.get_parent().time / 60))  + ":" + var_to_str(floori(self.get_parent().time) % 60) + "." + var_to_str(self.get_parent().time - floor(self.get_parent().time)).substr(2,2)
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
func fin():
	$end.visible = true
	$end.time = self.get_parent().time
	$end.old = SaveManager.pb if SaveManager.pb != -1 else self.get_parent().time
	if self.get_parent().gold_time > self.get_parent().time:
		$end.medal = 3
	elif self.get_parent().silver_time > self.get_parent().time:
		$end.medal = 2
	elif self.get_parent().bronze_time > self.get_parent().time:
		$end.medal = 1
	else:
		$end.medal = 0
	$end.update()
	if SaveManager.pb > self.get_parent().time or SaveManager.pb == -1:
		SaveManager.pb = self.get_parent().time
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("respawn") or Input.is_action_just_pressed("retire"):
		$end.visible = false
