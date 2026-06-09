/mob/living/carbon/human/npc/average

/mob/living/carbon/human/npc/average/Initialize(mapload)
	. = ..()

	var/datum/socialrole/assign_role = pick(/datum/socialrole/usualmale, /datum/socialrole/usualfemale)
	AssignSocialRole(assign_role)
