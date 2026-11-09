//scrap item, mostly for fluff
/obj/item/stack/salvage
	abstract_type = /obj/item/stack/salvage
	name = "salvage"
	icon = 'modular_darkpack/modules/crafting/icons/materials_inventory.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/crafting/icons/materials_world.dmi')
	lefthand_file = 'modular_darkpack/modules/crafting/icons/items_lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/crafting/icons/items_righthand.dmi'
	icon_state = "scrap"
	// refined_type = null

/*
/obj/item/stack/salvage/examine(mob/user)
	. = ..()
	. += "You could probably reclaim this in an autolathe, Ore Redemption Machine, or smelter."
*/



/obj/item/stack/salvage/scrap_parts
	name = "scrap parts"
	desc = "Assorted parts like nuts, bolts, screws, and springs."
	singular_name = "scrap part"
	icon_state = "scrap_parts"
	inhand_icon_state = "scrap"
	merge_type = /obj/item/stack/salvage/scrap_parts
	mats_per_unit = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT)
	// material_type = /datum/material/iron
	amount = 1
	max_amount = 10
	w_class = WEIGHT_CLASS_TINY
	novariants = FALSE

/obj/item/stack/salvage/scrap_parts/two
	amount = 2

/obj/item/stack/salvage/scrap_parts/five
	amount = 5

/obj/item/stack/salvage/scrap_parts/ten
	amount = 10


/obj/item/stack/salvage/plastic
	name = "plastic"
	desc = "Bright bits and pieces of plastic. Probably a choking hazard."
	singular_name = "plastice piece"
	icon_state = "plastic"
	merge_type = /obj/item/stack/salvage/plastic
	mats_per_unit = list(/datum/material/plastic=SHEET_MATERIAL_AMOUNT)
	// material_type = /datum/material/plastic
	amount = 1
	max_amount = 10
	w_class = WEIGHT_CLASS_TINY

/obj/item/stack/salvage/plastic/two
	amount = 2

/obj/item/stack/salvage/plastic/five
	amount = 5

/obj/item/stack/salvage/plastic/ten
	amount = 10

/obj/item/stack/salvage/glass
	name = "glass shards"
	desc = "Shiny, sharp shards of glass. Be careful!"
	singular_name = "glass shard"
	icon_state = "scrap_glass"
	merge_type = /obj/item/stack/salvage/glass
	mats_per_unit = list(/datum/material/glass=SHEET_MATERIAL_AMOUNT)
	amount = 1
	max_amount = 10
	w_class = WEIGHT_CLASS_TINY
	novariants = FALSE

/obj/item/stack/salvage/glass/Initialize(mapload, new_amount, merge, list/mat_override, mat_amt)
	. = ..()
	AddComponent(/datum/component/caltrop, min_damage = 5)

/obj/item/stack/salvage/glass/two
	amount = 2

/obj/item/stack/salvage/glass/five
	amount = 5

/obj/item/stack/salvage/glass/ten
	amount = 10


