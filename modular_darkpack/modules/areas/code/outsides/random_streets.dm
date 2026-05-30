/area/vtm/outside/random_street
	name = "random street"
	abstract_type = /area/vtm/outside/random_street
	ambience_index = AMBIENCE_CITY
	music_index = MUSIC_CITY

/area/vtm/outside/random_street/Initialize(mapload)
	. = ..()
	if(name == initial(name))
		name = get_and_remove_street_name()

/area/vtm/outside/random_street/one

/area/vtm/outside/random_street/two

/area/vtm/outside/random_street/three

/area/vtm/outside/random_street/four

/area/vtm/outside/random_street/five

/area/vtm/outside/random_street/six

/area/vtm/outside/random_street/seven

/area/vtm/outside/random_street/eight

/area/vtm/outside/random_street/nine

/area/vtm/outside/random_street/ten
