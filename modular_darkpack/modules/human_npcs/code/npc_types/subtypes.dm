/mob/living/carbon/human/npc/bandit
	ai_controller = /datum/ai_controller/npc/bandit
	// my_backup_weapon_type = /obj/item/knife/vamp

/mob/living/carbon/human/npc/bandit/Initialize(mapload)
	. = ..()

	AssignSocialRole(/datum/socialrole/bandit)

/mob/living/carbon/human/npc/rich
	bloodquality = BLOOD_QUALITY_HIGH

/mob/living/carbon/human/npc/rich/Initialize(mapload)
	. = ..()
	AssignSocialRole(pick(/datum/socialrole/richmale, /datum/socialrole/richfemale))


/mob/living/carbon/human/npc/average

/mob/living/carbon/human/npc/average/Initialize(mapload)
	. = ..()
	AssignSocialRole(pick(/datum/socialrole/usualmale, /datum/socialrole/usualfemale))

/mob/living/carbon/human/npc/average/standing
	ai_controller = /datum/ai_controller/npc/stand_still

/mob/living/carbon/human/npc/average/standing/incel

/mob/living/carbon/human/npc/average/standing/incel/Initialize(mapload)
	. = ..()
	AssignSocialRole(/datum/socialrole/usualmale)

/mob/living/carbon/human/npc/average/club
	ai_controller = /datum/ai_controller/npc/stand_still/club


/mob/living/carbon/human/npc/poor
	bloodquality = BLOOD_QUALITY_LOW

/mob/living/carbon/human/npc/poor/Initialize(mapload)
	. = ..()
	AssignSocialRole(pick(/datum/socialrole/poormale, /datum/socialrole/poorfemale))
	ai_controller?.set_blackboard_key(BB_NPC_ATTRIBUTE_ENERGY, 5)


/mob/living/carbon/human/npc/illegal
	ai_controller = /datum/ai_controller/npc/stand_still

/mob/living/carbon/human/npc/police
	ai_controller = /datum/ai_controller/npc/police

/mob/living/carbon/human/npc/police/standing
	ai_controller = /datum/ai_controller/npc/stand_still

/mob/living/carbon/human/npc/endron
	ai_controller = /datum/ai_controller/npc/police

/mob/living/carbon/human/npc/endron/standing
	ai_controller = /datum/ai_controller/npc/stand_still
