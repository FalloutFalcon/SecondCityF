GLOBAL_LIST_INIT(weighted_street_names, generate_street_names())

/proc/generate_street_names()
	. = list()
	for(var/entry in world.file2list("modular_darkpack/modules/map_gen/strings/sanfran_streets.txt"))
		var/comma_index = findtext(entry, ",")

		var/count = text2num(copytext(entry, 1, comma_index))
		var/name = copytext(entry, comma_index + 1)

		if(!isnum(count))
			continue
		if(!istext(name))
			continue

		.[name] = count
	return .

/proc/get_random_street_name()
	return pick_weight(GLOB.weighted_street_names)

/proc/remove_street_entry(entry)
	GLOB.weighted_street_names[entry] = null

/proc/get_and_remove_street_name()
	. = pick_weight(GLOB.weighted_street_names)
	GLOB.weighted_street_names[.] = null
	return .
