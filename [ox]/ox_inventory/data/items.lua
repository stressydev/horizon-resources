return {
    ['testburger'] = {
        label = 'Test Burger',
        weight = 220,
        degrade = 60,
        client = {
            image = 'burger_chicken.png',
            status = { hunger = 200000 },
            anim = 'eating',
            prop = 'burger',
            usetime = 2500,
            export = 'ox_inventory_examples.testburger'
        },
        server = {
            export = 'ox_inventory_examples.testburger',
            test = 'what an amazingly delicious burger, amirite?'
        },
        buttons = {
            {
                label = 'Lick it',
                action = function(slot)
                    print('You licked the burger')
                end
            },
            {
                label = 'Squeeze it',
                action = function(slot)
                    print('You squeezed the burger :(')
                end
            },
            {
                label = 'What do you call a vegan burger?',
                group = 'Hamburger Puns',
                action = function(slot)
                    print('A misteak.')
                end
            },
            {
                label = 'What do frogs like to eat with their hamburgers?',
                group = 'Hamburger Puns',
                action = function(slot)
                    print('French flies.')
                end
            },
            {
                label = 'Why were the burger and fries running?',
                group = 'Hamburger Puns',
                action = function(slot)
                    print('Because they\'re fast food.')
                end
            }
        },
        consume = 0.3
    },

    ['bandage'] = {
        label = 'Bandage',
        weight = 115,
        degrade = 1440 * 7,
		decay = true,
    },

    ['burger'] = {
        label = 'Burger',
        weight = 220,
        client = {
            status = { hunger = 200000 },
            anim = 'eating',
            prop = 'burger',
            usetime = 2500,
            notification = 'You ate a delicious burger'
        },
    },

    ['sprunk'] = {
        label = 'Sprunk',
        weight = 350,
        client = {
            status = { thirst = 200000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_ld_can_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
            usetime = 2500,
            notification = 'You quenched your thirst with a sprunk'
        }
    },

    ['parachute'] = {
        label = 'Parachute',
        weight = 8000,
        stack = false,
        client = {
            anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
            usetime = 1500
        }
    },

    ['garbage'] = {
        label = 'Garbage',
    },

    ['paperbag'] = {
        label = 'Paper Bag',
        weight = 1,
        stack = false,
        close = false,
        consume = 0
    },

    ['panties'] = {
        label = 'Knickers',
        weight = 10,
        consume = 0,
        client = {
            status = { thirst = -100000, stress = -25000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_cs_panties_02`, pos = vec3(0.03, 0.0, 0.02), rot = vec3(0.0, -13.5, -1.5) },
            usetime = 2500,
        }
    },

    ['lockpick'] = {
        label = 'Lockpick',
        weight = 160,
        decay = true,
		degrade = 1440 * 30
    },

    ['phone'] = {
        label = 'Phone',
        weight = 190,
        stack = false,
        consume = 0,
        decay = true,
		degrade = 1440 * 4
    },

    ['mustard'] = {
        label = 'Mustard',
        weight = 500,
        client = {
            status = { hunger = 25000, thirst = 25000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_food_mustard`, pos = vec3(0.01, 0.0, -0.07), rot = vec3(1.0, 1.0, -1.5) },
            usetime = 2500,
            notification = 'You... drank mustard'
        }
    },

    ['water'] = {
        label = 'Water',
        weight = 500,
        consume = 0,
		degrade = 60 * 2,
		client = { event = 'stressy-fastfood:consumeItem' }
    },

    ['armour'] = {
        label = 'Bulletproof Vest',
        weight = 3000,
        stack = false,
        client = {
            anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
            usetime = 3500
        }
    },

    ["box-44"] = {
		label = "Ammo Box 45 ACP",
		weight = 1000,
	},

    ['clothing'] = {
        label = 'Clothing',
        consume = 0,
    },

    ['money'] = {
        label = 'Money',
    },

    ['black_money'] = {
        label = 'Dirty Money',
    },

    ['id_card'] = {
        label = 'Identification Card',
    },

    ['driver_license'] = {
        label = 'Drivers License',
    },

    ['weaponlicense'] = {
        label = 'Weapon License',
    },

    ['lawyerpass'] = {
        label = 'Lawyer Pass',
    },

    ['radio'] = {
        label = 'Radio',
        weight = 1000,
        allowArmed = true,
        consume = 0,
        client = {
            event = 'mm_radio:client:use'
        }
    },

    ['jammer'] = {
        label = 'Radio Jammer',
        weight = 10000,
        allowArmed = true,
        client = {
            event = 'mm_radio:client:usejammer'
        }
    },

    ['radiocell'] = {
        label = 'AAA Cells',
        weight = 1000,
        stack = true,
        allowArmed = true,
        client = {
            event = 'mm_radio:client:recharge'
        }
    },

    ['advancedlockpick'] = {
        label = 'Advanced Lockpick',
        weight = 200,
		decay = true,
		degrade = 1440 * 30,
    },

    ['screwdriverset'] = {
        label = 'Screwdriver Set',
        weight = 500,
    },

    ['electronickit'] = {
        label = 'Electronic Kit',
        weight = 500,
    },

    ['cleaningkit'] = {
        label = 'Cleaning Kit',
        weight = 500,
    },

    ['repairkit'] = {
        label = 'Repair Kit',
        weight = 2500,
    },

    ['advancedrepairkit'] = {
        label = 'Advanced Repair Kit',
        weight = 4000,
    },

    ['diamond_ring'] = {
        label = 'Diamond',
        weight = 1500,
    },

    ['rolex'] = {
        label = 'Golden Watch',
        weight = 1500,
    },

    ['goldbar'] = {
        label = 'Gold Bar',
        weight = 1500,
    },

    ['goldchain'] = {
        label = 'Golden Chain',
        weight = 1500,
    },

    ['crack_baggy'] = {
        label = 'Crack Baggy',
        weight = 100,
    },

    ['cokebaggy'] = {
        label = 'Bag of Coke',
        weight = 100,
    },

    ['coke_brick'] = {
        label = 'Coke Brick',
        weight = 2000,
    },

    ['coke_small_brick'] = {
        label = 'Coke Package',
        weight = 1000,
    },

    ['xtcbaggy'] = {
        label = 'Bag of Ecstasy',
        weight = 100,
    },

    ['meth'] = {
        label = 'Methamphetamine',
        weight = 100,
    },

    ['oxy'] = {
        label = 'Oxycodone',
        weight = 100,
    },

    ['weed_ak47'] = {
        label = 'AK47 2g',
        weight = 200,
    },

    ['weed_ak47_seed'] = {
        label = 'AK47 Seed',
        weight = 1,
    },

    ['weed_skunk'] = {
        label = 'Skunk 2g',
        weight = 200,
    },

    ['weed_skunk_seed'] = {
        label = 'Skunk Seed',
        weight = 1,
    },

    ['weed_amnesia'] = {
        label = 'Amnesia 2g',
        weight = 200,
    },

    ['weed_amnesia_seed'] = {
        label = 'Amnesia Seed',
        weight = 1,
    },

    ['weed_og-kush'] = {
        label = 'OGKush 2g',
        weight = 200,
    },

    ['weed_og-kush_seed'] = {
        label = 'OGKush Seed',
        weight = 1,
    },

    ['weed_white-widow'] = {
        label = 'OGKush 2g',
        weight = 200,
    },

    ['weed_white-widow_seed'] = {
        label = 'White Widow Seed',
        weight = 1,
    },

    ['weed_purple-haze'] = {
        label = 'Purple Haze 2g',
        weight = 200,
    },

    ['weed_purple-haze_seed'] = {
        label = 'Purple Haze Seed',
        weight = 1,
    },

    ['weed_brick'] = {
        label = 'Weed Brick',
        weight = 2000,
    },

    ['weed_nutrition'] = {
        label = 'Plant Fertilizer',
        weight = 2000,
    },

    ['joint'] = {
        label = 'Joint',
        weight = 200,
    },

    ['rolling_paper'] = {
        label = 'Rolling Paper',
        weight = 0,
    },

    ['empty_weed_bag'] = {
        label = 'Empty Weed Bag',
        weight = 0,
    },

    ['firstaid'] = {
        label = 'First Aid',
        weight = 2500,
    },

    ['ifaks'] = {
        label = 'Individual First Aid Kit',
        weight = 2500,
    },

    ['painkillers'] = {
        label = 'Painkillers',
        weight = 400,
    },

    ['firework1'] = {
        label = '2Brothers',
        weight = 1000,
    },

    ['firework2'] = {
        label = 'Poppelers',
        weight = 1000,
    },

    ['firework3'] = {
        label = 'WipeOut',
        weight = 1000,
    },

    ['firework4'] = {
        label = 'Weeping Willow',
        weight = 1000,
    },

    ['steel'] = {
        label = 'Steel',
        weight = 100,
    },

    
	['recyclables'] = {
		label = 'Recyclables',
		weight = 50,
	},

    ['tech_parts'] = {
		label = 'Tech Parts',
		weight = 50,
	},

    ['steel_parts'] = {
		label = 'Steel Parts',
		weight = 50,
	},


    ['capacitor'] = {
		label = 'Capacitor',
		weight = 10,
	},

    ['weapon_parts'] = {
		label = 'Weapon Parts',
		weight = 50,
	},

    ['tech_trash'] = {
		label = 'Tech Trash',
		weight = 10,
	},


    ['rubber'] = {
        label = 'Rubber',
        weight = 100,
    },

    ['metalscrap'] = {
        label = 'Metal Scrap',
        weight = 100,
    },

    ['iron'] = {
        label = 'Iron',
        weight = 100,
    },

    ['copper'] = {
        label = 'Copper',
        weight = 100,
    },

    ['aluminum'] = {
        label = 'Aluminium',
        weight = 100,
    },

    ['plastic'] = {
        label = 'Plastic',
        weight = 100,
    },

    ['glass'] = {
        label = 'Glass',
        weight = 100,
    },

    ['gatecrack'] = {
        label = 'Gatecrack',
        weight = 1000,
    },

    ['cryptostick'] = {
        label = 'Crypto Stick',
        weight = 100,
    },

    ['trojan_usb'] = {
        label = 'Trojan USB',
        weight = 100,
    },

    ['toaster'] = {
        label = 'Toaster',
        weight = 5000,
    },

    ['small_tv'] = {
        label = 'Small TV',
        weight = 100,
    },

    ['laptop'] = {
        label = 'Laptop',
        weight = 100,
    },

    ['game_console'] = {
        label = 'Game Console',
        weight = 100,
    },

    ['security_card_01'] = {
        label = 'Security Card A',
        weight = 100,
    },

    ['security_card_02'] = {
        label = 'Security Card B',
        weight = 100,
    },

    ['drill'] = {
        label = 'Drill',
        weight = 5000,
    },

    ['thermite'] = {
        label = 'Thermite',
        weight = 1000,
    },

    ['diving_gear'] = {
        label = 'Diving Gear',
        weight = 30000,
    },

    ['diving_fill'] = {
        label = 'Diving Tube',
        weight = 3000,
    },

    ['antipatharia_coral'] = {
        label = 'Antipatharia',
        weight = 1000,
    },

    ['dendrogyra_coral'] = {
        label = 'Dendrogyra',
        weight = 1000,
    },

    ['jerry_can'] = {
        label = 'Jerrycan',
        weight = 3000,
    },

    ['nitrous'] = {
        label = 'Nitrous',
        weight = 1000,
    },

    ['wine'] = {
        label = 'Wine',
        weight = 500,
    },

    ['grape'] = {
        label = 'Grape',
        weight = 10,
    },

    ['orange'] = {
        label = 'Orange',
        weight = 10,
    },

    ['grapejuice'] = {
        label = 'Grape Juice',
        weight = 200,
    },

    ['coffee'] = {
        label = 'Coffee',
        weight = 100,
		decay = true,
		consume = 0,
		degrade = 60 * 2,
        client = { event = 'stressy-fastfood:consumeItem' }
    },

    ['vodka'] = {
        label = 'Vodka',
        weight = 500,
    },

    ['whiskey'] = {
        label = 'Whiskey',
        weight = 200,
    },

    ['beer'] = {
        label = 'Beer',
        weight = 200,
    },

    ['sandwich'] = {
        label = 'Sandwich',
        weight = 100,
        consume = 0,
		degrade = 60 * 2,
        client = { event = 'stressy-fastfood:consumeItem' }
    },

    ['walking_stick'] = {
        label = 'Walking Stick',
        weight = 1000,
    },

    ['lighter'] = {
        label = 'Lighter',
        weight = 200,
    },

    ['binoculars'] = {
        label = 'Binoculars',
        weight = 800,
    },

    ['stickynote'] = {
        label = 'Sticky Note',
        weight = 0,
    },

    ['empty_evidence_bag'] = {
        label = 'Empty Evidence Bag',
        weight = 200,
    },

    ['filled_evidence_bag'] = {
        label = 'Filled Evidence Bag',
        weight = 200,
    },

    ['harness'] = {
        label = 'Harness',
        weight = 200,
    },

    ['handcuffs'] = {
        label = 'Handcuffs',
        weight = 200,
        degrade = 1440 * 30,
		stack = false,
		close = true,
    },

    -- Businesses --
	['produce_basket'] = {
		label = 'Produce Basket',
		weight = 100,
		consume = 0,
		decay = true,
		degrade = 1440 * 7,
	},
	
	['aromatics'] = {
		label = 'Aromatics',
		weight = 50,
		consume = 0,
		decay = true,
		degrade = 1440 * 7,
	},

	['cooking_oil'] = {
		label = 'Cooking Oil',
		weight = 50,
		consume = 0,
		decay = true,
		degrade = 1440 * 7,
	},

    ['butter'] = {
		label = 'Butter',
		weight = 50,
		consume = 0,
		decay = true,
		degrade = 1440 * 7,
	},

	['syrups'] = {
		label = 'Syrups',
		weight = 50,
		consume = 0,
		decay = true,
		degrade = 1440 * 7,
	},

	['sugar'] = {
		label = 'Sugar',
		weight = 100,
		consume = 0,
		decay = true,
		degrade = 1440 * 7,
	},

	['raw_meat'] = {
		label = 'Raw Meat',
		weight = 250,
		consume = 0,
	},

	['minced_meat'] = {
		label = 'Minced Meat',
		weight = 250,
		consume = 0,
		decay = true,
		degrade = 1440 * 7,
	},

	['packed_meat'] = {
		label = 'Packed Minced Meat',
		weight = 250,
		consume = 0,
		decay = true,
		degrade = 1440 * 30,
	},

	['food_delivery'] = {
		label = 'Food Delivery',
		weight = 250,
		consume = 0,
		decay = true,
		degrade = 60 * 3,
	},

    ---- FARMING ----

    ['shovel'] = {
		label = 'Farming Shovel',
		weight = 250,
		consume = 0,
		decay = true,
		stack = false,
		degrade = 1440 * 7,
	},

	['carrot'] = {
		label = 'Carrot',
		weight = 10,
		consume = 0,
	},

	['tomato'] = {
		label = 'Tomato',
		weight = 10,
		consume = 0,
	},

	['onion'] = {
		label = 'Onion',
		weight = 10,
		consume = 0,
	},

	['potato'] = {
		label = 'Potato',
		weight = 10,
		consume = 0,
	},

	['grain'] = {
		label = 'Wheat Grain',
		weight = 10,
		consume = 0,
	},

    ['food'] = {
		label = 'Food',
		weight = 10,
		consume = 0,
		degrade = 60 * 4,
		decay = true,
		client = { event = 'stressy-fastfood:consumeItem' }
	},

	['drink'] = {
		label = 'Drink',
		weight = 10,
		consume = 0,
		degrade = 60 * 4,
		decay = true,
		client = { event = 'stressy-fastfood:consumeItem' }
	},
    
	['cracking_tool'] = {
		label = 'Safe Cracking Tool',
		weight = 1000,
		consume = 0,
		degrade = 1440 * 30,
		decay = true,
		stack = false,
		client = { event = 'stressy-storerob:useCrackingTool' }
	},
    ['parcel'] = {
        label = 'Parcel',
        weight = 100,
        stack = true,
        consume = 1,
        client = {
            event = 'parcel:useParcel'
        }
    },
    --- DRUG SYSTEM
    
	["opium"] = {
    label = "Rolled Opium",
    description = "",
    weight = 2,
    degrade = 1440 * 14,
	},

	["opium_gram"] = {
		label = "Opium (1G)",
		description = "",
		weight = 1,
		degrade = 1440 * 14,
	},

	["opium_pooch"] = {
		label = "Bag of Opium (28G)",
		description = "",
		weight = 2,
		degrade = 1440 * 14,
	},

	["weed"] = {
		label = "Rolled Weed",
		description = "",
		weight = 2,
		degrade = 1440 * 14,
		client = { event = "jlabs-drugs:useweed"}
	},

	["weed_gram"] = {
		label = "Weed (1G)",
		description = "",
		weight = 1,
		degrade = 1440 * 14,
	},

	["coke_pooch"] = {
		label = "Bag of Coke (28G)",
		description = "",
		weight = 28,
		degrade = 1440 * 14,
	},

	["coke"] = {
		label = "Cocaine",
		description = "",
		weight = 2,
		degrade = 1440 * 14,
	},

	["coke_gram"] = {
		label = "Coca (1G)",
		description = "",
		weight = 2,
		degrade = 1440 * 14,
	},

	["crystal_meth"] = {
		label = "Crystal Meth (1G)",
		description = "",
		weight = 1,
		degrade = 1440 * 14,
	},

	["meth"] = {
		label = "Meth",
		description = "",
		weight = 1,
		degrade = 1440 * 14,
	},

	["meth_gram"] = {
		label = "Meth (1G)",
		description = "",
		weight = 1,
		degrade = 1440 * 14,
	},

	["meth_pooch"] = {
		label = "Bag of Meth (28G)",
		description = "",
		weight = 28,
		degrade = 1440 * 14,
	},

	["meth_stove"] = {
		label = "Camping Stove",
		description = "",
		weight = 10,
		degrade = 1440 * 14,
		client = { event = 'jlabs-drugs:useMethStove' }
	},

	["rolled_crystalmeth"] = {
		label = "Rolled Crystal Meth",
		description = "",
		weight = 2,
		degrade = 1440 * 14,
		client = { event = "jlabs-drugs:useCrystalMeth"}
	},

	["rolled_meth"] = {
		label = "Rolled Meth",
		description = "",
		weight = 2,
		degrade = 1440 * 14,
		client = { event = "jlabs-drugs:useMeth"}
	},

	["packed_crystalmeth"] = {
		label = "Packed Crystal Meth",
		description = "",
		weight = 22,
		degrade = 1440 * 14,
	},

	["packed_meth"] = {
		label = "Packed Meth",
		description = "",
		weight = 22,
		degrade = 1440 * 14,
	},

	["packed_weed"] = {
		label = "Packed Weed",
		description = "",
		weight = 22,
		degrade = 1440 * 14,
	},

	["rolling_paper"] = {
		label = "Rolling Paper",
		description = "",
		weight = 1,
		degrade = 1440 * 14,
	},

	["red_phosphorus"] = {
		label = "Red Phosphorus",
		description = "",
		weight = 1,
		degrade = 1440 * 14,
	},

	["acetone"] = {
		label = "Acetone",
		description = "",
		weight = 1,
		degrade = 1440 * 14,
	},

	["sulfuric_acid"] = {
		label = "Sulfuric Acid",
		description = "",
		weight = 1,
		degrade = 1440 * 14,
	},

	["sodium_hydroxide"] = {
		label = "Sodium Hydroxide",
		description = "",
		weight = 1,
		degrade = 1440 * 14,
	},
	["seed_weed"] = {
		label = "Seed Weed",
		description = "",
		weight = 1,
		degrade = 1440 * 14,
		client = { event = 'jlabs-drugs:useSeedWeed' }
	},
	["fertilizer"] = {
		label = "Fertilizer",
		description = "",
		weight = 3,
		degrade = 1440 * 14,
	},
	["gazbottle"] = {
		label = "Gas Bottle",
		description = "",
		weight = 3,
		degrade = 1440 * 14,
	},
	["rolling_paper"] = {
		label = "Rolling Paper",
		description = "",
		weight = 1,
		client = { event = "jlabs-drugs:useRollingPaper"},
		degrade = 1440 * 14,
	},

	["plant_pot"] = {
		label = "Plant Pot",
		description = "",
		weight = 2,
		degrade = 1440 * 14,
	},

	["drug_bag"] = {
		label = "Zip Lock",
		description = "",
		weight = 1,
		degrade = 1440 * 14,
		client = { event = "jlabs-drugs:useDrugBag"}
	},

	['meth_cooking_table'] = {
		label = 'Meth Cooking Table',
		weight = 20000,
		stack = false,
		close = true,
		description = 'Portable meth cooking setup.',
		server = {
			export = 'jlabs-drugs.useMethLab'
		}
	},


	["carpart_wheel"] = {
		label = "Wheel",
		weight = 10000,
		stack = false,
		close = false,
		description = "Wheel from a car",
		client = {
			image = "carpart_wheel.png",
		}
	},
	["carpart_door"] = {
		label = "Door",
		weight = 10000,
		stack = false,
		close = false,
		description = "Door from a car",
		client = {
			image = "carpart_door.png",
		}
	},
	["carpart_hood"] = {
		label = "Hood",
		weight = 10000,
		stack = false,
		close = false,
		description = "Hood from a car",
		client = {
			image = "carpart_hood.png",
		}
	},
	["carpart_trunk"] = {
		label = "Trunk",
		weight = 10000,
		stack = false,
		close = false,
		description = "Trunk from a car",
		client = {
			image = "carpart_trunk.png",
		}
	},
    
    ["vpn_router"] = {
		label = "VPN Router",
		weight = 100,
		stack = false,
		close = false,
	},

	['rental_papers'] = {
		label = "Rental Papers",
		weight = 0,
	},

    
    	['shirt'] = {
		label = "Shirt",
		weight = 20,
        client = { event = "stressy-shits:useClothingItem" },
        stack = false
	},

    ['pants'] = {
		label = "Pants",
		weight = 20,
        client = { event = "stressy-shits:useClothingItem" },
        stack = false
	},

    ['shoes'] = {
		label = "Shoes",
		weight = 20,
        client = { event = "stressy-shits:useClothingItem" },
        stack = false
	},

    ['mask'] = {
		label = "Mask",
		weight = 20,
        client = { event = "stressy-shits:useClothingItem" },
        stack = false
	},

    ['hat'] = {
		label = "Hat",
		weight = 20,
        client = { event = "stressy-shits:useClothingItem" },
        stack = false
	},

	['glasses'] = {
		label = "Glasses",
		weight = 20,
        client = { event = "stressy-shits:useClothingItem" },
        stack = false
	},

	['vest'] = {
		label = "Clothing Vest",
		weight = 20,
        client = { event = "stressy-shits:useClothingItem", image = 'clothing_vest.png' },
        stack = false
	},

	['bag'] = {
		label = "Clothing Bag",
		weight = 20,
        client = { event = "stressy-shits:useClothingItem" },
        stack = false
	},
    
	['basic_rod'] = {
		label = 'Fishing rod',
		stack = false,
		weight = 250,
		decay = true,
		--consume = 0,
		degrade = 1440 * 30,
	},

	['graphite_rod'] = {
		label = 'Graphite rod',
		stack = false,
		weight = 350,
        decay = true,
		--consume = 0,
		degrade = 1440 * 30,
	},

	['titanium_rod'] = {
		label = 'Titanium rod',
		stack = false,
		weight = 450,
        decay = true,
		--consume = 0,
		degrade = 1440 * 30,
	},

	['worms'] = {
		label = 'Worms',
		weight = 10,
        decay = true,
		--consume = 0,
		degrade = 1440 * 30,
	},

	['artificial_bait'] = {
		label = 'Artificial bait',
		weight = 30
	},

	['anchovy'] = {
		label = 'Anchovy',
		weight = 20
	},

	['grouper'] = {
		label = 'Grouper',
		weight = 3500
	},

	['haddock'] = {
		label = 'Haddock',
		weight = 500
	},

	['mahi_mahi'] = {
		label = 'Mahi Mahi',
		weight = 3500
	},

	['piranha'] = {
		label = 'Piranha',
		weight = 1500
	},

	['red_snapper'] = {
		label = 'Red Snapper',
		weight = 2500
	},

	['salmon'] = {
		label = 'Salmon',
		weight = 1000
	},

	['shark'] = {
		label = 'Shark',
		weight = 7500
	},

	['trout'] = {
		label = 'Trout',
		weight = 750
	},

	['tuna'] = {
		label = 'Tuna',
		weight = 10000
	},
    ['voucher'] = {
        label = 'Voucher',
        weight = 1,
        stack = false,
        close = true
    }
}
