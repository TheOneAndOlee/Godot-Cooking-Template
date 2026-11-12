extends Node

@export var currentIngredient : ingredient

func _ready() -> void:
	_update_text()

func _update_text():
	if (currentIngredient):
		self.text = currentIngredient.name
	else:
		self.text = "N/A"

func set_ingredient(ingredient_to_set : ingredient):
	self.text = "Ingredient: " + ingredient_to_set.ingredient_name
