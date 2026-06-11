/obj/effect/mapping_helpers/hide_atom
	var/atom_to_hide



/datum/component/hidden_atom
	// If AOE field automaticly rolls a entering mobs investigation
	var/automatic_roll = TRUE
	// var/discovery_range = DEFAULT_SIGHT_DISTANCE
	var/datum/proximity_monitor/advanced/hidden_atom/listener_field

/datum/component/hidden_atom/Initialize(automatic_roll = TRUE, discovery_range = DEFAULT_SIGHT_DISTANCE)
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE
	. = ..()
	src.automatic_roll = automatic_roll
	// src.discovery_range = discovery_range

	listener_field = new(parent, discovery_range, src)

/datum/component/hidden_atom/Destroy(force)
	. = ..()

	QDEL_NULL(listener_field)

#warn args dyscned soon
/datum/component/hidden_atom/proc/on_dice_roll(mob/living/roller, datum/storyteller_roll/roll_datum, output)
	SIGNAL_HANDLER

	return


/datum/proximity_monitor/advanced/hidden_atom
	edge_is_a_field = TRUE
	var/list/mob/living/tracking_mobs = list()
	var/datum/component/hidden_atom/hidden_component

/datum/proximity_monitor/advanced/hidden_atom/New(atom/_host, range, datum/component/hidden_component)
	. = ..()
	src.hidden_component = hidden_component

/datum/proximity_monitor/advanced/hidden_atom/field_turf_crossed(atom/movable/entered, turf/old_location, turf/new_location)
	. = ..()

	if(!isliving(entered))
		return
	var/mob/living/living_entered = entered

	RegisterSignal(hidden_component, COMSIG_LIVING_DICE_ROLLED, TYPE_PROC_REF(/datum/component/hidden_atom, on_dice_roll))

	if(hidden_component.automatic_roll)
		living_entered.generic_invesitage_roll()

/datum/proximity_monitor/advanced/hidden_atom/field_turf_uncrossed(atom/movable/gone, turf/old_location, turf/new_location)
	. = ..()

	if(!isliving(gone))
		return

	UnregisterSignal(hidden_component, COMSIG_LIVING_DICE_ROLLED)
