extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var defaultZoom = 75
var CamZoomMax = 75
var CamZoomMin = 35
var CamZoomCurrent = 75

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		self.visible = !self.visible
	
	if self.visible:
		if Input.is_action_pressed("ZIN"):
			CamZoomCurrent = clamp(CamZoomCurrent-1,CamZoomMin,CamZoomMax)
		if Input.is_action_pressed("ZOUT"):
			CamZoomCurrent = clamp(CamZoomCurrent+1,CamZoomMin,CamZoomMax)
		$"../Player/Camera3D".fov = CamZoomCurrent
	else:
		$"../Player/Camera3D".fov = 75
