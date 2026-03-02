extends Node3D

var mouseCaptured: bool

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	mouseCaptured = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		get_tree().quit()
	
	if event.is_action_pressed("f1"):
		if mouseCaptured:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			mouseCaptured = false
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			mouseCaptured = true
