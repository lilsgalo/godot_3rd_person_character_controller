extends CharacterBody3D
signal SetMovementState(movementState: MovementState)

var MovementStates: Dictionary = {
	"idle": "uid://cp4hibt7k7ajl",
	"walk": "uid://tuwq3y8d4s1i",
	"run": "uid://bisq4xxmxfruh"
}

var MovementDirection: Vector3

func _ready() -> void:
	SetMovementState.emit(MovementStates["idle"])

func _input(event: InputEvent) -> void:
	#var input_dir = Input.get_vector("left", "right", "up", "down")
	if event.is_action("movement"):
		MovementDirection.x = Input.get_action_strength("left") - Input.get_action_strength("right")
		MovementDirection.y = Input.get_action_strength("forward") - Input.get_action_strength("back")
