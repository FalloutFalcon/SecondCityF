GLOBAL_DATUM(zombie_mode, /datum/zombie_mode_controller)
GLOBAL_LIST_EMPTY(alive_zombies)


/datum/dynamic_ruleset/roundstart/zombies
	name = "Zombies"
	config_tag = "Zombies"
	weight = 0
	min_antag_cap = 0
	repeatable = FALSE

/datum/dynamic_ruleset/roundstart/zombies/execute()
	GLOB.zombie_mode ||= new()
	GLOB.zombie_mode.start_zombies()


/datum/zombie_mode_controller
	#warn 5 MINUTES
	var/start_delay = 6 SECONDS
	/// Every [x] minutes, more zombies will spawn
	var/rampupdelta = 1
	COOLDOWN_DECLARE(spawn_wave_cd)
	var/spawn_wave_delay = 10 SECONDS

	var/list/zombies_normal = list(
		/mob/living/basic/zombie/darkpack = 75,
		/mob/living/basic/zombie/darkpack/skeleton = 25
	)
	var/list/zombies_threatening = list(
		/mob/living/basic/zombie/darkpack = 60,
		/mob/living/basic/zombie/darkpack/fat_zombie = 20,
		/mob/living/basic/zombie/darkpack/suit_zombie = 10,
		/mob/living/basic/zombie/darkpack/skeleton = 10
	)
	var/list/zombies_catastrophic = list(
		/mob/living/basic/zombie/darkpack = 55,
		/mob/living/basic/zombie/darkpack/fat_zombie = 30,
		/mob/living/basic/zombie/darkpack/suit_zombie = 10,
		/mob/living/basic/zombie/darkpack/skeleton = 5
	)

	var/list/current_targets_by_zlevel = list()

/datum/zombie_mode_controller/proc/start_zombies()
	START_PROCESSING(SSprocessing, src)

/datum/zombie_mode_controller/process(seconds_per_tick)
	if(start_delay > world.time - SSticker.round_start_time)
		return
	SSmapping.current_map.max_npcs = 0 // Prevent new human npcs from spawning and getting instantly murdered.

	if(!COOLDOWN_FINISHED(src, spawn_wave_cd))
		return
	COOLDOWN_START(src, spawn_wave_cd, spawn_wave_delay)

	var/list/player_targets = get_active_player_list(TRUE, TRUE, TRUE)
	if(length(GLOB.alive_zombies) >= length(player_targets) * 15)
		return

	var/list/wavetype = zombies_normal
	var/zombie_minutes = (world.time - SSticker.round_start_time - start_delay) / 10 / 60

	if (prob(zombie_minutes))
		wavetype = zombies_threatening

	if (prob(zombie_minutes/2))
		wavetype = zombies_catastrophic

	var/ramp_up_final = clamp(round(zombie_minutes / rampupdelta), 1, 20)

	spawn_zombies(ramp_up_final, wavetype)

	find_targets(player_targets)

/datum/zombie_mode_controller/proc/find_targets(list/considering_targets)
	current_targets_by_zlevel = list() // Clear

	shuffle_inplace(considering_targets)
	for(var/mob/living/carbon/human/guy in considering_targets)
		var/guys_z = "[guy.z]"
		if(current_targets_by_zlevel[guys_z])
			continue

		current_targets_by_zlevel[guys_z] = guy

/datum/zombie_mode_controller/proc/spawn_zombies(number = 10, list/zombie_types)
	for(var/i in 1 to number)
		spawn_zombie(zombie_types)

/datum/zombie_mode_controller/proc/spawn_zombie(list/zombie_types)
	if (!length(GLOB.npc_spawn_points))
		CRASH("No spawn points for zombies.")

	var/atom/chosen_spawn_point = pick(GLOB.npc_spawn_points)

	var/new_zomber = pick_weight(zombie_types)
	new new_zomber(get_turf(chosen_spawn_point))
