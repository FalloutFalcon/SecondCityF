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
			span_notice("[user] begins stepping onto [src]."),
			span_notice("You begin stepping onto [src].")
		)
		if(!do_after(user, 5 SECONDS, src))
			return

		user.overlay_fullscreen("fast_travel", /atom/movable/screen/fullscreen/blind)
		user.add_traits(list(TRAIT_IMMOBILIZED, TRAIT_PACIFISM), "fast_travel")

		var/obj/bus_seat = pick(GLOB.bart_seat_points)
		if(bus_seat)
			user.forceMove(get_turf(bus_seat))
		send_tip_of_the_round(user, source = "Fast Travel")

		sleep(get_travel_time(endpoint))
		user.remove_traits(list(TRAIT_IMMOBILIZED, TRAIT_PACIFISM), "fast_travel")
		user.clear_fullscreen("fast_travel", animated = 5 SECONDS)

	endpoint.transfer_atom(user)

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

/obj/structure/transfer_point_bart/proc/transfer_atom(atom/movable/arrived)
	return arrived.forceMove(get_turf(src))

/obj/structure/transfer_point_bart/proc/get_travel_time(obj/structure/transfer_point_bart/endpoint)
	if(!is_valid_z_level(src, endpoint))
		return 30 SECONDS // We arent a connected z level so its a hardcoded distance

	var/dist_to_target = min(round(get_dist(src, endpoint) * 2, 10), 10 SECONDS)
	return (10 SECONDS) + dist_to_target


/obj/structure/transfer_point_bart/bus
	name = "bus line"
	desc = "A bus stop apart of the " + CITY_NAME + " public transit system."
	icon_state = "busstop"
	icon = 'modular_darkpack/modules/decor/icons/road_signs.dmi'
	COOLDOWN_DECLARE(swap_state_cooldown)
	var/bus_at_stop = TRUE
	var/static/image/active_overlay

/obj/structure/transfer_point_bart/bus/Initialize(mapload)
	. = ..()
	if(!active_overlay)
		active_overlay = image(icon_state = "arrow", icon = 'icons/hud/screen_gen.dmi')
		active_overlay.pixel_y += 16
		active_overlay.color = COLOR_BLUE_LIGHT

	START_PROCESSING(SSobj, src)

/obj/structure/transfer_point_bart/bus/Destroy(force)
	. = ..()
	if(prob(50))
		toggle_state()
	STOP_PROCESSING(SSobj, src)

/obj/structure/transfer_point_bart/bus/process(seconds_per_tick)
	if(COOLDOWN_FINISHED(src, swap_state_cooldown))
		toggle_state()

/obj/structure/transfer_point_bart/bus/examine(mob/user)
	. = ..()
	var/time_left = round(COOLDOWN_TIMELEFT(src, swap_state_cooldown)/10)
	if(time_left)
		. += "The bus has [time_left]s left before it [bus_at_stop ? "leaves" : "arrives"]."

/obj/structure/transfer_point_bart/bus/proc/toggle_state()
	bus_at_stop = !bus_at_stop

	COOLDOWN_START(src, swap_state_cooldown, rand(5 MINUTES, 10 MINUTES))
	if(bus_at_stop)
		add_overlay(active_overlay)
	else
		cut_overlay(active_overlay)


/obj/structure/busstop
	name = "bus shelter"
	desc = "A metal structure providing shelter from the elements while waiting for your bus to arrive."
	icon_state = "busstop"
	icon = 'modular_darkpack/modules/z_travel/icons/busstop.dmi'

/*
/obj/structure/transfer_point_bart/metro
	name = "metro line"
	icon_state = null
	icon = 'icons/obj/fluff/bus.dmi'
*/

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
