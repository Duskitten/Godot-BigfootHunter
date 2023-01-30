extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var defaultZoom = 45
var CamZoomMax = 45
var CamZoomMin = 1
var CamZoomCurrent = 45

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	if Input.is_action_pressed("ZIN"):
		CamZoomCurrent = clamp(CamZoomCurrent-1,CamZoomMin,CamZoomMax)
	if Input.is_action_pressed("ZOUT"):
		CamZoomCurrent = clamp(CamZoomCurrent+1,CamZoomMin,CamZoomMax)
	$"../Camera3D".fov = CamZoomCurrent
