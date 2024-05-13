extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var speed: float = 3

@onready var sprite: Sprite2D = $Sprite2D

var is_running: bool = false


func _physics_process(delta: float) -> void:
	# Obter o input_Vector 
	var input_vector = Input.get_vector("move_left","move_right","move_up","move_down")
	
	# Apagar deadzone do input vector
	var deadzone = 0.15
	if abs(input_vector.x) < 0.15:
		input_vector.x = 0.0
	if abs(input_vector.y) < 0.15:
		input_vector.y = 0.0
	
	
	print(input_vector)
	# Modificar a velocidade
	var	target_velocity = input_vector * speed * 100.0
	velocity = lerp(velocity, target_velocity, 0.05)
	move_and_slide()	
		
	# Atualizar a is_runnig
	var was_runnig = is_running
	is_running = not input_vector.is_zero_approx()	
		
	# Tocar animação
	if was_runnig != is_running:
		if is_running:
			animation_player.play("run")
		else:
			animation_player.play("idle")
	
	# Girar sprite
	if input_vector.x > 0:
		sprite.flip_h = false
		# Desmarcar flip_h do Sprite2D
	elif input_vector.x < 0:  # Certifique-se de usar 'x' minúsculo aqui
		# Marcar flip_h do Sprite2D
		sprite.flip_h = true

		
		

