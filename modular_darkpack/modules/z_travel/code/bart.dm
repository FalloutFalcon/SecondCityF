GLOBAL_LIST_EMPTY(bart_endpoints)
GLOBAL_LIST_EMPTY(bart_seat_points)

// A system of interconnected tranfser points designed for easily linking MANY points into one network
/obj/structure/transfer_point_bart
	name = "transfer point"
	icon = 'modular_darkpack/modules/z_travel/icons/z_travel.dmi'
	icon_state = "matrix_go"

	var/network_id = "main_line"
	var/custom_name

/obj/structure/transfer_point_bart/Initialize(mapload)
	. = ..()
	GLOB.bart_endpoints += src

/obj/structure/transfer_point_bart/Destroy(force)
	. = ..()
	GLOB.bart_endpoints -= src

/obj/structure/transfer_point_bart/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(Adjacent(user))
		show_options(user)

/obj/structure/transfer_point_bart/proc/show_options(mob/user)
	var/choices = list()
	var/duplicate_names = list()
	for(var/obj/structure/transfer_point_bart/other_point in GLOB.bart_endpoints)
		if(!is_endpoint_valid(other_point))
			continue
		var/using_name = other_point.get_stop_name()
		if(!duplicate_names[using_name])
			duplicate_names[using_name] = 1
		else
			duplicate_names[using_name]++
			using_name += " ([duplicate_names[using_name]])"
		choices[using_name] = other_point

	if(!length(choices))
		to_chat(user, span_warning("[src] is not currently servicing any other lines."))
		return

	var/user_choice = tgui_input_list(user, "Choose travel destination", src, sort_list(choices))
	if(!user_choice)
		return

	var/obj/structure/transfer_point_bart/endpoint = choices[user_choice]
	if(!endpoint)
		return

	if(isliving(user))
		user.visible_message(
			span_notice("[user] begins stepping onto [src]"),
			span_notice("You begin stepping onto [src]")
		)
		if(!do_after(user, 5 SECONDS, src))
			return
		user.overlay_fullscreen("fast_travel", /atom/movable/screen/fullscreen/blind)
		ADD_TRAIT(user, TRAIT_IMMOBILIZED, "fast_travel")
		var/obj/bus_seat = pick(GLOB.bart_seat_points)
		if(bus_seat)
			user.forceMove(get_turf(bus_seat))
		send_tip_of_the_round(user, source = "Fast Travel")
		sleep(get_travel_time(endpoint))
		REMOVE_TRAIT(user, TRAIT_IMMOBILIZED, "fast_travel")
		user.clear_fullscreen("fast_travel", animated = 1 SECONDS)

	transfer_atom(user, endpoint)

/obj/structure/transfer_point_bart/proc/get_endpoints(mob/user)
	var/options = list()
	for(var/obj/structure/transfer_point_bart/other_point in GLOB.bart_endpoints)
		if(!is_endpoint_valid(other_point))
			continue
		options += other_point
	return options

/obj/structure/transfer_point_bart/proc/is_endpoint_valid(obj/structure/transfer_point_bart/endpoint)
	if(src == endpoint)
		return FALSE
	if(network_id != endpoint.network_id)
		return FALSE
	return TRUE

/obj/structure/transfer_point_bart/proc/get_stop_name()
	if(custom_name)
		return custom_name

	var/area/my_area = get_area(src)
	return my_area.name

/obj/structure/transfer_point_bart/proc/transfer_atom(atom/movable/arrived, obj/structure/transfer_point_bart/endpoint)
	return arrived.forceMove(get_turf(endpoint))

/obj/structure/transfer_point_bart/proc/get_travel_time(obj/structure/transfer_point_bart/endpoint)
	if(!is_valid_z_level(src, endpoint))
		return 30 SECONDS // We arent a connected z level so its a hardcoded distance

	var/dist_to_target = min(round(get_dist(src, endpoint) * 2, 10), 10 SECONDS)
	return (10 SECONDS) + dist_to_target


/obj/structure/transfer_point_bart/bus
	name = "bus line"
	icon_state = "busstop"
	icon = 'modular_darkpack/modules/decor/icons/road_signs.dmi'

/obj/structure/transfer_point_bart/metro
	name = "metro line"
	icon_state = null
	icon = 'icons/obj/fluff/bus.dmi'

/*
/proc/avoid_duplicate_keys(list/atom/atom_list)
	var/choices = list()
	var/duplicate_names = list()
	for(var/atom/entry in atom_list)
		var/using_name = entry.name
		if(!duplicate_names[using_name])
			duplicate_names[using_name] = 1
		else
			duplicate_names[using_name]++
			using_name += " ([duplicate_names[using_name]])"
		choices[using_name] = entry

	return choices
*/

/obj/structure/fluff/bus/passable/seat/bart

/obj/structure/fluff/bus/passable/seat/bart/Initialize(mapload)
	. = ..()
	GLOB.bart_seat_points += src

/obj/structure/fluff/bus/passable/seat/bart/Destroy(force)
	. = ..()
	GLOB.bart_seat_points -= src

/area/centcom/bart_system
	name = "bus"
	static_lighting = FALSE
	base_lighting_alpha = 255
