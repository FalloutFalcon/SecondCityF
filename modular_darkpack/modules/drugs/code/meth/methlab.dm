/datum/storyteller_roll/scavage_methlab
	bumper_text = "scavange lab"
	applicable_stats = list(STAT_PERCEPTION, STAT_SCIENCE)

/obj/structure/methlab
	name = "chemical laboratory"
	desc = "\"Jesse... It's not about style, it's about science...\""
	icon = 'modular_darkpack/modules/deprecated/icons/32x48.dmi'
	icon_state = "methlab"
	anchored = TRUE
	var/scavenged = FALSE

/obj/structure/methlab/movable
	name = "movable chemical lab"
	desc = "Not an RV, but it moves..."
	anchored = FALSE


/obj/structure/methlab/Initialize(mapload)
	. = ..()
	
/obj/structure/methlab/attack_hand(mob/living/user, list/modifiers)
	. = ..()

