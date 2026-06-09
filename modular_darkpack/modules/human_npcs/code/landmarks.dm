/// Landmarks that NPCs will spawn at
GLOBAL_LIST_EMPTY(npc_spawn_points)

/obj/effect/landmark/npc_spawn_point
	icon = 'modular_darkpack/modules/deprecated/icons/effects/landmarks_static.dmi'
	icon_state = "spawn"

/obj/effect/landmark/npc_spawn_point/Initialize(mapload)
	. = ..()

	GLOB.npc_spawn_points += src

/obj/effect/landmark/npc_spawn_point/Destroy()
	GLOB.npc_spawn_points -= src

	. = ..()


/obj/effect/landmark/npcbeacon
	name = "NPC landmark"
	icon_state = "x3"


/obj/effect/landmark/ai_avoid_turf
	name = "AI avoidant turf landmark"
	icon_state = "x"
	can_astar_pass = CANASTARPASS_ALWAYS_PROC

// We want NPCs avoiding crossing these unless they're actively chasing someone.
/obj/effect/landmark/ai_avoid_turf/CanAStarPass(to_dir, datum/can_pass_info/pass_info)
	var/mob/living/living_npc = pass_info.requester_ref?.resolve()
	if(living_npc?.ai_controller?.blackboard[BB_BASIC_MOB_CURRENT_TARGET])
		return TRUE
	return FALSE
