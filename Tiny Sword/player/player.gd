extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var speed: float = 3
@onready var sprite: Sprite2D = $Sprite2D

var is_running: bool = false
var is_attacking: bool = false
var attack_cooldown: float= 0.0

func _process(delta: float) -> void:
	# Atualizar temporizador do ataque
	if is_attacking:
		attack_cooldown -= delta  # 0.06 -  0.016 = 0.0584 exemplo
		if attack_cooldown <= 0.0: 
			is_attacking = false
			is_running = false
			animation_player.play("idle")

func _physics_process(delta: float) -> void:
	# Obter o input_Vector 
	var input_vector = Input.get_vector("move_left","move_right","move_up","move_down")
	
	# Apagar deadzone do input vector
	var deadzone = 0.15
	if abs(input_vector.x) < 0.15:
		input_vector.x = 0.0
	if abs(input_vector.y) < 0.15:
		input_vector.y = 0.0
	
	

	# Modificar a velocidade
	var	target_velocity = input_vector * speed * 100.0
	if is_attacking:
		target_velocity *= 0.25
	velocity = lerp(velocity, target_velocity, 0.05)
	move_and_slide()	
		
	# Atualizar a is_runnig
	var was_runnig = is_running
	is_running = not input_vector.is_zero_approx()	
		
	# Tocar animação
	if not is_attacking:
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

# Ataque
	if Input.is_action_just_pressed("attack"):
		attack()
		
		
func attack() -> void:
	if is_attacking:
		return

	# Tocar animação
	animation_player.play("attack_side_1")
	
	# Configurar temporizador
	attack_cooldown = 0.6
	
	# Marcar ataque
	is_attacking = true
