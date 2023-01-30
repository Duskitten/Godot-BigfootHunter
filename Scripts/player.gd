extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var hand_shake = 0.01;
var mok = 0
var oldVel = 0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity");
var photos = [];

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$LerpNode/WorldCamera/AnimationPlayer.play("CameraDown");
	
var InputStrengthx 
var InputStrengthz
var multi = 3

func _physics_process(delta):
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
	
	if(Input.is_action_pressed("Hold Camera")):
		$LerpNode/WorldCamera.position = lerp($LerpNode/WorldCamera.position,Vector3(0,-0,-0.5),.05)
		$LerpNode/WorldCamera.rotation = lerp($LerpNode/WorldCamera.rotation,Vector3(deg_to_rad(0),0,0),.05)
	elif!(Input.is_action_pressed("Hold Camera")):
		$LerpNode/WorldCamera.position = lerp($LerpNode/WorldCamera.position,Vector3(0.423,-0.253,-0.499),.05)
		$LerpNode/WorldCamera.rotation = lerp($LerpNode/WorldCamera.rotation,Vector3(deg_to_rad(-29.5),deg_to_rad(-75.5),deg_to_rad(21.1)),.05)
	
	
	var n = float(Time.get_ticks_msec()*0.001);
	var shake = Vector2(sin(n*0.1)*+sin(n*0.254)+sin(n*2.1234), cos(n*0.3)*+cos(n*3.46)+sin(n*0.1))*hand_shake;
	
	var shake_vector = ($Camera3D.global_transform.basis.x * clamp(shake.x, -0.1, 0.1)) + ($Camera3D.global_transform.basis.y * clamp(shake.y, -0.1, 0.1));
	$LerpNode.global_transform.origin = $Camera3D.global_transform.origin + shake_vector;
	var target_basis = $Camera3D.global_transform.basis;
	target_basis = target_basis.rotated($Camera3D.global_transform.basis.x, shake.x * 2.0); 
	target_basis = target_basis.rotated($Camera3D.global_transform.basis.y, shake.y * 2.0);
	$LerpNode.global_transform.basis = $LerpNode.global_transform.basis.slerp(target_basis, 3.0*delta);
	
var mov = Vector2.ZERO
func _input(event):
   # Mouse in viewport coordinates.
	if event is InputEventMouseMotion:
		mov = event.relative/200
		$Camera3D.rotation.x = deg_to_rad(clampf(rad_to_deg($Camera3D.rotation.x -mov.y),-90,90))
		rotation.y = deg_to_rad(rad_to_deg(rotation.y)-mov.x*100)



func take_photo():
	#SFX, etc
	await RenderingServer.frame_post_draw
	photos.append($LerpNode/WorldCamera/SubViewport.get_texture().get_image());


