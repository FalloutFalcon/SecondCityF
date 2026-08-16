// AREAS
/mob/living/update_ambience_area(area/new_area)
	. = ..()
	if(!client)
		return
	if(!new_area.show_area_name)
		return
	if(last_shown_area_name == new_area.name)
		return

	var/atom/movable/screen/main_maptext/T = locate() in client.screen
	if(T)
		return

	last_shown_area_name = new_area.name
	client.show_main_maintext_overlay(new_area.name)
