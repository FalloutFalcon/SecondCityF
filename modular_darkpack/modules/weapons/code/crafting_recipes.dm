/datum/crafting_recipe/stake
	name = "Stake"
	time = 50
	reqs = list(/obj/item/stack/sheet/mineral/wood = 2)
	result = /obj/item/vampire_stake
	category = CAT_WEAPON_MELEE

/datum/crafting_recipe/molotov
	name = "Molotov"
	time = 50
	reqs = list(/obj/item/reagent_containers/cup/glass/bottle/beer/vampire = 1, /obj/item/stack/sheet/cloth = 1, /obj/item/gas_can = 1)
	result = /obj/item/molotov
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/liquid_flamethrower
	name = "Liquid flamethrower"
	result = /obj/item/liquid_flamethrower
	reqs = list(
		/obj/item/weldingtool = 1,
		/obj/item/assembly/igniter = 1,
		/obj/item/stack/rods = 1,
	)
	parts = list(
		/obj/item/assembly/igniter = 1,
		/obj/item/weldingtool = 1,
	)
	tool_behaviors = list(TOOL_SCREWDRIVER)
	time = 1 SECONDS
	category = CAT_WEAPON_RANGED
	craft_roll_ability = STAT_SCIENCE
	ability_dots_minimum = 2 // STORYTELER_STATS
	roll_difficulty = 7 // STORYTELER_STATS
