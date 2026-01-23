/obj/structure/platform
	///whether we spawn a window structure with us on mapload
	var/start_with_window = FALSE
	///typepath. creates a corresponding window for this frame.
	///is either a material sheet typepath (eg /obj/item/stack/sheet/glass) or a fulltile window typepath (eg /obj/structure/window/fulltile)
	var/window_type = /obj/item/stack/sheet/glass
