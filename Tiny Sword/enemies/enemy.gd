class_name  Enemy
extends Node2D

# Ponto de vida inimigo
@export var health: int = 10

# Dano recebido
func damage(amount: int) -> void:
	health -= amount
	print("Inimigo recebeu dano de ", amount, ". A vida total é de ", health)
