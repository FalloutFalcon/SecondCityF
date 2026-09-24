SUBSYSTEM_DEF(garbage_piles)
	name = "Garbage Piles"
	ss_flags = SS_NO_INIT
	priority = FIRE_PRIORITY_DEFAULT
	wait = 30 SECONDS
	var/list/piles = list()
	var/base_recharge_amount = 5
	var/players_per_extra_scroop = 6

/datum/controller/subsystem/garbage_piles/fire()
	var/potential_scroopers = get_active_player_count(alive_check = TRUE, afk_check = TRUE, human_check = TRUE)
	var/recharge_amount = base_recharge_amount += round(potential_scroopers / players_per_extra_scroop)
	var/list/potential_pile = list()
	for(var/obj/structure/garbage_pile/garbage in piles)
		if(!garbage.prevent_destruction)
			continue // Temporary pile.
		if(garbage.get_integrity() >= garbage.max_integrity)
			continue
		potential_pile += garbage

	shuffle_inplace(potential_pile)

	for(var/obj/structure/garbage_pile/garbage in potential_pile)
		var/max_repair_amount = min((garbage.max_integrity - garbage.get_integrity()) / 1 TTRPG_DAMAGE, recharge_amount)
		recharge_amount -= max_repair_amount
		garbage.repair_damage(max_repair_amount TTRPG_DAMAGE)
		new /obj/effect/temp_visual/mook_dust(get_turf(garbage))
		if(recharge_amount <= 0)
			break
