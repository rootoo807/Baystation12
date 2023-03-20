/obj/machinery/computer/camera_advanced
	name = "advanced camera console"
	desc = "Used to access the various cameras on the station."
	icon_screen = "cameras"
	icon_keyboard = "security_key"
	light_color = "#fa8282"
	var/list/z_lock = list() // Lock use to these z levels
	var/lock_override
	var/mob/observer/eye/cameranet/remote/eyeobj
	var/mob/living/current_user = null
	var/list/networks = list(NETWORK_EXODUS)
	// Typepath of the action button we use as "off"
	// It's a typepath so subtypes can give it fun new names
	var/datum/action/camera_off/off_action = /datum/action/camera_off
	// Typepath for jumping
	//var/datum/action/camera_jump/jump_action = /datum/action/camera_jump
	// Typepath of the move up action
	var/datum/action/camera_multiz_up/move_up_action = /datum/action/camera_multiz_up
	// Typepath of the move down action
	var/datum/action/camera_multiz_down/move_down_action = /datum/action/camera_multiz_down

	// List of all actions to give to a user when they're well, granted actions
	var/list/actions = list()
	//Should we supress any view changes?
	var/should_supress_view_changes = TRUE

	//interaction_flags_machine = INTERACT_MACHINE_ALLOW_SILICON | INTERACT_MACHINE_SET_MACHINE | INTERACT_MACHINE_REQUIRES_SIGHT

/obj/machinery/computer/camera_advanced/Initialize(mapload)
	. = ..()
	/*if(lock_override)
		if(lock_override & CAMERA_LOCK_STATION)
			z_lock |= SSmapping.levels_by_trait(ZTRAIT_STATION)
		if(lock_override & CAMERA_LOCK_MINING)
			z_lock |= SSmapping.levels_by_trait(ZTRAIT_MINING)
		if(lock_override & CAMERA_LOCK_CENTCOM)
			z_lock |= SSmapping.levels_by_trait(ZTRAIT_CENTCOM)*/

	if(off_action)
		actions += new off_action(src)
	//if(jump_action)
	//	actions += new jump_action(src)
	//Camera action button to move up a Z level
	if(move_up_action)
		actions += new move_up_action(src)
	//Camera action button to move down a Z level
	if(move_down_action)
		actions += new move_down_action(src)


/obj/machinery/computer/camera_advanced/proc/CreateEye()
	eyeobj = new()
	eyeobj.origin = src


/obj/machinery/computer/camera_advanced/proc/GrantActions(mob/living/user)
	for(var/datum/action/to_grant as anything in actions)
		to_grant.Grant(user)


/obj/machinery/proc/remove_eye_control(mob/living/user)
	CRASH("[type] does not implement ai eye handling")


/obj/machinery/computer/camera_advanced/remove_eye_control(mob/living/user)
	if(!user)
		return
	for(var/V in actions)
		var/datum/action/A = V
		A.Remove(user)
	for(var/V in eyeobj.visibleChunks)
		var/datum/chunk/camera/C = V
		C.remove_eye(eyeobj)
	if(user.client)
		if(loc && !isturf(loc))
			user.client.eye = loc
			user.client.perspective = EYE_PERSPECTIVE
		else
			user.client.eye = src
			user.client.perspective = MOB_PERSPECTIVE
		if(eyeobj.visible_icon && user.client)
			user.client.images -= eyeobj.user_image
		//user.client.view_size.unsupress()

	eyeobj.eye_user = null
	current_user = null
	user.unset_machine()
	remove_eye_control(user)

	//for(var/atom/movable/screen/plane_master/plane_static in user.hud_used?.get_true_plane_masters(CAMERA_STATIC_PLANE))
	//	plane_static.hide_plane(user)
	//playsound(src, 'sound/machines/terminal_off.ogg', 25, FALSE)

/obj/machinery/computer/camera_advanced/check_eye(mob/user)
	if(!CanUseTopic(user))
		user.unset_machine()
		remove_eye_control(user)


/obj/machinery/computer/camera_advanced/Destroy()
	if(eyeobj)
		QDEL_NULL(eyeobj)
	actions = list()
	current_user = null
	return ..()


/obj/machinery/computer/camera_advanced/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(!CanUseTopic(user))
		return
	if(current_user)
		USE_FEEDBACK_FAILURE("The console is already in use!")
		return
	var/mob/living/L = user
	if(!eyeobj)
		CreateEye()
	if(!eyeobj) //Eye creation failed
		return
	if(!eyeobj.eye_initialized)
		var/camera_location
		var/turf/myturf = get_turf(src)
		//if(eyeobj.use_static != FALSE)
		if((!length(z_lock) || (myturf.z in z_lock)) && eyeobj.visualnet.is_turf_visible(myturf))
			camera_location = myturf
		else
			for(var/obj/machinery/camera/C as anything in eyeobj.visualnet.sources)
				if(!C.CanUseTopic() || length(z_lock) && !(C.z in z_lock)) //may need to go back and check about robots in sources
					continue
				var/list/network_overlap = networks & C.network
				if(length(network_overlap))
					camera_location = get_turf(C)
					break
		//else
		//	camera_location = myturf
		//	if(length(z_lock) && !(myturf.z in z_lock))
		//		camera_location = locate(round(world.maxx/2), round(world.maxy/2), z_lock[1])

		if(camera_location)
			eyeobj.eye_initialized = TRUE
			give_eye_control(L)
			eyeobj.setLoc(camera_location)
		else
			user.unset_machine()
			remove_eye_control(user)
	else
		give_eye_control(L)
		eyeobj.setLoc(eyeobj.loc)


/obj/machinery/computer/camera_advanced/attack_ai(mob/user)
	return


/obj/machinery/computer/camera_advanced/proc/give_eye_control(mob/user)
	GrantActions(user)
	current_user = user
	eyeobj.eye_user = user
	eyeobj.name = "Camera Eye ([user.name])"
	//user.remote_control = eyeobj
	if(eyeobj != src)
		user.client.perspective = EYE_PERSPECTIVE
		user.client.eye = eyeobj
	else
		user.client.eye = user.client.mob
		user.client.perspective = MOB_PERSPECTIVE
	eyeobj.setLoc(eyeobj.loc)
	//if(should_supress_view_changes)
	//	user.client.view_size.supress()
	// Who passes control like this god I hate static code
	//for(var/atom/movable/screen/plane_master/plane_static in user.hud_used?.get_true_plane_masters(CAMERA_STATIC_PLANE))
	//	plane_static.unhide_plane(user)




/mob/observer/eye/cameranet/remote //Note: make sure this can't see AI or ghosts
	name = "Inactive Camera Eye"
	var/mob/living/eye_user = null
	var/obj/machinery/origin
	var/eye_initialized = 0
	var/visible_icon = FALSE
	var/image/user_image = null


// /mob/camera/ai_eye/remote/update_remote_sight(mob/living/user)


/mob/observer/eye/cameranet/remote/Destroy()
	if(origin && eye_user)
		origin.remove_eye_control(eye_user,src)
	origin = null
	. = ..()
	eye_user = null


/mob/observer/eye/cameranet/remote/proc/GetViewerClient()
	if(eye_user)
		return eye_user.client
	return null


/mob/observer/eye/cameranet/remote/setLoc(turf/destination, force_update = FALSE)
	if(eye_user)
		destination = get_turf(destination)
		if (destination)
			forceMove(destination) // note: may need to rework to prevent mob detection weirdness, better match abstractmove()
		else
			forceMove(null)

		//update_ai_detect_hud()

		//if(use_static)
		//	GLOB.cameranet.visibility(src, GetViewerClient(), null, use_static)

		//if(visible_icon)
		//	if(eye_user.client)
		//		eye_user.client.images -= user_image
		//		user_image = image(icon,loc,icon_state, FLY_LAYER)
		//		SET_PLANE(user_image, ABOVE_GAME_PLANE, destination)
		//		eye_user.client.images += user_image

		visualnet.update_eye_chunks(src)
		return TRUE


/mob/observer/eye/cameranet/remote/relaymove(mob/living/user, direction)
	var/initial = initial(sprint)
	var/max_sprint = 50

	if(cooldown && cooldown < world.timeofday) // 3 seconds
		sprint = initial

	for(var/i = 0; i < max(sprint, initial); i += 20)
		var/turf/step = get_turf(get_step(src, direction))
		if(step)
			setLoc(step)

	cooldown = world.timeofday + 5
	if(acceleration)
		sprint = min(sprint + 0.5, max_sprint)
	else
		sprint = initial


/datum/action/camera_off
	name = "End Camera View"
	button_icon = 'icons/mob/camera_ui.dmi'
	button_icon_state = "camera_off"
	var/mob/observer/eye/cameranet/remote/remote_eye

/datum/action/camera_off/Activate()
	if(!owner || !isliving(owner) || !remote_eye)
		return
	var/obj/machinery/computer/camera_advanced/console = remote_eye.origin
	console.remove_eye_control(owner)

/*
/datum/action/camera_jump
	name = "Jump To Camera"
	button_icon = 'icons/mob/camera_ui.dmi'
	button_icon_state = "camera_jump"
	var/mob/observer/eye/cameranet/remote/remote_eye

/datum/action/camera_jump/Activate()
	if(!owner || !isliving(owner) || !remote_eye)
		return
	var/obj/machinery/computer/camera_advanced/origin = remote_eye.origin

	var/list/L = list()

	for (var/obj/machinery/camera/cam as anything in visualnet)
		if(length(origin.z_lock) && !(cam.z in origin.z_lock))
			continue
		L.Add(cam)

	camera_sort(L)

	var/list/T = list()

	for (var/obj/machinery/camera/netcam in L)
		var/list/tempnetwork = netcam.network & origin.networks
		if (length(tempnetwork))
			if(!netcam.c_tag)
				continue
			T["[netcam.c_tag][netcam.CanUseTopic() ? null : " (Deactivated)"]"] = netcam

	//playsound(origin, 'sound/machines/terminal_prompt.ogg', 25, FALSE)
	var/camera = tgui_input_list(usr, "Camera to view", "Cameras", T)
	if(isnull(camera))
		return
	if(isnull(T[camera]))
		return
	var/obj/machinery/camera/final = T[camera]
	playsound(src, SFX_TERMINAL_TYPE, 25, FALSE)
	if(final)
		playsound(origin, 'sound/machines/terminal_prompt_confirm.ogg', 25, FALSE)
		remote_eye.setLoc(get_turf(final))
		owner.overlay_fullscreen("flash", /atom/movable/screen/fullscreen/flash/static)
		owner.clear_fullscreen("flash", 3) //Shorter flash than normal since it's an ~~advanced~~ console!
	else
		playsound(origin, 'sound/machines/terminal_prompt_deny.ogg', 25, FALSE)
*/

/datum/action/camera_multiz_up
	name = "Move up a floor"
	button_icon = 'icons/mob/camera_ui.dmi'
	button_icon_state = "move_up"
	var/mob/observer/eye/cameranet/remote/remote_eye

/datum/action/camera_multiz_up/Activate()
	if(!owner || !isliving(owner) || !remote_eye)
		return
	if(remote_eye.SelfMove(UP))
		to_chat(owner, SPAN_NOTICE("You move upwards."))
	else
		to_chat(owner, SPAN_NOTICE("You couldn't move upwards!"))


/datum/action/camera_multiz_down
	name = "Move down a floor"
	button_icon = 'icons/mob/camera_ui.dmi'
	button_icon_state = "move_down"
	var/mob/observer/eye/cameranet/remote/remote_eye

/datum/action/camera_multiz_down/Activate()
	if(!owner || !isliving(owner) || !remote_eye)
		return
	if(remote_eye.SelfMove(DOWN))
		to_chat(owner, SPAN_NOTICE("You move downwards."))
	else
		to_chat(owner, SPAN_NOTICE("You couldn't move downwards!"))