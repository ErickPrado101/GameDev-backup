extends CharacterBody2D

const SPEED = 300.0

var target_position: Vector2
var moving_to_click := false

@onready var anim = $AnimatedSprite2D

func _ready():
	target_position = global_position

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_axis("ui_left", "ui_right")
	input_vector.y = Input.get_axis("ui_up", "ui_down")
	
	if input_vector != Vector2.ZERO:
		moving_to_click = false
		velocity = input_vector.normalized() * SPEED
	elif moving_to_click:
		var direction = target_position - global_position
		if direction.length() > 5:
			velocity = direction.normalized() * SPEED
		else:
			moving_to_click = false
			velocity = Vector2.ZERO
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()
	update_animation()


func update_animation():
	if velocity.length() < 5:
		anim.play("idle")
		return
	
	if velocity.x != 0:
		if velocity.x > 0:
			anim.play("ui_right")
			anim.flip_h = false
		else:
			anim.play("ui_right")
			anim.flip_h = true
	else:
		if velocity.y < 0:
			anim.play("ui_right")
			anim.flip_h = false
		else:
			anim.play("ui_right")
			anim.flip_h = true


func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		target_position = get_global_mouse_position()
		moving_to_click = true
