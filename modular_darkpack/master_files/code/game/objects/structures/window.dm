/obj/structure/window/fulltile
	icon = 'modular_darkpack/modules/deprecated/icons/obj/smooth_structures/window.dmi'

/obj/structure/window/reinforced/fulltile
	icon = 'modular_darkpack/modules/deprecated/icons/obj/smooth_structures/reinforced_window.dmi'

/obj/structure/window/update_icon_state()
	. = ..()
	if(fulltile)
		if(locate(/obj/structure/platform) in loc)
			pixel_y = 0
		else
			pixel_y = -7

/obj/structure/window/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	if(fulltile)
		update_icon_state()
