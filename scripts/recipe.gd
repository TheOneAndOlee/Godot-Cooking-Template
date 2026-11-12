class_name recipe extends Resource

@export var tags : Dictionary[String, float]
@export var requiredIngredients : Dictionary[String, int]
@export var bannedIngredients : Dictionary[String, int]
@export var specificity_score : float
@export var dish_name : String

func calculateSpecificity():
	specificity_score = 0.0
	for tag in tags:
		specificity_score += tags[tag]
	
	#print("%s has a specificity score of: %s" % [dish_name, specificity_score])
