extends Control

@onready var ingredient_slot_1 = $VBoxContainer/Ingredient1
@onready var ingredient_slot_2 = $VBoxContainer/Ingredient2
@onready var ingredient_slot_3 = $VBoxContainer/Ingredient3
@onready var ingredient_slot_4 = $VBoxContainer/Ingredient4
@onready var ingredient_slot_5 = $VBoxContainer/Ingredient5

@onready var cookButton = $VBoxContainer/CookButton

@onready var result_slot = $VBoxContainer/Result

var ingredientTexts: Array[RichTextLabel]

func _ready() -> void:
	ingredientTexts.append(ingredient_slot_1)
	ingredientTexts.append(ingredient_slot_2)
	ingredientTexts.append(ingredient_slot_3)
	ingredientTexts.append(ingredient_slot_4)
	ingredientTexts.append(ingredient_slot_5)


func _on_button_pressed() -> void:
	var input_tags: Dictionary[String, float]
	var item_names: Dictionary[String, int]
	for ingredient in ingredientTexts:
		if (ingredient.currentIngredient):
			#print(ingredient.currentIngredient.name)
			var currIngredient = ingredient.currentIngredient
			
			if (item_names.has(currIngredient.name)):
				item_names[currIngredient.name] += 1
			else:
				item_names[currIngredient.name] = 1
			
			for tag in currIngredient.tags:
				#print("Adding tag: %s with quantity: %s" % [tag, currIngredient.tags[tag]])
				
				if (input_tags.has(tag)):
					input_tags[tag] += currIngredient.tags[tag]
				else:
					input_tags[tag] = currIngredient.tags[tag]
	
	# output should be a recipe
	var output = CookingManager.cook_recipe(input_tags, item_names)
	if (output):
		result_slot.text = output.dish_name
	else:
		result_slot.text = "No Dish Found"
