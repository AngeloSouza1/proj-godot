extends CharacterBody2D

@export var speed: float = 1

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D




func _physics_process(delta: float) -> void:
	# Calcular direção
	var player_position =GameManager.player_position
	var difference = player_position - position
	var input_vector = difference.normalized()
	 
	# Movimento
	velocity = input_vector * speed * 100.0
	move_and_slide()

		# Girar sprite
	if input_vector.x > 0:
		sprite.flip_h = false
		# Desmarcar flip_h do Sprite2D
	elif input_vector.x < 0:  # Certifique-se de usar 'x' minúsculo aqui
		# Marcar flip_h do Sprite2D
		sprite.flip_h = true			


