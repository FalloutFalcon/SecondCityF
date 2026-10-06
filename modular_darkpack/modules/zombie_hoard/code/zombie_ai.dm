

/datum/bt_node/ai_behavior/find_zombie_hunt_target
	/// Blackboard key to store the found landmark.
	var/target_key = BB_TRAVEL_DESTINATION
	time_between_perform = 5 SECONDS

/datum/bt_node/ai_behavior/find_zombie_hunt_target/perform(seconds_per_tick, datum/ai_controller/controller)
	if(!GLOB.zombie_mode?.current_targets_by_zlevel)
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED
	var/our_mobs_z = "[controller.pawn.z]"
	var/atom/possible_target = GLOB.zombie_mode.current_targets_by_zlevel[our_mobs_z]
	if(!possible_target)
		controller.clear_blackboard_key(target_key)
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	controller.set_blackboard_key(target_key, possible_target)
	return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED
