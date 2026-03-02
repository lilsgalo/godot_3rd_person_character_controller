extends Node3D
signal SetCameraRotation(cameraRotation: float)

@onready var CamH: Node3D = $CamH # yaw
@onready var CamV: Node3D = $CamH/CamV # pitch
@onready var Camera: Camera3D = $CamH/CamV/CameraArm/Camera

@export var h_sens: float = 0.05
@export var v_sens: float = 0.05

var horizontal: float = 0.0
var vertical: float = 0.0

var h_acc: float = 30.0
var v_acc: float = 30.0

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		horizontal += -event.relative.x * h_sens
		vertical += -event.relative.y * v_sens

func _physics_process(delta: float) -> void:
	# smooth camera
	#CamH.rotation_degrees.y = lerp(CamH.rotation_degrees.y, horizontal, h_acc * delta)
	#CamV.rotation_degrees.x = lerp(CamV.rotation_degrees.x, vertical, v_acc * delta)
	
	# not smooth camera
	CamV.rotation_degrees.x = vertical * (v_acc * delta)
	CamH.rotation_degrees.y = horizontal * (h_acc * delta)
	
	SetCameraRotation.emit(CamH.rotation.y)
