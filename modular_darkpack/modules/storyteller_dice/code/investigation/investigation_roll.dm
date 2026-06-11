#define COMSIG_KB_LIVING_SEARCH_DOWN "keybinding_living_search_down"

/mob/living
	#warn dont leave here.
	var/datum/storyteller_roll/investigation/automatic/invesitage_roll


/datum/keybinding/living/search
	hotkey_keys = list("ShiftG")
	name = "search"
	full_name = "Search"
	description = "Search the area around you and roll Perception + Investigation."
	keybind_signal = COMSIG_KB_LIVING_SEARCH_DOWN

/datum/keybinding/living/search/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	var/mob/living/living_mob = user.mob
	living_mob.search_area()


/mob/living/proc/search_area()
	generic_invesitage_roll()

/mob/living/proc/generic_invesitage_roll(automatic, atom/target)
	if(!invesitage_roll)
		invesitage_roll = new()
	var/roll_result = invesitage_roll.st_roll(src, target)

	return roll_result


/datum/storyteller_roll/investigation/automatic
	reroll_cooldown = 1 SCENES

#undef COMSIG_KB_LIVING_SEARCH_DOWN
