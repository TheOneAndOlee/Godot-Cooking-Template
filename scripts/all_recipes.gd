extends Node

var all_recipes : Array[recipe]
var path_to_recipes = "res://resources/recipes/"

func _ready() -> void:
	load_recipes()

func load_recipes() -> void:
	var directory_access = DirAccess.open(path_to_recipes)
	if (directory_access):
		directory_access.list_dir_begin()
		var file_name = directory_access.get_next()
		
		while (file_name != ""):
			if file_name.ends_with(".tres") or file_name.ends_with(".res"):
				var recipe_to_add = load(path_to_recipes + file_name) as recipe
				if (recipe_to_add):
					recipe_to_add.calculateSpecificity()
					all_recipes.append(recipe_to_add)
				else:
					print("Recipe File: " + file_name + " could not be loaded as a recipe")
			else:
				print("File in recipe directory is not a recipe resource: " + file_name)
			
			file_name = directory_access.get_next()
		
		#all_recipes.sort_custom(func(a : recipe, b : recipe): return a.specificity_score >= b.specificity_score)
		
		all_recipes.sort_custom(custom_sort)
		
	else:
		print("An error has occurred while accessing the recipe directory")

func custom_sort(a : recipe, b : recipe):
	if a.specificity_score > b.specificity_score:
		return true
	elif a.specificity_score < b.specificity_score:
		return false
	else:
		return randi_range(0, 1) == 0
