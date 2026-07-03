ADMIN_VERB(delay_next_round_pregame, R_SERVER, "Delay Next Round's Pre-Game.", "Delay the game start.", ADMIN_CATEGORY_SERVER)
	var/newtime = tgui_input_number(
		user,
		"Set a new time in seconds. Set -1 for indefinite delay.",
		"Set Delay",
		default = SSticker.start_at * 10,
		max_value = INFINITY,
		min_value = -1
	)
	if(isnull(newtime))
		return
	newtime = round(newtime/10)
	text2file(num2text(newtime), "data/delay_next_round.txt")
	BLACKBOX_LOG_ADMIN_VERB("Delay Next Round's Pre-Game.")

/// Check to see if we need to delay the round because the last round told us to.
/datum/controller/subsystem/ticker/proc/check_preround_delay()
	var/last_round_file = file2text("data/delay_next_round.txt")
	if(!last_round_file)
		return

	fdel("data/delay_next_round.txt")

	var/time_from_txt = text2num(last_round_file)
	if(!time_from_txt)
		return
	if(SSticker.current_state > GAME_STATE_PREGAME)
		return
	SSticker.SetTimeLeft(time_from_txt)
	SSticker.start_immediately = FALSE
	if(time_from_txt < 0)
		to_chat(world, span_infoplain("<b>The game start has been delayed.</b>"), confidential = TRUE)
		log_admin("Last round has delayed the round start.")
	else
		to_chat(world, span_infoplain(span_bold("The game will start in [DisplayTimeText(time_from_txt)].")), confidential = TRUE)
		SEND_SOUND(world, sound('sound/announcer/default/attention.ogg'))
		log_admin("Last round set the pre-game delay to [DisplayTimeText(time_from_txt)].")
