extends Node

@export var object_templates: Array[PackedScene]


func _input(event):
	# Verifica se o evento é um clique do mouse
	if event is InputEventMouseButton:
		# Verifica se o botão esquerdo do mouse foi pressionado (button_index = 1)
		if event.button_index == 1:
			# Verifica se o botão foi pressionado
			if event.pressed:
				spawn_object(event.position)


func spawn_object(position: Vector2) -> void:
	var index: int = randi_range(0, object_templates.size() - 1)
	var object_template = object_templates[index] 
	var object: RigidBody2D = object_template.instantiate()
	object.position = position
	add_child(object)
	
