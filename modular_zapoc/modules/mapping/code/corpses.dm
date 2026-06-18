// ENDRON RUIN
/obj/effect/mob_spawn/corpse/human/endron
	outfit = /datum/outfit/job/vampire/pentex_sec

/datum/outfit/job/vampire/pentex_scientist_corpse
	name = MAIN_EVIL_COMPANY + " Scientist Corpse"

	uniform = /obj/item/clothing/under/vampire/pentex_turtleneck
	suit = /obj/item/clothing/suit/vampire/labcoat
	gloves = /obj/item/clothing/gloves/vampire/latex
	shoes = /obj/item/clothing/shoes/vampire
	l_pocket = /obj/item/smartphone

/obj/effect/mob_spawn/corpse/human/endron/security
	outfit = /datum/outfit/job/vampire/pentex_scientist_corpse
	outfit_override = list("r_pocket" = /obj/item/stack/dollar/rand)

/obj/effect/mob_spawn/corpse/human/endron/cbrn
	outfit = /datum/outfit/job/vampire/pentex_scientist_corpse/cbrn

/datum/outfit/job/vampire/pentex_scientist_corpse/cbrn
	name = MAIN_EVIL_COMPANY + " Scientist Corpse (CBRN)"

	shoes = /obj/item/clothing/shoes/vampire/jackboots
	head = /obj/item/clothing/head/hooded/heisenberg_hood
	r_pocket = /obj/item/stack/dollar/rand
	gloves = /obj/item/clothing/gloves/vampire/latex
	suit = /obj/item/clothing/suit/hooded/heisenberg
	glasses = /obj/item/clothing/glasses/vampire/sun
	mask = /obj/item/clothing/mask/gas/explorer/pentex/endron

/obj/effect/mob_spawn/corpse/human/garou
	outfit = /datum/outfit/job/vampire/guardian
	outfit_override = list("r_pocket" = /obj/item/stack/dollar/rand)

/obj/effect/mob_spawn/corpse/human/garou/create(mob/mob_possessor, newname, apply_prefs)
	new /obj/effect/mapping_helpers/splat_applicator/garou(get_turf(src))
	. = ..()

/obj/effect/mob_spawn/corpse/human/gray_masses
	brute_damage = 1000

/obj/effect/mob_spawn/corpse/human/legioninfested/skeleton/charred/gray_masses
	name = "charred fungal skeleton"

/obj/effect/mob_spawn/corpse/human/gray_masses/Initialize(mapload)
	outfit = select_outfit()
	return ..()

/obj/effect/mob_spawn/corpse/human/gray_masses/proc/select_outfit()
	var/corpse_theme = pick_weight(list(
		pick(list(
			"Scientist",
			"CBRN",
		)) = 50,
		"Security" = 25,
		"Garou" = 15,
		pick(list(
			"Ciz1",
			"Ciz2",
			"Ciz3",
			"Ciz4",
		)) = 5,
	))

	switch(corpse_theme)
		if("Scientist")
			return /datum/outfit/job/vampire/pentex_scientist_corpse
		if("CBRN")
			return /datum/outfit/job/vampire/pentex_scientist_corpse/cbrn
		if("Security")
			return /obj/effect/mob_spawn/corpse/human/endron/security
		if("Garou")
			return /obj/effect/mob_spawn/corpse/human/garou
		if("Ciz1")
			return /datum/outfit/civillian1
		if("Ciz2")
			return /datum/outfit/civillian2
		if("Ciz3")
			return /datum/outfit/civillian3
		if("Ciz4")
			return /datum/outfit/civillian4

/obj/effect/mob_spawn/corpse/human/gray_masses/dwarf/special(mob/living/carbon/human/spawned_human, mob/mob_possessor, apply_prefs)
	. = ..()
	spawned_human.dna.add_mutation(/datum/mutation/dwarfism, MUTATION_SOURCE_MUTATOR)

// GENERIC
/obj/effect/mob_spawn/corpse/human/police
	outfit = /datum/outfit/job/vampire/police_officer
	outfit_override = list("r_pocket" = /obj/item/stack/dollar/rand)
