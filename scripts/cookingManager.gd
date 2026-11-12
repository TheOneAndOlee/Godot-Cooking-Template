extends Node

func cook_recipe(input_tags : Dictionary[String, float], item_names : Dictionary[String, int]):
	
	var cleaned_tags : Dictionary[String, float]
	
	# Clean up tags
	for tag in input_tags:
		if (cleaned_tags.has(tag)):
			cleaned_tags[tag] += input_tags[tag]
		else:
			cleaned_tags[tag] = input_tags[tag]
	
	for curr_recipe in all_recipes.all_recipes:
		if (_is_valid_recipe(curr_recipe, cleaned_tags, item_names)):
			return curr_recipe
	
	return null

func _is_valid_recipe(curr_recipe : recipe, input_tags : Dictionary[String, float], item_names : Dictionary[String, int]):
	
	### CHECK FOR BANNED INGREDIENTS
	for banned_item in curr_recipe.bannedIngredients:
		if (not item_names.has(banned_item)):
			continue
		
		#print("Banned Item is: %s with count %s. Current has count %s" % [banned_item, curr_recipe.bannedIngredients[banned_item], item_names.get(banned_item)])
		
		if (item_names.get(banned_item) >= curr_recipe.bannedIngredients[banned_item]):
			return false
	
	### CHECK FOR REQUIRED INGREDIENTS
	for req_item in curr_recipe.requiredIngredients:
		print("Checking item: %s with quantity %s" % [req_item, curr_recipe.requiredIngredients[req_item]])
		
		if (not item_names.has(req_item) or item_names.get(req_item) < curr_recipe.requiredIngredients.get(req_item)):
			return false
		#else:
			#print("Actual: %s with quantity %s" % [req_item, item_names[req_item]])
	
	### CHECK FOR REQUIRED TAGS
	for tag in curr_recipe.tags:
		#print("Checking tag: %s with quantity %s" % [tag, input_tags[tag]])
		if (not input_tags.has(tag) or input_tags.get(tag) < curr_recipe.tags.get(tag)):
			return false
	
	return true
