/mob/living/carbon/human/npc/average/standing
	staying = TRUE

/mob/living/carbon/human/npc/average/standing/Initialize(mapload)
	. = ..()

	AssignSocialRole(/datum/socialrole/usualmale)
