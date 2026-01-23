/obj/structure/platform
	///whether we spawn a window structure with us on mapload
	var/start_with_window = FALSE
	///typepath. creates a corresponding window for this frame.
	///is either a material sheet typepath (eg /obj/item/stack/sheet/glass) or a fulltile window typepath (eg /obj/structure/window/fulltile)
	var/window_type = /obj/item/stack/sheet/glass

/obj/structure/platform/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(isstack(tool))
		var/obj/item/stack/adding_stack = tool
		// in case the stack gets deleted after use().
		// add in the front is to ensure the name's macro behavoir is applied correctly
		var/stack_name = "add [adding_stack]"

		if(is_glass_sheet(adding_stack) && !has_window() && adding_stack.tool_start_check(user, 2))
			to_chat(user, span_notice("You start to [stack_name] to [src]."))
			if(!adding_stack.use_tool(src, user, 2 SECONDS, 2))
				return ITEM_INTERACT_FAILURE

			to_chat(user, span_notice("You [stack_name] to [src]."))
			var/obj/structure/window/our_window = create_structure_window(adding_stack.type)
			our_window.state = WINDOW_OUT_OF_FRAME
			our_window.set_anchored(FALSE)
			return ITEM_INTERACT_SUCCESS

		/* Removed as our low-walls shouldnt really have grille
		else if(istype(adding_stack, /obj/item/stack/rods) && !has_grille && adding_stack.use(sheet_amount))
			has_grille = TRUE
			to_chat(user, "<span class='notice'>You [stack_name] to [src]")
			update_appearance()
			return ITEM_INTERACT_SUCCESS
		*/

		return ITEM_INTERACT_BLOCKING
	/* Should really be in an attackby still.
	else if((attacking_item.obj_flags & CONDUCTS_ELECTRICITY) && try_shock(user, 70))
		return
	*/

	return NONE

///creates a window from the typepath given from window_type, which is either a glass sheet typepath or a /obj/structure/window subtype
/obj/structure/platform/proc/create_structure_window(window_material_type)
	var/obj/structure/window/our_window

	if(ispath(window_material_type, /obj/structure/window))
		our_window = new window_material_type(loc)
		if(!our_window.fulltile)
			stack_trace("Window frames can't use non fulltile windows!")

	//window_material_type isnt a window typepath, so check if its a material typepath
	if(ispath(window_material_type, /obj/item/stack/sheet/glass))
		our_window = new /obj/structure/window/fulltile(loc)

	if(ispath(window_material_type, /obj/item/stack/sheet/rglass))
		our_window = new /obj/structure/window/reinforced/fulltile(loc)

	if(ispath(window_material_type, /obj/item/stack/sheet/plasmaglass))
		our_window = new /obj/structure/window/plasma/fulltile(loc)

	if(ispath(window_material_type, /obj/item/stack/sheet/plasmarglass))
		our_window = new /obj/structure/window/reinforced/plasma/fulltile(loc)

	if(ispath(window_material_type, /obj/item/stack/sheet/titaniumglass))
		our_window = new /obj/structure/window/reinforced/shuttle(loc)

	if(ispath(window_material_type, /obj/item/stack/sheet/plastitaniumglass))
		our_window = new /obj/structure/window/reinforced/plasma/plastitanium(loc)

	if(ispath(window_material_type, /obj/item/stack/sheet/paperframes))
		our_window = new /obj/structure/window/paperframe(loc)

	our_window.update_appearance()
	return our_window

///helper proc to check if we already have a window
/obj/structure/platform/proc/has_window()
	SHOULD_BE_PURE(TRUE)

	for(var/obj/structure/window/window in loc)
		if(window.fulltile)
			return TRUE

	return FALSE
