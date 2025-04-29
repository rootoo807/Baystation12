//Platters - platters/bowls with multiple snacks to be dispensed. Ported from Aurora.

/obj/item/reagent_containers/food/snacks/platter
	name = "a bowl of item"
	desc = "If you're seeing this, something has gone wrong D:"
	icon_state = "puffpuffbowl_full"
	trash = /obj/item/trash/snack_bowl
	bitesize = 4
	var/vendingobject = /obj/item/reagent_containers/food/snacks/puffpuff
	var/unitname = "contained_food"

/obj/item/reagent_containers/food/snacks/platter/on_reagent_change()
	..()
	update_icon()

/obj/item/reagent_containers/food/snacks/platter/attack_hand(mob/user as mob)
	var/obj/item/reagent_containers/food/snacks/returningitem = new vendingobject(loc)
	returningitem.reagents.clear_reagents()
	reagents.trans_to(returningitem, bitesize)
	returningitem.bitesize = bitesize/2
	user.put_in_hands(returningitem)
	if (reagents && reagents.total_volume)
		to_chat(user, "You take \a [unitname] from the plate.")
	else
		to_chat(user, "You take the last [unitname] from the plate.")
		var/obj/waste = new trash(loc)
		if (loc == user)
			user.put_in_hands(waste)
		qdel(src)

/obj/item/reagent_containers/food/snacks/platter/MouseDrop(mob/user)
	if(CanMouseDrop(user))
		user.put_in_active_hand(src)
		src.pickup(user)
		return
	. = ..()


/obj/item/reagent_containers/food/snacks/platter/puffpuffs
	name = "puff-puff bowl"
	desc = "A bowl of puffy dough balls. Much like donut balls except pan-fried, chewier, and often served savory, not just sweet. It originates in Nigeria, but it's a popular snack in New Benin and across many parts of Earther space."
	icon_state = "puffpuffbowl_full"
	filling_color = "#bb8a41"
	bitesize = 4
	default_reagents = list(
		/datum/reagent/spacespice = 2,
		/datum/reagent/sodiumchloride = 1)
	default_reagents_data = list(/datum/reagent/spacespice = list("ginger" = 2))
	additional_reagents = list(/datum/reagent/nutriment = 24)
	additional_reagents_data = list(/datum/reagent/nutriment = list("fried dough" = 24))
	vendingobject = /obj/item/reagent_containers/food/snacks/puffpuff
	unitname = "puff-puff"

/obj/item/reagent_containers/food/snacks/platter/puffpuffs/on_update_icon()
	switch(reagents.total_volume)
		if(1 to 12)
			icon_state = "puffpuffbowl_few"
		if(13 to INFINITY)
			icon_state = "puffpuffbowl_full"


/obj/item/reagent_containers/food/snacks/puffpuff
	name = "puff-puff"
	desc = "A nice, puffy, puff-puff. Mmmm, fried dough. You can feel your arteries clogging already!"
	icon_state = "puffpuff"
	filling_color = "#bb8a41"
	bitesize = 2
	default_reagents = list(
		/datum/reagent/spacespice = 0.3,
		/datum/reagent/sodiumchloride = 0.15,
		/datum/reagent/nutriment = 3.5)
	default_reagents_data = list(
		/datum/reagent/spacespice = list("ginger" = 2),
		/datum/reagent/nutriment = list("fried dough" = 24)
		)


/obj/item/reagent_containers/food/snacks/platter/latkes
	name = "latke platter"
	desc = "A plate of crispy potato pancakes. Get them while they're hot!"
	icon_state = "latkes_full"
	trash = /obj/item/trash/plate
	filling_color = "#e88d17"
	bitesize = 4
	default_reagents = list(
		/datum/reagent/drink/juice/potato = 9,
		/datum/reagent/nutriment/protein/egg = 3
		)
	additional_reagents = list(/datum/reagent/nutriment = 12)
	additional_reagents_data = list(/datum/reagent/nutriment = list("crispy goodness" = 12))
	vendingobject = /obj/item/reagent_containers/food/snacks/latke
	unitname = "latke"

/obj/item/reagent_containers/food/snacks/platter/latkes/on_update_icon()
	switch(reagents.total_volume)
		if(1 to 4)
			icon_state = "latkes_few"
		if(4 to 12)
			icon_state = "latkes_some"
		if(13 to INFINITY)
			icon_state = "latkes_full"


/obj/item/reagent_containers/food/snacks/latke
	name = "latke"
	desc = "A crispy latke, ready to eat. If only there was applesauce."
	icon_state = "latke"
	filling_color = "#e88d17"
	bitesize = 2
	default_reagents = list(
		/datum/reagent/drink/juice/potato = 1.5,
		/datum/reagent/nutriment/protein/egg = 0.5,
		/datum/reagent/nutriment = 2
		)
	default_reagents_data = list(/datum/reagent/nutriment = list("crispy goodness" = 2))


/obj/item/reagent_containers/food/snacks/platter/mozzarella_sticks
	name = "mozzarella sticks"
	gender = PLURAL
	desc = "Fried sticks of molten mozzarrella cheese hidden in a deep fried breaded coating."
	icon_state = "mozzarella_sticks_full"
	trash = /obj/item/trash/plate
	filling_color = "#fabe17"
	bitesize = 3
	default_reagents = list(
		/datum/reagent/nutriment/batter = 10,
		/datum/reagent/nutriment/protein/cheese = 8)
	default_reagents_data = list(/datum/reagent/nutriment/protein/cheese = list("fresh cheese" = 8))
	vendingobject = /obj/item/reagent_containers/food/snacks/mozzarella_stick
	unitname = "mozzarella stick"

/obj/item/reagent_containers/food/snacks/platter/mozzarella_sticks/on_update_icon()
	switch(reagents.total_volume)
		if(1 to 9)
			icon_state = "mozzarella_sticks_half"
		if(10 to INFINITY)
			icon_state = "mozzarella_sticks_full"


/obj/item/reagent_containers/food/snacks/mozzarella_stick
	name = "mozzarella stick"
	desc = "A cheese stick by any other name would taste as savory."
	icon_state = "mozzarella_stick"
	filling_color = "#fabe17"
	bitesize = 2
	default_reagents = list(
		/datum/reagent/nutriment/batter = 1.6,
		/datum/reagent/nutriment/protein/cheese = 1.4)
	default_reagents_data = list(/datum/reagent/nutriment/protein/cheese = list("fresh cheese" = 2))


/obj/item/reagent_containers/food/snacks/platter/eggrolls_vegetable
	name = "vegetable eggrolls"
	gender = PLURAL
	desc = "Fried, crispy eggrolls full of carrots, cabbage and ginger."
	icon_state = "eggrolls_veg_full"
	filling_color = "#b19445"
	trash = /obj/item/trash/plate
	bitesize = 6
	default_reagents = list(
		/datum/reagent/drink/juice/carrot = 10,
		/datum/reagent/imidazoline = 5,
		/datum/reagent/nutriment/protein/egg = 3
		)
	additional_reagents = list(/datum/reagent/nutriment = 6)
	additional_reagents_data = list(/datum/reagent/nutriment = list("crunchy coating" = 4, "ginger" = 2))
	vendingobject = /obj/item/reagent_containers/food/snacks/eggroll_vegetable
	unitname = "eggroll"

/obj/item/reagent_containers/food/snacks/platter/eggrolls_vegetable/on_update_icon()
	switch(reagents.total_volume)
		if(1 to 6)
			icon_state = "eggrolls_veg_one"
		if(7 to INFINITY)
			icon_state = "eggrolls_veg_full"

/obj/item/reagent_containers/food/snacks/eggroll_vegetable
	name = "vegetable eggroll"
	desc = "A crunchy eggroll full of crispy veggies."
	icon_state = "eggroll_veg"
	filling_color = "#b19445"
	bitesize = 3
	default_reagents = list(
		/datum/reagent/drink/juice/carrot = 2.5,
		/datum/reagent/imidazoline = 1.25,
		/datum/reagent/nutriment/protein/egg = 0.75,
		/datum/reagent/nutriment = 1.5
		)
	default_reagents_data = list(/datum/reagent/nutriment = list("crunchy coating" = 2, "ginger" = 1))


/obj/item/reagent_containers/food/snacks/platter/eggrolls_meat
	name = "meat eggrolls"
	gender = PLURAL
	desc = "Fried, crispy eggrolls full of meat, traditionally either pork or chicken, although other kinds exist around human space depending on local availability."
	icon_state = "eggrolls_meat_full"
	filling_color = "#613e16"
	trash = /obj/item/trash/plate
	bitesize = 5
	default_reagents = list(
		/datum/reagent/nutriment/protein = 7,
		/datum/reagent/nutriment/protein/egg = 3
		)
	additional_reagents = list(/datum/reagent/nutriment = 10)
	additional_reagents_data = list(/datum/reagent/nutriment = list("crunchy coating" = 6, "ginger" = 4))
	vendingobject = /obj/item/reagent_containers/food/snacks/eggroll_meat
	unitname = "eggroll"

/obj/item/reagent_containers/food/snacks/platter/eggrolls_meat/on_update_icon()
	switch(reagents.total_volume)
		if(1 to 5)
			icon_state = "eggrolls_meat_one"
		if(6 to INFINITY)
			icon_state = "eggrolls_meat_full"

/obj/item/reagent_containers/food/snacks/eggroll_meat
	name = "meat eggroll"
	desc = "A crunchy eggroll full of meat and ginger."
	icon_state = "eggroll_meat"
	filling_color = "#613e16"
	bitesize = 3
	default_reagents = list(
		/datum/reagent/nutriment/protein = 1.75,
		/datum/reagent/nutriment/protein/egg = 0.75,
		/datum/reagent/nutriment = 2.5
		)
	default_reagents_data = list(/datum/reagent/nutriment = list("crunchy coating" = 2, "ginger" = 1))