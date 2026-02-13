///Current version of the word persistence json
#define THE_WORD_PERSISTENCE_VERSION 0
///name of the file that has all the saved words
#define THE_WORD_SAVE_FILE "data/words/[SSmapping.current_map.map_name]_words.json"

/proc/good_the_word_location(turf/T)
	if(!T)
		. = FALSE
	else if(!(isfloorturf(T) || iswallturf(T)))
		. = FALSE
	else
		. = TRUE

///Loads all words, and places a select amount in maintenance and the prison.
/datum/controller/subsystem/persistence/proc/load_the_word()
	var/json_file = file(THE_WORD_SAVE_FILE)
	if(!fexists(json_file))
		return

	var/list/json = json_decode(file2text(json_file))
	if(!json)
		return

	if(json["version"] < THE_WORD_PERSISTENCE_VERSION)
		update_the_word(json)

	var/list/saved_words = json["entries"]

	if(!saved_words.len)
		log_world("Failed to load the word on map [SSmapping.current_map.map_name]")
		return

	var/successfully_loaded_words = 0

	for(var/iteration in 1 to 100)
		var/word = pick_n_take(saved_words)
		if(!islist(word))
			stack_trace("something's wrong with the word data! one of the saved words wasn't a list!")
			continue

		var/xvar = word["x"]
		var/yvar = word["y"]
		var/zvar = word["z"]
		var/message = word["the_word"]

		if(!xvar || !yvar || !zvar || !message)
			continue

		var/turf/T = locate(xvar, yvar, zvar)
		if(!good_the_word_location(T))
			continue

		var/obj/structure/the_word/word = new(T, message)

		successfully_loaded_words++

	log_world("Loaded [successfully_loaded_words] engraved words on map [SSmapping.current_map.map_name]")

///Saves all new words in the world.
/datum/controller/subsystem/persistence/proc/save_the_word()
	var/list/saved_data = list()

	saved_data["version"] = THE_WORD_PERSISTENCE_VERSION
	saved_data["entries"] = list()


	var/json_file = file(THE_WORD_SAVE_FILE)
	if(fexists(json_file))
		var/list/old_json = json_decode(file2text(json_file))
		if(old_json)
			saved_data["entries"] = old_json["entries"]

	#warn dont leave world.
	for(var/obj/structure/the_word/word in world)
		if(!word.persistent_save)
			continue
		// var/area/engraved_area = get_area(word.parent)
		// if(!(engraved_area.area_flags_mapping & PERSISTENT_THE_WORDS))
			// continue
		saved_data["entries"] += word.save_persistent()

	fdel(json_file)

	WRITE_FILE(json_file, json_encode(saved_data))

///This proc can update entries if the format has changed at some point.
/datum/controller/subsystem/persistence/proc/update_the_word(json)
	for(var/word_entry in json["entries"])
		continue //no versioning yet

	//Save it to the file
	var/json_file = file(THE_WORD_SAVE_FILE)
	fdel(json_file)
	WRITE_FILE(json_file, json_encode(json))

	return json

#undef THE_WORD_PERSISTENCE_VERSION
#undef THE_WORD_SAVE_FILE
