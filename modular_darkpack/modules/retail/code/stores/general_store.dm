/obj/structure/retail/general
	desc = "A general store for general needs."
	products_list = list(
		new /datum/data/vending_product("prepaid cell phone", /obj/item/smartphone),
		new /datum/data/vending_product("box of light bulbs", /obj/item/storage/box/lights/mixed, 100), // price is different between hardware and general store
	)
	product_types = list(
		/obj/item/rag,
		/obj/item/tape,
		/obj/item/flashlight,
		/obj/item/mop,
		/obj/item/reagent_containers/cup/bucket,
		/obj/item/pushbroom,
		/obj/item/storage/bag/trash,
		/obj/item/screwdriver,
		/obj/item/crowbar,
		/obj/item/wrench,
		/obj/item/wirecutters,
		/obj/item/weldingtool,
		/obj/item/toner/large,
		/obj/item/clothing/head/vampire/hardhat,
		/obj/item/razor,
		/obj/item/taperecorder,
		/obj/item/melee/baseball_bat/vamp,
		/obj/item/clothing/gloves/color/yellow,
		/obj/item/storage/box/matches,
		/obj/item/storage/box/glowsticks,
	)

/obj/item/storage/box/glowsticks
	name = "glowstick box"
	desc = "Eight glowsticks of fun! Ages 8 and up. Not suitable for children."
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "spbox"
	illustration = ""
	storage_type = /datum/storage/box/glowsticks
	custom_price = 8

/obj/item/storage/box/glowsticks/PopulateContents()
	for(var/i in 1 to 8)
		new /obj/item/flashlight/glowstick(src)


/datum/storage/box/glowsticks
	max_slots = 8

/datum/storage/box/glowsticks/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound)
	. = ..()
	set_holdable(/obj/item/flashlight/glowstick)
