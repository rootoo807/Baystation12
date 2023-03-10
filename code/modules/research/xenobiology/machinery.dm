

/obj/machinery/computer/xenobio
	name = "Slime management console"
	desc = "A computer used for remotely handling slimes."
	icon_keyboard = "rd_key" 									//update
	icon_screen = "rdcomp" 										//update
	light_color = "#a97faa" 									//update
	//machine_name = "slime management console"
	//machine_desc = "."

/obj/machinery/slime_processor
	name = "slime processor"
	desc = "An industrial grinder appropriated for use in xenobiological research. Keep hands clear of intake area while operating."
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "processor1"
	density = TRUE
	anchored = TRUE
	uncreated_component_parts = null
	stat_immune = 0

	machine_name = "slime processor"
	machine_desc = "."


/obj/machinery/monkey_recycler
	name = "monkey recycler"
	desc = "A machine used for recycling dead monkeys into monkey cubes."
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "grinder"
	density = TRUE
	anchored = TRUE
	uncreated_component_parts = null
	stat_immune = 0

	machine_name = "monkey recycler"
	machine_desc = "."
