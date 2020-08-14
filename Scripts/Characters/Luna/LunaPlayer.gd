extends KinematicBody2D

const GRAVITY = 20
const MAX_SPEED = 225
const JUMPHEIGHT = -475
const ACCELERATION = 40
const UPWARDS = Vector2(0, -1)

const FIREBALL = preload("res://GenericBlueFireball.tscn")

var motion = Vector2()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	motion.y += GRAVITY			#adds gravitational pull every frame
	
	var friction = false		#state variable if friction should be applied
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		$Sprite.flip_h = false
		$Sprite.play("Running")
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		$Sprite.flip_h = true
		$Sprite.play("Running")
	else:
		$Sprite.play("Idle")
		friction = true
		
	if Input.is_action_just_pressed("ui_focus_next"):
		var fireball = FIREBALL.instance()
		get_parent().add_child(fireball)
		fireball.position = $Position2D.global_position
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMPHEIGHT
			
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.3)
			
	else:
		if motion.y < 0:
			$Sprite.play("Jump")
		else:
			$Sprite.play("Fall")
			
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.08)
			
	motion = move_and_slide(motion, UPWARDS)
	
	
