/mob/living/carbon/human/npc/proc/realistic_say(message, stop_moving = TRUE)
	if(stop_moving)
		GLOB.move_manager.stop_looping(src)

	if (!message)
		return
	if (stat >= HARD_CRIT)
		return
	if (is_talking)
		return
	is_talking = TRUE

	addtimer(CALLBACK(src, PROC_REF(start_talking), message), 1 SECONDS)

/mob/living/carbon/human/npc/proc/start_talking(message)
	ADD_TRAIT(src, TRAIT_THINKING_IN_CHARACTER, CURRENTLY_TYPING_TRAIT)
	create_typing_indicator()
	var/typing_delay = round(length_char(message) * 0.5)
	addtimer(CALLBACK(src, PROC_REF(finish_talking), message), max(3 SECONDS, typing_delay))

/mob/living/carbon/human/npc/proc/finish_talking(message)
	remove_typing_indicator()
	REMOVE_TRAIT(src, TRAIT_THINKING_IN_CHARACTER, CURRENTLY_TYPING_TRAIT)
	say(message)
	is_talking = FALSE
