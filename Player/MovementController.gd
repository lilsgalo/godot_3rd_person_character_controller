extends Node

@export var Player: CharacterBody3D
@export var MeshRoot: Node3D
@export var RotationSpeed: float = 8

var Direction: Vector3
var Velocity: Vector3
var Acceleration: float
var Speed: float
var CameraRotation: float

func _physics_process(delta: float) -> void:
	Velocity.x = Speed * Direction.normalized().x
	Velocity.z = Speed * Direction.normalized().z
	
	Player.velocity = Player.velocity.lerp(Velocity, Acceleration * delta)
	Player.move_and_slide()
	
	var targetDirection = Vector3(-Direction.x, Direction.y, -Direction.z)
	var targetRotation = atan2(targetDirection.x, targetDirection.z) - Player.rotation.y
	MeshRoot.rotation.y = lerp_angle(MeshRoot.rotation.y, targetRotation, RotationSpeed * delta)

func _on_player_set_movement_state(movementState: MovementState) -> void:
	Speed = movementState.MovementSpeed
	Acceleration = movementState.Acceleration

func _on_player_set_movement_direction(movementDirection: Vector3) -> void:
	Direction = movementDirection.rotated(Vector3.UP, CameraRotation)

func _on_camera_root_set_camera_rotation(cameraRotation: float) -> void:
	CameraRotation = cameraRotation
