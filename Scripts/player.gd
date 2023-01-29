extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var mok = 0
var oldVel = 0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var footsteps = $FootSteps


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
var InputStrengthx 
var InputStrengthz
var multi = 3
func _physics_process(delta):
	$Camera3D.rotation.x = lerp_angle($Camera3D.rotation.x,$Node3D.rotation.x,.05)
	self.rotation.y = lerp_angle(self.rotation.y,$Node3D.rotation.y,0.05)
	velocity.x = 0

	velocity.z = 0
	InputStrengthz = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down") 
	InputStrengthx = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") 
	
	if Input.is_action_pressed("ui_accept"):
		multi = 6

	else:
		multi = 3

	velocity += (-(self.basis.z * InputStrengthz) + -(self.basis.x * InputStrengthx)) * multi
	


	velocity.y -= gravity
	if is_on_floor():
		velocity.y = 0
	
	move_and_slide()
	mok += delta
	
	if InputStrengthx == 0 && InputStrengthz == 0:
		
		mok = 0
	
	if Input.is_action_pressed("ui_accept"):
		$Camera3D.position.y = lerp($Camera3D.position.y ,.5 + (sin(mok*30)/4),.1)
	else:
		$Camera3D.position.y = lerp($Camera3D.position.y ,.5 + (sin(mok*20)/6),.1)


var mov = Vector2.ZERO
func _input(event):
   # Mouse in viewport coordinates.
	if event is InputEventMouseMotion:
		mov = event.relative/200
		$Node3D.rotation.x = deg_to_rad(clampf(rad_to_deg($Node3D.rotation.x -mov.y),-90,90))
		$Node3D.rotation.y = deg_to_rad(rad_to_deg($Node3D.rotation.y)-mov.x*100)

