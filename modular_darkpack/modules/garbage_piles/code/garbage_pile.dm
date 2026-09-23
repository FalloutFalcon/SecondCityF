// since smaller piles will have a lower integ
#define TRUE_MAX_INTEG 10 TTRPG_DAMAGE
#define SPRITE_STATES 3
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

	/// The max "height" a tower is allowed to grow to.
	var/max_height

	var/damage_taken = 0

/obj/structure/garbage_pile/Initialize(mapload)
	max_integrity += rand(-50, 50)
	. = ..()
	update_appearance()

/obj/structure/garbage_pile/update_icon_state()
	. = ..()
	var/health_percent = atom_integrity / TRUE_MAX_INTEG
	icon_state = "[base_icon_state]_[round(health_percent * SPRITE_STATES)]"

/obj/structure/garbage_pile/take_damage(damage_amount, damage_type, damage_flag, sound_effect, attack_dir, armour_penetration)
	. = ..()

	damage_taken += damage_amount
	// "spend" damage taken so that we can count up multiple weaker hits or leftover damage.
	// alot cleaner then a prob from a remainder
	while(damage_taken >= 1 TTRPG_DAMAGE)
		damage_taken -= 1 TTRPG_DAMAGE
		spawn_garbage()


/obj/structure/garbage_pile/proc/spawn_garbage()
	if(prob(33))
		var/turf/dropping_turf = get_adjacent_open_turfs(src)
		new /obj/structure/garbage_pile/temporary(dropping_turf)
		new /obj/effect/temp_visual/mook_dust(dropping_turf)

	var/list/spawn_list = GLOB.maintenance_loot
	while(islist(spawn_list))
		spawn_list = pick_weight(spawn_list)
	var/atom/movable/item_to_drop = new spawn_list(get_turf(src))
	var/turf/dropping_turf = get_adjacent_open_turfs(src)
	item_to_drop?.throw_at(dropping_turf, 1, 1)
	new /obj/effect/temp_visual/mook_dust/small(dropping_turf)


// Spawned rarely around larger attacked piles.
/obj/structure/garbage_pile/temporary
	max_integrity = 2 TTRPG_DAMAGE
	prevent_destruction = FALSE

#undef TRUE_MAX_INTEG
