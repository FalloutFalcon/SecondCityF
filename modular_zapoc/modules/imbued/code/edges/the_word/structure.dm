/proc/good_the_word_location(turf/T)
	if(!T)
		. = FALSE
	else if(!(isfloorturf(T) || iswallturf(T)))
		. = FALSE
	else
		. = TRUE

/obj/structure/the_word
	name = "engraved message"
	desc = "A message from a past traveler."
	icon = null
	layer = LATTICE_LAYER
	anchored = TRUE
	max_integrity = 30
	/// String for the message it displays
	var/word
	var/persistent_save = TRUE

/obj/structure/the_word/Initialize(mapload, message)
	. = ..()
	if(message)
		word = message

	if(!good_the_word_location(get_turf(src)))
		persistent_save = FALSE
		return INITIALIZE_HINT_QDEL

	update_appearance(UPDATE_ICON)


/obj/structure/the_word/update_icon(updates)
	. = ..()

	remove_alt_appearance("imbued_message")
	var/image/imbued_image = image('modular_zapoc/modules/imbued/icons/the_word.dmi', src, word, layer = ABOVE_NORMAL_TURF_LAYER)
	//imbued_image.override = TRUE
	add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/imbued, "imbued_message", imbued_image)

/datum/atom_hud/alternate_appearance/basic/imbued
	add_ghost_version = TRUE
	signals_registering = list(
		COMSIG_MOB_GHOSTIZED,
		COMSIG_MOB_MIND_TRANSFERRED_INTO,
		COMSIG_MOB_MIND_TRANSFERRED_OUT_OF,
		COMSIG_LIVING_GAINING_SPLAT,
		COMSIG_LIVING_LOSE_SPLAT,
	)

/datum/atom_hud/alternate_appearance/basic/imbued/mobShouldSee(mob/M)
	if(get_imbued_splat(M))
		return TRUE
	return FALSE


/obj/structure/the_word/proc/save_persistent()
	var/list/saved_data = list()
	var/turf/our_turf = get_turf(src)

	saved_data["the_word"] = word
	saved_data["x"] = our_turf.x
	saved_data["y"] = our_turf.y
	saved_data["z"] = our_turf.z

	return list(saved_data)
