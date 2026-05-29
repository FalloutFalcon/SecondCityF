/datum/storyteller_roll/nightmares
	bumper_text = "nightmares"
	applicable_stats = list(STAT_PERMANENT_WILLPOWER)
	difficulty = 7
	roll_output_type = ROLL_PRIVATE

// V20 p. 485
/datum/quirk/darkpack/nightmares
	name = "Nightmares"
	desc = {"You experience horrendous nightmares every time you sleep, and memories of them haunt you during your waking hours.
		Upon awakening, you must make a Willpower roll (difficulty 7) or lose a die on all actions for that night."}
	value = -1
	icon = FA_ICON_BED_PULSE
	var/roll_result

/datum/quirk/darkpack/nightmares/add(client/client_source)
	. = ..()

	// Let us spawn in before the roll for flavor... (and to make sure we have our stats set....?)
	spawn(1 SECONDS)
		var/datum/storyteller_roll/nightmares/roll_datum = new()

		roll_result = roll_datum.st_roll(quirk_holder)
		if(roll_result != ROLL_SUCCESS)
			to_chat(quirk_holder, span_warning("Your still recovering from your sleeps horrendous nightmares. They still linger in your thoughts. Tonight will be painful."))
			// RegisterSignal to the signal from https://github.com/DarkPack13/SecondCity/pull/987

/datum/quirk/darkpack/nightmares/proc/on_roll()
	return
