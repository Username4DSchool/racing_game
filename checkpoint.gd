extends Area3D

@export var checked = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("car"):
		checked = true
		print("checked")
		self.get_parent().get_parent().check_checkpoints()
		self.get_parent().get_parent().save_point()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("retire"):
		checked = false
