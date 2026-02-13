/obj/structure/the_word
	name = "message"
	icon = 'modular_zapoc/modules/imbued/icons/the_word.dmi'
	/// String for the message it displays
	var/word
	var/persistent_save = TRUE

/obj/structure/the_word/Initialize(mapload, message)
	. = ..()
	if(message)
		word = message

	icon_state = word

/obj/structure/the_word/proc/save_persistent()
	var/list/saved_data = list()
	var/turf/our_turf = get_turf(src)

	saved_data["the_word"] = word
	saved_data["x"] = our_turf.x
	saved_data["y"] = our_turf.y
	saved_data["z"] = our_turf.z

	return list(saved_data)
