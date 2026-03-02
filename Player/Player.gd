extends CharacterBody3D
signal SetMovementState(movementState: MovementState)
signal SetMovementDirection(movementDirection: Vector3)

var MovementStates: Dictionary = {
	"idle": preload("uid://cp4hibt7k7ajl"),
	"walk": preload("uid://tuwq3y8d4s1i"),
	"run": preload("uid://bisq4xxmxfruh"),
}

var MovementDirection: Vector3

func _ready() -> void:
	SetMovementState.emit(MovementStates["idle"])
	SetMovementDirection.emit(Vector3.FORWARD)

func _input(event: InputEvent) -> void:
	if event.is_action("movement"):
		MovementDirection.x = Input.get_action_strength("right") - Input.get_action_strength("left")
		MovementDirection.z = Input.get_action_strength("back") - Input.get_action_strength("forward")
		
		if IsMoving():
			if Input.is_action_pressed("sprint"):
				SetMovementState.emit(MovementStates["run"])
			else:
				SetMovementState.emit(MovementStates["walk"])
		else:
			SetMovementState.emit(MovementStates["idle"])

func _physics_process(_delta: float) -> void:
	if IsMoving():
		SetMovementDirection.emit(MovementDirection)
		
func IsMoving() -> bool:
	return abs(MovementDirection.x) > 0 or abs(MovementDirection.z) > 0
