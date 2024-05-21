class_name  Enemy
extends Node2D

# Ponto de vida inimigo
@export var health: int = 10
@export var death_prefab: PackedScene
var damage_digite_prefab : PackedScene
@onready var damage_digit_marker =  $DamageDigiteMarker

func _ready():
	damage_digite_prefab = preload("res://misc/damage_digit.tscn")

# Dano recebido
func damage(amount: int) -> void:
	health -= amount
	print("Inimigo recebeu dano de ", amount, ". A vida total é de ", health)
	#Piscar node 
	modulate = Color.RED
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(self, "modulate", Color.WHITE, 0.3)
	
	# Criar DamageDigit

	var damage_digit = damage_digite_prefab.instantiate()
	damage_digit.value = amount
	if damage_digit_marker:
		damage_digit.global_position = damage_digit_marker.global_position
	else:
		damage_digit.global_position = global_position
	get_parent().add_child(damage_digit)
		
		
	#Processar morte
	if health <= 0: 
		die()
	
func die() -> void:
	if death_prefab:
		var death_object = death_prefab.instantiate()
		death_object.position = position
		get_parent().add_child(death_object)
		
	queue_free()	
		


