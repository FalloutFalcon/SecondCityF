// DARKPACK TODO - This file should not exist and is only so we can save runtime town
/obj/machinery/computer/order_console/mining/restricted/police
	icon = 'icons/effects/mapping_helpers.dmi'
	icon_state = "merge_conflict_marker"
/obj/machinery/computer/order_console/mining/restricted/hospital
	icon = 'icons/effects/mapping_helpers.dmi'
	icon_state = "merge_conflict_marker"

/obj/vampire_computer
	name = "old computer"
	desc = "For some reason its just stuck on the lock screen and all the buttons dont seem to do anything... (We have yet to reimplement vampire computers! Sorry!)"
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "computer"
	// APOC EDIT ADD START
	var/owner
	var/password
	var/username
	// APOC EDIT ADD END

/obj/vampire_computer/prince
	icon_state = "computerprince"

/obj/vampire_computer/box
	icon = 'icons/obj/machines/computer.dmi'
	icon_state = "oldcomp"

// TODO: reimplement these types. the shoes, at least, baggies might be obsolete now.

/obj/item/storage/box/baggie
	name = "baggie box"
	desc = "WIP! Sorry!"

/obj/item/clothing/shoes/vampire/pumped
	name = "knee-high sneakers"
	desc = "these are the pumped up kicks you are looking for"
	icon_state = "pumped_up_kicks"
