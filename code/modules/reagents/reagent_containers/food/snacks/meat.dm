/obj/item/reagent_containers/food/snacks/meat
	name = "meat"
	desc = "A slab of meat."
	icon_state = "meat"
	slice_path = /obj/item/reagent_containers/food/snacks/rawcutlet
	slices_num = 3
	filling_color = "#ff1c1c"
	center_of_mass = "x=16;y=14"
	bitesize = 3
	default_reagents = list(/datum/reagent/nutriment/protein = 9)


/obj/item/reagent_containers/food/snacks/meat/syntiflesh
	name = "synthetic meat"
	desc = "A slab of flesh synthetized from reconstituted biomass or artificially grown from chemicals."
	default_reagents_data = list(/datum/reagent/nutriment/protein = list("synthetic meat" = 4,"chemicals" = 5))


/obj/item/reagent_containers/food/snacks/meat/human
	default_reagents_data = list(/datum/reagent/nutriment/protein = list("pork" = 9))

/obj/item/reagent_containers/food/snacks/meat/human/skrell
	name = "skrell fillet"
	icon_state = "fishfillet"
	color = "#1d2cbf"
	filling_color = "#1d2cbf"
	default_reagents = list(
		/datum/reagent/nutriment/protein/shellfish = 9,
		/datum/reagent/drugs/hextro = 3
		)
	default_reagents_data = list(/datum/reagent/nutriment/protein/shellfish = list("slimy mollusk" = 9))

/obj/item/reagent_containers/food/snacks/meat/human/unathi
	name = "unathi meat"
	icon_state = "moghesmeat"
	filling_color = "#f24b2e"
	default_reagents_data = list(/datum/reagent/nutriment/protein = list("reptile meat" = 9))

/obj/item/reagent_containers/food/snacks/meat/human/vox
	name = "vox meat"
	color = "#2299fc"
	filling_color = "#2299fc"
	default_reagents = list(
		/datum/reagent/nutriment/protein = 9,
		/datum/reagent/ammonia = 5
		)
	default_reagents_data = list(/datum/reagent/nutriment/protein = list("chicken" = 5, "ammonia" = 4))

/obj/item/reagent_containers/food/snacks/meat/human/nabber
	name = "serpentid meat"
	filling_color = "#525252"
	default_reagents = list(
		/datum/reagent/nutriment/protein = 9,
		/datum/reagent/toxin/phoron = 5,
		/datum/reagent/dexalin = 3
		)
	default_reagents_data = list(/datum/reagent/nutriment/protein = list("acrid, crunchy meat" = 9))


/obj/item/reagent_containers/food/snacks/meat/monkey
	name = "monkey meat"
	default_reagents_data = list(/datum/reagent/nutriment/protein = list("monkey meat" = 9))

/obj/item/reagent_containers/food/snacks/meat/monkey/farwa
	name = "farwa meat"
	default_reagents_data = list(/datum/reagent/nutriment/protein = list("farwa meat" = 9))

/obj/item/reagent_containers/food/snacks/meat/monkey/neaera
	name = "neaera fillet"
	icon_state = "fishfillet"
	filling_color = "#1d2cbf"
	default_reagents = list(/datum/reagent/nutriment/protein/shellfish = 9)
	default_reagents_data = list(/datum/reagent/nutriment/protein/shellfish = list("slimy mollusk" = 9))

/obj/item/reagent_containers/food/snacks/meat/monkey/stok
	name = "stok meat"
	filling_color = "#f24b2e"
	icon_state = "moghesmeat"
	default_reagents_data = list(/datum/reagent/nutriment/protein = list("reptile meat" = 9))


/obj/item/reagent_containers/food/snacks/meat/corgi
	name = "corgi meat"
	desc = "Tastes like... well, you know."
	default_reagents_data = list(/datum/reagent/nutriment/protein = list("dog meat" = 9))

/obj/item/reagent_containers/food/snacks/meat/beef
	name = "beef steak"
	desc = "The classic red meat."
	default_reagents_data = list(/datum/reagent/nutriment/protein = list("beef" = 9))

/obj/item/reagent_containers/food/snacks/meat/pork
	name = "pork steak"
	desc = "Meat from a pig. Rather hard to get this far out in deep space."
	default_reagents_data = list(/datum/reagent/nutriment/protein = list("pork" = 9))

/obj/item/reagent_containers/food/snacks/meat/goat
	name = "chevon steak"
	desc = "Goat meat, to the uncultured."
	default_reagents_data = list(/datum/reagent/nutriment/protein = list("goat" = 9))

/obj/item/reagent_containers/food/snacks/meat/chicken
	name = "chicken piece"
	desc = "It tastes like you'd expect."
	icon_state = "birdmeat"
	default_reagents_data = list(/datum/reagent/nutriment/protein = list("chicken" = 9))

/obj/item/reagent_containers/food/snacks/meat/chicken/game
	name = "game bird piece"
	desc = "Fresh game meat, harvested from some wild bird."
	default_reagents_data = list(/datum/reagent/nutriment/protein = list("poultry" = 9))

/obj/item/reagent_containers/food/snacks/meat/thoom
	name = "reptile steak"
	desc = "The most expensive steak you've ever laid eyes on."
	icon_state = "xenomeat"
	default_reagents_data = list(/datum/reagent/nutriment/protein = list("reptile meat" = 9))
