/mob/living/basic/mouse/vampire
	icon = 'modular_darkpack/modules/npc/icons/rat.dmi'
	body_color = "gray"

	bloodquality = BLOOD_QUALITY_LOW
	bloodpool = 1
	maxbloodpool = 1
	basic_mob_flags = FLAMMABLE_MOB

/mob/living/basic/mouse/vampire/create_a_new_rat()
	new /mob/living/basic/mouse/vampire(loc)

/mob/living/basic/mouse/vampire/rat
	name = "rat"
	desc = "They're a nasty, ugly, evil, disease-ridden rodent with anger issues."

	gold_core_spawnable = HOSTILE_SPAWN
	melee_damage_lower = 3
	melee_damage_upper = 5
	obj_damage = 5
	maxHealth = 15
	health = 15

	ai_controller = /datum/ai_controller/basic_controller/mouse/rat

/mob/living/basic/mouse/vampire/rat/make_tameable()
	return

/mob/living/basic/mouse/vampire/rat/create_a_new_rat()
	new /mob/living/basic/mouse/vampire/rat(loc)
