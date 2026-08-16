/atom/movable/screen/area_text
	screen_loc = "CENTER:16,TOP:-42"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	maptext_width = 340
	maptext_height = 64
	maptext_x = -170
	maptext = ""
	layer = SCREENTIP_LAYER
	alpha = 0
	var/timer_id

/atom/movable/screen/area_text/Destroy()
	deltimer(timer_id)
	return ..()

// Main space allocated for maptext display for consistancy
/atom/movable/screen/main_maptext
	maptext_height = 64
	maptext_width = 512
	layer = FLY_LAYER
	plane = FULLSCREEN_PLANE
	appearance_flags = APPEARANCE_UI_IGNORE_ALPHA
	screen_loc = "LEFT+1,TOP-3"

/// Displays a typewriter-style spawn text overlay that includes station/area/job name and time
/client/proc/show_spawn_text_overlay()
	var/mob_name = mob.name
	var/job_title = mob.mind?.assigned_role.title || "Unknown"

	var/station_name = station_name()
	var/area_name = get_area_name(mob, format_text = TRUE) || "Unknown Location"
	var/time_date = server_timestamp(format = "YYYY-MM-DD hh:mm:ss", ic_time = TRUE)

	var/text = {"
		[mob_name] - [job_title]
		[station_name]
		[area_name]
		[time_date]
	"}
	text = uppertext(text)

	show_main_maintext_overlay(text)


/client/proc/show_main_maintext_overlay(text, duration = 5 SECONDS, typewriter = TRUE)
	set waitfor = FALSE

	var/atom/movable/screen/main_maptext/main_maptext = new()
	screen += main_maptext
	animate(main_maptext, alpha = 255, time = 1 SECONDS)

	if(typewriter)
		for(var/i in 1 to length_char(text) + 1)
			if(QDELETED(main_maptext) || QDELETED(src))
				return
			main_maptext.maptext = MAPTEXT_PIXELLARI(copytext_char(text, 1, i))
			sleep(1)
	else
		main_maptext.maptext = MAPTEXT_PIXELLARI(text)
		sleep(1 * length(text))


	addtimer(CALLBACK(src, PROC_REF(fade_main_maptext_overlay), src, main_maptext), duration)

/client/proc/fade_main_maptext_overlay(client/player_client, atom/movable/screen/main_maptext)
	if(QDELETED(main_maptext))
		return
	animate(main_maptext, alpha = 0, time = 0.5 SECONDS)
	sleep(5)
	if(player_client && !QDELETED(main_maptext))
		player_client.screen -= main_maptext
	qdel(main_maptext)
