extends CharacterBody2D

const SPEED = 300.0

var target_position: Vector2
var moving_to_click := false

func _ready():
	target_position = global_position

func _physics_process(delta: float) -> void:
	
	# =========================
	# MOVIMENTO POR TECLADO
	# =========================
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_axis("ui_left", "ui_right")
	input_vector.y = Input.get_axis("ui_up", "ui_down")
	
	# Se apertar teclado, cancela movimento por clique
	if input_vector != Vector2.ZERO:
		moving_to_click = false
		input_vector = input_vector.normalized()
		velocity = input_vector * SPEED
	
	# =========================
	# MOVIMENTO POR MOUSE
	# =========================
	elif moving_to_click:
		var direction = (target_position - global_position)
		
		if direction.length() > 5:
			velocity = direction.normalized() * SPEED
		else:
			moving_to_click = false
			velocity = Vector2.ZERO
	
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()


func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		target_position = get_global_mouse_position()
		moving_to_click = true
