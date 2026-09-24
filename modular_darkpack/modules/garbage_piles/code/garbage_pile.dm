// since smaller piles will have a lower integ
#define TRUE_MAX_INTEG (15 TTRPG_DAMAGE)
#define SPRITE_STATES 3
#define GARBAGE_COST (3 TTRPG_DAMAGE)

GLOBAL_LIST_EMPTY(scrap_base_cache)

/obj/structure/garbage_pile
	name = "towering pile of garbage"
	// desc = "."
	icon = 'modular_darkpack/modules/garbage_piles/icons/garbage_pile.dmi'
	icon_state = "pile_3"
	base_icon_state = "pile"
	anchored = TRUE
	density = TRUE
	max_integrity = TRUE_MAX_INTEG
	prevent_destruction = TRUE

	/// Randomly picked icon to generate the apperance of the structure
	var/parts_icon = 'modular_darkpack/modules/garbage_piles/icons/trash_debug.dmi'
	var/base_min = 0 //min and max number of random pieces of base icon
	var/base_max = 2
	/// Limits on pixel offsets of base pieces
	var/base_spread = 8

	var/damage_taken = 0

	var/last_overlay_height
	var/overlay_seed

/obj/structure/garbage_pile/Initialize(mapload)
	max_integrity += rand(-1 TTRPG_DAMAGE, 1 TTRPG_DAMAGE)
	. = ..()
	SSgarbage_piles.piles += src
	update_appearance()

/obj/structure/garbage_pile/Destroy(force)
	. = ..()
	SSgarbage_piles.piles -= src

/obj/structure/garbage_pile/update_overlays()
	. = ..()

	var/tower_height = get_tower_height()
	if(isnull(last_overlay_height) || (last_overlay_height != tower_height))
		overlay_seed = rand(1, 30)
	last_overlay_height = tower_height

	if(!GLOB.scrap_base_cache["[parts_icon][tower_height][overlay_seed]"])
		var/num = rand(base_min,base_max) + (tower_height * 3)
		var/image/base_icon = image(icon, icon_state = icon_state)
		for(var/i in 1 to num)
			var/image/I = image(parts_icon, pick(icon_states(parts_icon)))
			I.color = pick("#a08366", "#63503d", "#666666", null)
			base_icon.overlays += randomize_image(I, tower_height)
		GLOB.scrap_base_cache["[parts_icon][tower_height][overlay_seed]"] = base_icon
	. += GLOB.scrap_base_cache["[parts_icon][tower_height][overlay_seed]"]

	for(var/obj/stored_object in contents)
		var/image/I = image(stored_object.icon, stored_object.icon_state)
		I.color = stored_object.color
		. += randomize_image(I, tower_height)

/obj/structure/garbage_pile/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[get_tower_height()]"
	set_density(!!atom_integrity)
	switch(get_tower_height())
		if(0 to 1)
			pass_flags_self = PASSTABLE | LETPASSTHROW
		if(2 to SPRITE_STATES)
			pass_flags_self = PASSSTRUCTURE

/obj/structure/garbage_pile/update_name(updates)
	. = ..()
	switch(get_tower_height())
		if(0)
			name = "empty pile of garbage"
		if(1)
			name = "small pile of garbage"
		if(2)
			name = "pile of garbage"
		if(SPRITE_STATES)
			name = "towering pile of garbage"


/obj/structure/garbage_pile/take_damage(damage_amount, damage_type, damage_flag, sound_effect, attack_dir, armour_penetration)
	if(atom_integrity > 0)
		damage_taken += damage_amount
		// "spend" damage taken so that we can count up multiple weaker hits or leftover damage.
		// alot cleaner then a prob from a remainder
		var/shit_spawned = FALSE
		while(damage_taken >= GARBAGE_COST)
			damage_taken -= GARBAGE_COST
			spawn_garbage()
			shit_spawned = TRUE

		if(shit_spawned)
			shake_off()

	. = ..()
	if(.)
		update_appearance()

/obj/structure/garbage_pile/repair_damage(amount)
	. = ..()
	if(.)
		update_appearance()

/obj/structure/garbage_pile/proc/spawn_garbage()
	if(prob(25))
		var/turf/dropping_turf = pick(get_adjacent_open_turfs(src))
		var/obj/structure/garbage_pile/existing_pile = locate() in dropping_turf
		if(existing_pile)
			if(existing_pile.atom_integrity <= atom_integrity) // Only dump trash onto SMALLER piles then ourselves..
				existing_pile.repair_damage(1 TTRPG_DAMAGE)
				new /obj/effect/temp_visual/mook_dust(dropping_turf)
				return
		else
			new /obj/structure/garbage_pile/temporary(dropping_turf)
			new /obj/effect/temp_visual/mook_dust(dropping_turf)
			return

	var/list/spawn_list = GLOB.maintenance_loot
	while(islist(spawn_list))
		spawn_list = pick_weight(spawn_list)
	new spawn_list(get_turf(src))

/obj/structure/garbage_pile/proc/shake_off()
	var/list/turf_options = get_toss_locations()
	for(var/obj/item/shit_on_turf in get_turf(src))
		if(prob(33))
			continue
		var/turf/dropping_turf = pick(turf_options)
		shit_on_turf.throw_at(dropping_turf, 1, 1)
		new /obj/effect/temp_visual/mook_dust/small(dropping_turf)

/obj/structure/garbage_pile/proc/get_toss_locations()
	var/list/turfs = list()
	for(var/turf/open/open_turf in range(1, get_turf(src)))
		turfs += open_turf

	return turfs

/obj/structure/garbage_pile/proc/get_tower_height()
	if(atom_integrity <= 0)
		return 0

	var/health_percent = atom_integrity / TRUE_MAX_INTEG
	return clamp(round(health_percent * SPRITE_STATES), 1, SPRITE_STATES)

/obj/structure/garbage_pile/proc/randomize_image(image/I, tower_height)
	var/y_offest = 0
	switch(tower_height)
		if(0)
			y_offest = -4
		if(2)
			y_offest = 6
		if(SPRITE_STATES)
			y_offest = 16
	I.pixel_x = rand(-base_spread,base_spread)
	I.pixel_y = rand(-base_spread,base_spread + y_offest)
	var/matrix/M = matrix()
	M.Turn(pick(0,90,180,270))
	I.transform = M
	return I

// Spawned rarely around larger attacked piles.
/obj/structure/garbage_pile/temporary
	max_integrity = GARBAGE_COST
	prevent_destruction = FALSE

#undef TRUE_MAX_INTEG
#undef SPRITE_STATES
#undef GARBAGE_COST
