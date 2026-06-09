#warn move life to ai controller
/datum/ai_controller/npc/stand_still/club


/mob/living/carbon/human/npc/average/club/Life(seconds_per_tick)
	. = ..()

	if(stat >= UNCONSCIOUS)
		return
	if(!SPT_PROB_RATE(5, seconds_per_tick))
		return

	INVOKE_ASYNC(src, PROC_REF(dance_at_jukebox))

/mob/living/carbon/human/npc/average/club/proc/dance_at_jukebox()
	var/hasjukebox = FALSE
	for(var/obj/machinery/jukebox/jukebox in range(7, src))
		// Hacky check for if it's currently playing
		if(jukebox.static_power_usage != ACTIVE_POWER_USE)
			continue
		hasjukebox = TRUE
		break

	if(hasjukebox)
		if(prob(50))
			dancefirst(src)
		else
			dancesecond(src)
