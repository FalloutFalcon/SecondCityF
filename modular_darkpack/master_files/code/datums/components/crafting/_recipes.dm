/datum/crafting_recipe
	// STORYTELER_STATS
	/// Stat define/typepath required for this recipe.
	var/datum/st_stat/craft_roll_attribute = STAT_WITS
	/// Stat define/typepath required for this recipe.
	var/datum/st_stat/craft_roll_ability = STAT_CRAFTS
	/// If set, the difficulty of the roll, if unset, no roll is required.
	var/roll_difficulty = null
	/// You need ATLEAST this many dots in a skill to craft.
	var/ability_dots_minimum = null // Null by default means it wont even try to get stats. as if its 0 or less, it only catches people with low stats AND a debuff and i dont really care.

// STORYTELER_STATS
/datum/crafting_recipe/proc/is_recipe_available(mob/user)
	SHOULD_CALL_PARENT(TRUE)

	if(craft_roll_ability && !isnull(ability_dots_minimum))
		var/mob/living/living_user = astype(user)
		if(!living_user)
			return FALSE
		if(living_user.st_get_stat(craft_roll_ability) < ability_dots_minimum)
			return FALSE

	return TRUE
