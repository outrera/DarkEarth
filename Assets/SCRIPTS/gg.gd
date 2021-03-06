
extends KinematicBody2D

onready var anim = get_node("anim")
var walk = false
var new_walk = false


const MOTION_SPEED = 40


func _fixed_process(delta):
	var motion = Vector2()
	
	if (Input.is_action_pressed("move_up")):
		motion += Vector2(0, -1)
	if (Input.is_action_pressed("move_bottom")):
		motion += Vector2(0, 1)
	if (Input.is_action_pressed("move_left")):
		motion += Vector2(-1, 0)
	if (Input.is_action_pressed("move_right")):
		motion += Vector2(1, 0)
	
	motion = motion.normalized()*MOTION_SPEED*delta
	
	if motion != Vector2(0,0):
		new_walk = true
	else:
		new_walk = false
	
	if new_walk != walk:
		walk = new_walk
		if walk == false:
			anim.play("idle")
		if walk == true:
			anim.play("walk")
	
	motion = move(motion)
	
	
	
	var slide_attempts = 4
	while(is_colliding() and slide_attempts > 0):
		motion = get_collision_normal().slide(motion)
		motion = move(motion)
		slide_attempts -= 1


func _ready():
	set_fixed_process(true)


func on_item(name):
	get_parent().popup("Press 'E' to pickup "+name,get_pos()-Vector2(48,16))
	
func left_item():
	get_parent().hide_popup()