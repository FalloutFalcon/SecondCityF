// I think it needs to be like this because globals init before configs?
#define DEFAULT_STREET_SOURCE "modular_darkpack/modules/map_gen/strings/sanfran_streets.txt"

GLOBAL_LIST_INIT(weighted_street_names, generate_street_names())

/proc/generate_street_names(txt_source = DEFAULT_STREET_SOURCE)
	. = list()
	for(var/entry in world.file2list(txt_source))
		var/comma_index = findtext(entry, ",")

		var/count = text2num(copytext(entry, 1, comma_index))
		var/name = copytext(entry, comma_index + 1)

		if(!isnum(count))
			continue
		if(!istext(name))
			continue

		.[name] = count
	return .

/proc/get_random_street_name(list/street_list = GLOB.weighted_street_names)
	return pick_weight(street_list)

/proc/remove_street_entry(entry, list/street_list = GLOB.weighted_street_names)
	street_list[entry] = null

/proc/get_and_remove_street_name(list/street_list = GLOB.weighted_street_names)
	. = pick_weight(street_list)
	street_list[.] = null
	return .

#undef DEFAULT_STREET_SOURCE
