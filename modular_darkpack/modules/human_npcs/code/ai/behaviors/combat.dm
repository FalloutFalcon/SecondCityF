
/*
/datum/ai_planning_subtree/choose_attack_subtree

/datum/ai_planning_subtree/choose_attack_subtree/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/carbon/human/human_pawn = controller.pawn

	if(human_pawn.is_holding_item_of_type(/obj/item/gun))
		if(controller.blackboard[BB_GUNMIMIC_GUN_EMPTY])
			controller.queue_behavior(/datum/bt_node/ai_behavior/find_weapon)
			return
		var/datum/ai_planning_subtree/basic_ranged_attack_subtree/npc/ranged_attack_subtree = GLOB.ai_subtrees[/datum/ai_planning_subtree/basic_ranged_attack_subtree]
		ranged_attack_subtree.SelectBehaviors(controller, seconds_per_tick)

	var/datum/ai_planning_subtree/basic_melee_attack_subtree/npc/melee_attack_subtree = GLOB.ai_subtrees[/datum/ai_planning_subtree/basic_melee_attack_subtree]
	melee_attack_subtree.SelectBehaviors(controller, seconds_per_tick)

/datum/ai_planning_subtree/basic_ranged_attack_subtree/npc
	ranged_attack_behavior = /datum/bt_node/ai_behavior/basic_ranged_attack/npc

/datum/bt_node/ai_behavior/basic_ranged_attack/npc
	action_cooldown = 3 SECONDS
	avoid_friendly_fire = TRUE

/datum/ai_planning_subtree/basic_melee_attack_subtree/npc
	melee_attack_behavior = /datum/bt_node/ai_behavior/basic_melee_attack/npc
	end_planning = FALSE

/datum/bt_node/ai_behavior/basic_melee_attack/npc
	action_cooldown = 0.2 SECONDS // We gotta check unfortunately often because we're in a race condition with nextmove
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_MOVE_AND_PERFORM | AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION | AI_BEHAVIOR_REQUIRE_REACH
*/


/*
/datum/ai_planning_subtree/search_for_weapon

/datum/ai_planning_subtree/search_for_weapon/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	if(controller.blackboard_key_exists(BB_MONKEY_BEST_FORCE_FOUND))
		return
	controller.queue_behavior(/datum/bt_node/ai_behavior/find_weapon)

///re-used behavior pattern by monkeys for finding a weapon
/datum/bt_node/ai_behavior/find_weapon

/datum/bt_node/ai_behavior/find_weapon/perform(seconds_per_tick, datum/ai_controller/controller, ...)
	var/mob/living/living_pawn = controller.pawn

	if(!(locate(/obj/item) in living_pawn.held_items))
		controller.set_blackboard_key(BB_MONKEY_BEST_FORCE_FOUND, 0)

	if(controller.blackboard[BB_MONKEY_GUN_NEURONS_ACTIVATED] && (locate(/obj/item/gun) in living_pawn.held_items) && !controller.blackboard_key_exists(BB_GUNMIMIC_GUN_EMPTY))
		// We have a loaded gun, what could we possibly want?
		return AI_BEHAVIOR_FAILED

	var/obj/item/weapon
	var/list/nearby_items = list()
	for(var/obj/item/item in oview(2, living_pawn))
		nearby_items += item

	for(var/obj/item/item in living_pawn.held_items) // If we've got some garbage in out hands that's going to stop us from effectively attacking, we should get rid of it.
		if(item.force < 2)
			living_pawn.dropItemToGround(item)

	weapon = GetBestWeapon(controller, nearby_items, living_pawn.held_items)

	var/pickpocket = FALSE
	for(var/mob/living/carbon/human/human in oview(5, living_pawn))
		var/obj/item/held_weapon = GetBestWeapon(controller, human.held_items + weapon, living_pawn.held_items)
		if(held_weapon == weapon) // It's just the same one, not a held one
			continue
		pickpocket = TRUE
		weapon = held_weapon

	if(!weapon || (weapon in living_pawn.held_items))
		return AI_BEHAVIOR_FAILED

	if(weapon.force < 2) // our bite does 2 damage on average, no point in settling for anything less
		return AI_BEHAVIOR_FAILED

	controller.set_blackboard_key(BB_MONKEY_PICKUPTARGET, weapon)
	if(pickpocket)
		controller.queue_behavior(/datum/bt_node/ai_behavior/monkey_equip/pickpocket, BB_MONKEY_PICKUPTARGET)
	else
		controller.queue_behavior(/datum/bt_node/ai_behavior/monkey_equip/ground, BB_MONKEY_PICKUPTARGET)
	return AI_BEHAVIOR_SUCCEEDED | AI_BEHAVIOR_DELAY
*/
