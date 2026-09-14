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
	tool_behaviors = list(TOOL_SCREWDRIVER)
	time = 3 TURNS
	category = CAT_WEAPON_RANGED
	craft_roll_ability = STAT_SCIENCE
	ability_dots_minimum = 2
	roll_difficulty = 7

/datum/crafting_recipe/night_vision_goggles
	name = "Night Vision Goggles"
	result = /obj/item/clothing/glasses/night
	reqs = list(
		/obj/item/binoculars = 1,
		/obj/item/clothing/head/utility/welding = 1,
		/obj/item/assembly/infra = 1,
	)
	time = 3 TURNS
	tool_behaviors = list(TOOL_SCREWDRIVER)
	category = CAT_CLOTHING
	craft_roll_ability = STAT_SCIENCE
	ability_dots_minimum = 3
	roll_difficulty = 7

/datum/crafting_recipe/thermal_goggles
	name = "Thermal Goggles"
	result = /obj/item/clothing/glasses/thermal
	reqs = list(
		/obj/item/clothing/glasses/night = 1,
		/obj/item/assembly/infra = 2,
		/obj/item/assembly/prox_sensor = 1,
	)
	time = 3 TURNS
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	category = CAT_CLOTHING
	craft_roll_ability = STAT_SCIENCE
	ability_dots_minimum = 4
	roll_difficulty = 7
