extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
var MS = 0
var S = 0
var M = 0
var H = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent().visible:
		MS += 1
		
		if MS == 60:
			MS = 0
			S += 1
		
		if S == 60:
			S = 0
			M += 1
			
		if M == 60:
			M = 0
			H += 1
			
		text = "%0*d" % [2, H] + ":" + "%0*d" % [2, M]  + ":" + "%0*d" % [2, S] 
