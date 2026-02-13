/obj/effect/the_word
	name = "The Word"

/obj/effect/the_word/Initialize(mapload)
	. = ..()
	particles = new /particles/the_word/monster

/particles/the_word
	icon = 'modular_zapoc/modules/imbued/icons/the_word_small.dmi'
	width = 32
	height = 48
	count = 10
	spawning = 0.5
	lifespan = 2 SECONDS
	fade = 2 SECONDS
	//grow = -0.025
	gravity = list(0, 0.15)
	position = generator(GEN_SPHERE, 0, 16, NORMAL_RAND)
	spin = generator(GEN_NUM, -15, 15, NORMAL_RAND)

/particles/the_word/monster
	icon_state = list("penis" = 1, "fart" = 1)
