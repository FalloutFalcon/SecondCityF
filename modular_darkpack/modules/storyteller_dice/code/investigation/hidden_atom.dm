/obj/effect/mapping_helpers/hide_atom
	var/atom_to_hide



/datum/component/hidden_atom
	// If AOE field automaticly rolls a entering mobs investigation
	var/automatic_roll = TRUE
	var/discovery_range = DEFAULT_SIGHT_DISTANCE

/datum/component/hidden_atom/New(automatic_roll = TRUE, discovery_range = DEFAULT_SIGHT_DISTANCE)
	. = ..()
	src.automatic_roll = automatic_roll
	src.discovery_range = discovery_range



/datum/proximity_monitor/advanced/automatic_investigation
	edge_is_a_field = TRUE
	var/list/mob/living/tracking_mobs = list()

/datum/proximity_monitor/advanced/automatic_investigation/New(atom/_host, range)
	. = ..()

/datum/proximity_monitor/advanced/automatic_investigation/field_turf_crossed(atom/movable/entered, turf/old_location, turf/new_location)
	. = ..()

	if(!isliving(entered))
		return

/datum/proximity_monitor/advanced/automatic_investigation/field_turf_uncrossed(atom/movable/gone, turf/old_location, turf/new_location)
	. = ..()

	if(!isliving(entered))
		return

	