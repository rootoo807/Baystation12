/obj/machinery/slime_processor
	name = "slime processor"
	desc = "An industrial grinder built for use in xenobiological research. Keep hands clear of intake area while operating."
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "processor1"
	layer = BELOW_OBJ_LAYER
	density = TRUE
	anchored = TRUE
	obj_flags = OBJ_FLAG_ANCHORABLE
	idle_power_usage = 2
	active_power_usage = 500
	construct_state = /singleton/machine_construction/default/panel_closed
	var/processing = FALSE
	var/rating_speed = 1
	var/rating_amount = 1
	var/list/processor_contents
	var/static/list/processor_inputs

/obj/item/stock_parts/circuitboard/slime_processor
	name = T_BOARD("slime processor")
	build_path = /obj/machinery/slime_processor
	board_type = "machine"
	origin_tech = list(TECH_BIO = 5, TECH_MATERIAL = 2, TECH_ENGINEERING = 2)
	req_components = list(
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stock_parts/manipulator = 1
	)
	additional_spawn_components = list(
		/obj/item/stock_parts/power/apc/buildable = 1
	)


/obj/machinery/slime_processor/Destroy()
	if(LAZYLEN(processor_contents))
		for(var/mob/S in processor_contents)
			S.dropInto(loc)
	. = ..()


/obj/machinery/slime_processor/RefreshParts()
	..()
	rating_amount = clamp(total_component_rating_of_type(/obj/item/stock_parts/matter_bin), 0 ,4)
	rating_speed = clamp(total_component_rating_of_type(/obj/item/stock_parts/matter_bin), 0 ,4)


/obj/machinery/slime_processor/examine(mob/user)
	. = ..()
	if(in_range(user, src) || isobserver(user))
		to_chat(user, SPAN_NOTICE("The status display reads: Processing slime cores at [rating_amount*100]% efficiency and [rating_speed*100]% speed."))


/obj/machinery/slime_processor/Exited(atom/movable/gone, direction)
	. = ..()
	LAZYREMOVE(processor_contents, gone)


/obj/machinery/slime_processor/on_update_icon()
	if(processing)
		icon_state = "processor2"
	else if(panel_open)
		icon_state = "processor0"
	else
		icon_state = "processor1"


/obj/machinery/slime_processor/Process()
	if(processing)
		return
	var/mob/living/carbon/slime/picked_slime
	for(var/mob/living/carbon/slime/S in range(1,src))
		//don't take slimes behind glass panes or somesuch; also makes it ignore slimes inside the processor
		if(Adjacent(S) && !(S in processor_contents) && S.stat)
			picked_slime = S
			break
	if(!picked_slime)
		return
	visible_message(SPAN_NOTICE("\The [picked_slime] is sucked into \the [src]."))
	LAZYADD(processor_contents, picked_slime)
	picked_slime.forceMove(src)


/obj/machinery/slime_processor/proc/process_slime(mob/living/carbon/slime/processed_slime)
	if (!istype(processed_slime))
		return
	if(!(processed_slime.stat))
		processed_slime.dropInto(loc)
		processed_slime.visible_message(SPAN_NOTICE("\The [processed_slime] crawls free of \the [src]!"))
		return
	var/core_count = processed_slime.cores
	var/core_type = processed_slime.GetCoreType()
	for(var/i in 1 to (core_count+rating_amount-1))
		new core_type (src.loc)
	qdel(processed_slime)
	LAZYREMOVE(processor_contents, processed_slime)

/obj/machinery/slime_processor/use_tool(obj/item/tool, mob/user, list/click_params)
	if(processing)
		USE_FEEDBACK_FAILURE("\The [src] is in the process of processing!")
		return TRUE
	else
		return ..()


/obj/machinery/slime_processor/interface_interact(mob/user)
	if(processing)
		USE_FEEDBACK_FAILURE("\The [src] is in the process of processing!")
		return FALSE
	if(!LAZYLEN(processor_contents))
		USE_FEEDBACK_FAILURE("\The [src] is empty!")
		return FALSE
	user.visible_message(SPAN_NOTICE("\The [user] turns on \the [src]."), SPAN_NOTICE("You turn on \the [src]."))
	processing = TRUE
	update_icon()
	playsound(src.loc, 'sound/machines/blender.ogg', 50, TRUE)
	use_power_oneoff(active_power_usage)
	var/total_time = 0
	for(var/mob/living/carbon/slime/S in processor_contents)
		total_time += 6 SECONDS
	sleep(total_time / rating_speed)
	for(var/mob/living/carbon/slime/S in processor_contents)
		process_slime(S)
	processing = FALSE
	update_icon()
	visible_message(SPAN_NOTICE("\The [src] finishes processing."))
	return TRUE


/obj/machinery/slime_processor/verb/eject()
	set category = "Object"
	set name = "Eject Contents"
	set src in oview(1)
	if(usr.incapacitated())
		return
	if(!LAZYLEN(processor_contents))
		FEEDBACK_FAILURE(usr, "\The [src] is empty!")
		return
	usr.visible_message(
		SPAN_NOTICE("\The [usr] ejects the contents of \the [src]."),
		SPAN_NOTICE("You eject contents of \the [src]."))
	for(var/mob/living/carbon/slime/S in processor_contents)
		S.dropInto(loc)
	add_fingerprint(usr)



/obj/machinery/monkey_recycler
	name = "monkey recycler"
	desc = "A machine used for recycling dead monkeys into monkey cubes."
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "grinder"
	density = TRUE
	anchored = TRUE
	uncreated_component_parts = null
	stat_immune = 0

/obj/item/stock_parts/circuitboard/monkey_recycler
	name = T_BOARD("monkey recycler")
	build_path = /obj/machinery/monkey_recycler
	board_type = "machine"
	origin_tech = list(TECH_BIO = 6, TECH_MATERIAL = 2, TECH_ENGINEERING = 2)
	req_components = list(
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stock_parts/manipulator = 1
	)
	additional_spawn_components = list(
		/obj/item/stock_parts/power/apc/buildable = 1
	)
