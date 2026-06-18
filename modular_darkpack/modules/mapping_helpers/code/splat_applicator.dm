/obj/effect/mapping_helpers/splat_applicator
	name = "abstract splat applicator"
	desc = "Calls add_splat() on all /mob/living/carbon on our turf. Var-edit me!"
	abstract_type = /obj/effect/mapping_helpers/splat_applicator
	/// The splat we're adding as a string.
	var/splat_to_apply
	/// The range of the splatinator ray.
	var/range

	// Vampire vars
	var/generation
	var/datum/subsplat/vampire_clan/clan
	var/enlightenment

	// Dog vars // TODO: add these when the fera rework is done
	//var/rank
	//var/tribe
	//var/breed

/obj/effect/mapping_helpers/splat_applicator/Initialize(mapload)
	. = ..()
	if(findtext(name, "abstract")) // inelegant. ugly.
		CRASH("[name] ([x],[y],[z]) says, \"We're using the abstract splat applicator! Use a subtype, darnit!\"")

	for(var/mob/living/guy in range(range, src))
		applicate_splat(splat_to_apply, guy)

/obj/effect/mapping_helpers/splat_applicator/proc/applicate_splat(splat, mob/living/guy)
	switch(splat)
		if(SPLAT_KINDRED)
			return guy.make_kindred(/datum/splat/vampire/kindred, generation, clan, enlightenment)
		if(SPLAT_GHOUL)
			return guy.make_ghoul()
		if(SPLAT_GAROU)
			return guy.add_splat(/datum/splat/werewolf/shifter/garou) // TODO: make this randomize tribe/auspice/breed/etc.

/obj/effect/mapping_helpers/splat_applicator/kindred
	name = "kindred splat applicator"
	splat_to_apply = SPLAT_KINDRED

/obj/effect/mapping_helpers/splat_applicator/ghoul
	name = "ghoul splat applicator"
	splat_to_apply = SPLAT_GHOUL

/obj/effect/mapping_helpers/splat_applicator/garou
	name = "garou splat applicator"
	splat_to_apply = SPLAT_GAROU
