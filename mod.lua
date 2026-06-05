-- Data Setup
local dev_path = ModPath .. "dev.json"
local weights_path = SavePath .. "FHweights.json"
if not Global.FH then
    Global.FH = { weights = {}, abandoned = false }
end
if next(Global.FH.weights) then -- next checks if it has any data
    io.save_as_json(Global.FH.weights, weights_path)
else
    Global.FH.weights = io.load_as_json(weights_path) or {}
end
FH = {
    dev_path = dev_path,
    log_file = io.load_as_json(dev_path),
    misplays = 0,
    units_reviving = {},
    options_file = SavePath .. "FHoptions.json",
    options = {
        loot_secured = true,
        civ_kill = true,
        teammate_electrocuted = true,
        flash = true,
        downed = true,
        custody = true,
        medbag = true,
        welcome = true,

        sequences = true,

        mark_non_users = false,
    },
    clients = {},
    hint_params = {
        hud_loot_secured_title = { chance = 0.35, cooldown = 30 },

        downed_generic = { chance = 0.25 },
        downed_SPOOCed = { chance = 0.5 },

        downed_mobster_boss = { chance = 0.5 },
        downed_hector_boss = { chance = 0.5 },
        downed_biker_boss = { chance = 0.5 },
        downed_chavez_boss = { chance = 0.5 },
        downed_drug_lord_boss = { chance = 0.5 },
        downed_triad_boss = { chance = 0.5 },
        downed_deep_boss = { chance = 0.5 },
        downed_snowman_boss = { chance = 0.5 },
        downed_piggydozer = { chance = 0.5 },

        replenished_nothing_2 = { sequence_chance = 0.3, sequence_skips = 1 },
        --hud_civilian_killed_title = { sequence_chance = 1 / 50 },
        hud_gage_assignment_progress = { sequence_chance = 1 / 150 },
    },
    hint_disabled_on = {
        hint_you_helpedup = "LOCAL",
        hint_teammate_downed = "TEAMMATE",
        hint_teammate_helpedup = "LOCAL",
        hint_you_were_helpedup = "LOCAL",
    },
    hints_without_id = {
        -- Hud
        hud_hint_bipod_nomount = true,
        hud_vehicle_broken = true,
        hud_vehicle_no_enter_carry = true,

        -- MidText
        hud_civilian_killed_title = true,
        hud_loot_secured_title = true,
    },
    shared_ids = {
        level = {
            welcome_to_the_jungle_1_night = "welcome_to_the_jungle_1",
            watchdogs_1_night = "watchdogs_1",
            watchdogs_2_day = "watchdogs_2",
            election_day_3_skip1 = "election_day_3",
            election_day_3_skip2 = "election_day_3",
            crojob3_night = "crojob3",

            arm_hcm = "arm",
            arm_und = "arm",
            arm_fac = "arm",
            arm_par = "arm",
            arm_cro = "arm",

            escape_garage = "escape",
            escape_overpass = "escape",
            escape_cafe = "escape",
            escape_park = "escape",
            escape_street = "escape",
            escape_cafe_day = "escape",
            escape_park_day = "escape",
            escape_overpass_night = "escape",

            safehouse = "testing_map",
            empty = "testing_map",
            enemy_test = "testing_map",
            modders_devmap = "testing_map"
        },
        hint = {
            hint_full_health = "hint_full",
            hint_full_bodybags = "hint_full",
            hint_full_grenades = "hint_full",
            hint_full_ammo = "hint_full",
            hint_full_briefcase = "hint_full",
            hint_max_special_equipment = "hint_full",

            hint_sentry_not_enough_ammo_to_place = "hint_sentry_not_enough_ammo",
            hud_hint_nea_sentry_gun = "hint_sentry_not_enough_ammo",

            hud_hint_clean_block_interact = "hint_mask_off",
            hud_hint_mask_off_block_interact = "hint_mask_off",
        }
    },
    messages = {
        --Networked
        hint_teammate_downed_generic = {}, -- uses hint_teammate_downed messages

        hint_teammate_downed_boss_shared = { "$TEAMMATE; is getting bossed around." },

        hint_teammate_downed_mobster_boss = { "It's \"do svidaniya\" for $TEAMMATE;." },
        hint_teammate_downed_hector_boss = { "$TEAMMATE; is weaker than a rat." },
        hint_teammate_downed_biker_boss = { "I'm jealous of $TEAMMATE;." },
        hint_teammate_downed_chavez_boss = { "$TEAMMATE; got out gangsta'd." },
        hint_teammate_downed_drug_lord_boss = { "That saucy bastard got $TEAMMATE;!" },
        hint_teammate_downed_triad_boss = { "$TEAMMATE; is burning to a crisp.", "$TEAMMATE; went down to a Firebender.", "Hey, is $TEAMMATE; a water type?" },
        hint_teammate_downed_deep_boss = { "$TEAMMATE;? $TEAMMATE;!? $TEAMMATE;!!!" },
        hint_teammate_downed_snowman_boss = {},
        hint_teammate_downed_piggydozer = {},

        hint_teammate_downed_tank_mini = { "$TEAMMATE; got shredded.", "$TEAMMATE; is mostly bullet holes now.", "$TEAMMATE; faced the minigun and lost.", "$TEAMMATE;'s gun just wasn't big enough.", "Big gun! Big gun! Watch out!", "There's big big trouble with a big big gun at $TEAMMATE;.", "I think that gave $TEAMMATE; lead poisoning." },
        hint_teammate_downed_tank_hw = { "$TEAMMATE; got spooked.", "$TEAMMATE; got downed by a creature beyond comprehension.", "$TEAMMATE;'s worst nightmare came true.", "$TEAMMATE; got a heart attack (trust me).", "$TEAMMATE; got downed by a bad dream.", "$TEAMMATE; came face to face with the faceless dozer.", "$TEAMMATE; just can't handle a beast such as this." },
        hint_teammate_downed_swat_turret = { "$TEAMMATE; got downed by an immobile target.", "$TEAMMATE; got automated.", "$TEAMMATE; got downed by a clanker.", "$TEAMMATE; stood too long in front of a turret." },
        hint_teammate_downed_phalanx_vip = { "$TEAMMATE; has been graced by the Captain.", "Winters got $TEAMMATE;! We can't let that slide!" },
        hint_teammate_downed_phalanx_minion = { "$TEAMMATE; got downed by one of Captain's strays." },

        hint_teammate_downed_phalanx_formation = { "$TEAMMATE; fell to superior roman tactics.", "$TEAMMATE; couldn't get enough shots through.", "Don't let $TEAMMATE;'s sacrifice be in vain!", "$TEAMMATE; got downed to the hexagon.", "$TEAMMATE; got downed by the dog pile.", "$TEAMMATE; couldn't ring around the rosie fast enough." },

        hint_teammate_downed_dozer = { "$TEAMMATE; hit a wall.", "$TEAMMATE; got bulldozed.", "$TEAMMATE; is now very tender.", "Would you please help $TEAMMATE; with that Bulldozer?", "$TEAMMATE; would like to call your attention to the Bulldozer that has downed them.", "It might not be safe around $TEAMMATE; right now.", "You win some, you lose some.", "Hey it could be worse. That Bulldozer could be looking at you.", "$TEAMMATE; is too weak to fight a Bulldozer.", "Bulldozer wins! $TEAMMATE; loses.", "You should teach $TEAMMATE; how to fight a Bulldozer.", "I don't think $TEAMMATE; has enough DPS.", "The big round man got $TEAMMATE;.", "Bomb disposal got $TEAMMATE;.", "The shit-talker got $TEAMMATE;.", "$TEAMMATE; failed the DPS check." },
        hint_teammate_downed_cloaker = { "$TEAMMATE; got shot by the kicky guy.", "The cloaker didn't even need to cloak $TEAMMATE;.", "$TEAMMATE; got downed to a supressed MP5. I'll let you figure out what that means.", "There's a surprise waiting for you near $TEAMMATE;.", "The CQC guy decided to just gun down $TEAMMATE;.", "Not every day do you get gunned down by a cloaker. But $TEAMMATE; did.", "No feet action for $TEAMMATE;." },
        hint_teammate_downed_taser = { "$TEAMMATE; isn't getting the non-lethal treatment today.", "$TEAMMATE; got downed to 0 volts.", "Guess they're not bringing $TEAMMATE; in alive.", "I think $TEAMMATE; is wanted \"Dead, not alive\"." },
        hint_teammate_downed_medic = { "$TEAMMATE; needs a medic that won't shoot them.", "Ha ha! $TEAMMATE; got downed by a nurse!", "Don't worry $TEAMMATE; already has a medic attending to them." },
        hint_teammate_downed_sniper = { "$TEAMMATE; missed the laser.", "$TEAMMATE; has a laser pointed at them.", "Take cover! They got $TEAMMATE;!", "$TEAMMATE; got downed so you can be more careful.", "You aren't blind like $TEAMMATE;, right?", "$TEAMMATE; has met the sniper.", "$TEAMMATE; got downed by a remote worker.", "$TEAMMATE; got hit in the bullseye.", "$TEAMMATE; is in a sniper sightline.", "You should revive $TEAMMATE; without looking." },

        hint_teammate_downed_tased = { "Fried $TEAMMATE;.", "$TEAMMATE; got downed to 50'000 volts.", "Where were you when $TEAMMATE; was getting tased?", "You didn't get to $TEAMMATE; in time.", "Time's up. $TEAMMATE;'s down.", "You know you could have freed $TEAMMATE; before they got downed." },
        hint_teammate_downed_tased_assist = { "$TEAMMATE; got ganged up on.", "$TEAMMATE; got combo'd", "$TEAMMATE; just can't get a break.", "$TEAMMATE; got tased at a bad time." },
        hint_teammate_downed_SPOOCed = { "$TEAMMATE; got downed by a foot.", "$TEAMMATE;'s beautiful face!", "$TEAMMATE; got jumpscared.", "$TEAMMATE; didn't check their corners.", "$TEAMMATE; is being a victim of police brutality.", "Ninja cop got $TEAMMATE;.", "That glowy green eye guy got $TEAMMATE;.", "$TEAMMATE; has bad ears.", "$TEAMMATE; has bad reaction time.", "Sneaky fuck got $TEAMMATE;!", "$TEAMMATE; got wullullu'd.", "Runny boy got $TEAMMATE;.", "$TEAMMATE; got clocked by the cloaker.", "$TEAMMATE; didn't see that coming.", "There's a scary man on $TEAMMATE; right now.", "Don't get cloaked now too, okay?", "$TEAMMATE; is getting curb baton-ed.", "$TEAMMATE; is on the wrong end of a Nightstick.", "I think $TEAMMATE; needs a change of underwear.", "Get rid of the pest on $TEAMMATE;.", "If you keep your distance, you can take a pic of $TEAMMATE; getting bullied." },
        hint_teammate_downed_fall_damage = { "$TEAMMATE;'s clumsy.", "$TEAMMATE; has broken their legs.", "$TEAMMATE; fell to a clumsy, painful down.", "I could hear $TEAMMATE;'s bones cracking.", "$TEAMMATE; fell like a dumbass.", "$TEAMMATE; can't fly.", "What is $TEAMMATE; doing!?", "You really wanna have $TEAMMATE; on your team?", "I think $TEAMMATE; has brain damage.", "$TEAMMATE; got downed by $TEAMMATE;.", "$TEAMMATE; hit the ground too fast.", "$TEAMMATE; got downed by gravity." },

        hint_you_helpedup = { "You're a real teamplayer!", "Good work helping $TEAMMATE;!", "You got $TEAMMATE; back in the fight.", "Let's hope $TEAMMATE; appreciates that.", "You're $TEAMMATE;'s hero!", "$TEAMMATE; will thank you some day.", "$TEAMMATE; is still here thanks to you.", "You delayed $TEAMMATE;'s death.", "You should have just let $TEAMMATE; die.", "I don't think $TEAMMATE; deserved that.", "You're so nice.", "I'm proud of you.", "You put a smile on $TEAMMATE;'s face.", "[ $TEAMMATE; liked that ]", "That's it! Leave no one behind.", "Good job.", "Mates forever.", "You care about $TEAMMATE;, admit it.", "I would have never forgiven you if $TEAMMATE; died.", "I'm giving you a gold star.", "Your mother's very proud.", "That's your good deed for the day.", "Apes together strong." },
        hint_you_helpedup_touch = { "Give $TEAMMATE; a friendly smack for me.", "You got $TEAMMATE;'s blood on you. Ew...", "$TEAMMATE; is still a little sticky.", "Feel $TEAMMATE;'s muscle. Mhh!", "Ew you touched $TEAMMATE;!", "You don't look good. I think $TEAMMATE; got you sick.", "You have HIV now.", "You got the cooties now!", "Did you and $TEAMMATE; kiss?", "Get a room.", "Remember to wash your hands." },
        hint_teammate_helpedup = { "$TEAMMATE; is back in the fight!", "Don't worry $HELPER; got it.", "$HELPER; took care of $TEAMMATE; for you.", "$HELPER; is pretty cool. I bet $TEAMMATE; agrees.", "Never fear, $HELPER; is here!", "Thank $HELPER;.", "$TEAMMATE; is back up. No thanks to you.", "$HELPER; saved $TEAMMATE;!", "$HELPER; is better than you.", "$TEAMMATE; and $HELPER; are now best friends.", "A bond like $HELPER; and $TEAMMATE;'s can never be broken.", "$HELPER; is the MVP right now.", "$HELPER; got to $TEAMMATE; first.", "Does $HELPER; have to do everything for you?", "You should have been the one to help $TEAMMATE;.", "$TEAMMATE; wanted you but had to settle for $HELPER;.", "Helping $TEAMMATE; was your job.", "Too late. $HELPER; got the credit.", "$HELPER; is getting a reward from me.", "We all knew $HELPER; was better than you.", "$HELPER; brought a smile to $TEAMMATE;'s face.", "You won't get $TEAMMATE;'s love now.", "Why didn't you help $TEAMMATE;?", "Oh well, $TEAMMATE;'s taken care of.", "$HELPER; thought $TEAMMATE; deserved some help.", "Do you think $TEAMMATE; doesn't deserve your help?", "Situation over. $TEAMMATE;'s back up.", "$HELPER; earned some social credit.", "$TEAMMATE; is back up.", "$TEAMMATE;'s fine.", "I'm sure $TEAMMATE; didn't need really need the help anyway.", "I would have praised you if you helped.", "Now you're not getting the gold star.", "$HELPER; is the best.", "$HELPER; deserves a medal.", "Don't worry, $TEAMMATE; isn't dying anymore.", "$HELPER; has $TEAMMATE;'s back.", "What would we do without $HELPER;.", "Don't forget to help too. $HELPER; won't always be there.", "No need to feel bad for $TEAMMATE;. $HELPER; helped.", "$HELPER; was just closer to $TEAMMATE;, right?" },
        hint_teammate_helpedup_touch = { "$HELPER; and $TEAMMATE; touched each other.", "You think $HELPER; has medical training?", "$HELPER; and $TEAMMATE;, sitting in a tree, K-I-S-S-I-N-G!", "$TEAMMATE; gave $HELPER; the cooties.", "I think $HELPER; loves $TEAMMATE;.", "$TEAMMATE; and $HELPER; look cute together.", "I ship $TEAMMATE; and $HELPER;." },
        hint_you_were_helpedup = { "$HELPER; saved your ass.", "Thank $HELPER;.", "You're only alive because $HELPER; was here.", "You better appreciate what $HELPER; did for you.", "$HELPER; was here for you.", "What a good friend.", "Dust yourself off and get back to it.", "A near death experience isn't a reason to rest.", "You owe your life to $HELPER;.", "$HELPER; is so carrying you right now.", "Don't make me worried like that again.", "I was so worried about you.", "At least you didn't go into custody.", "No messiah?", "Got anything to say to $HELPER;?", "A thanks would be in order.", "Wake the fuck up Samurai.", "We've got a city to burn.", "You're finally awake.", "Oh hey, you didn't die.", "It could have been worse.", "At least you didn't go into custody.", "All better?", "Let this be a teachable moment.", "There. All better now.", "And stay out of trouble!", "Apes together strong." },
        hint_you_were_helpedup_touch = { "I don't like how $HELPER; touched you.", "You owe $HELPER; a pint.", "Did $HELPER; kiss your boo-boo?" },

        inspire_teammate = { "$TEAMMATE; was just being overdramatic.", "$TEAMMATE; felt inspired." },
        inspire_received = { "Break's over.", "Sleepy Head.", "You feel revitalized.", "Stop lollygagging.", "Get the fuck up!", "How'd your legs do that?", "You feel inspired.", "Drive-by revive!" },

        -- Extra
        inspire = { "$TEAMMATE; just needed some talking to.", "I don't think that's how you fix wounds.", "Shouting at a cripple are we?", "Wow that actually worked.", "Guess they're just lazy.", "This could have been a phone call.", "Do that in voice chat next time.", "Can you heal my mental issues with shouting too?", "$TEAMMATE; feels inspired.", "Drive-by revive!" },

        teammate_electrocuted = { "$TEAMMATE; is taking up dancing lessons.", "$TEAMMATE; gained parkinson's.", "Look at $TEAMMATE; go!", "Dance $TEAMMATE;, dance!", "$TEAMMATE; is shocked.", "$TEAMMATE; is shaking all over place.", "$TEAMMATE; is glowing.", "Oh look, you can see $TEAMMATE;'s skeleton!", "Looks like $TEAMMATE; wasn't properly grounded.", "$TEAMMATE; is tasting volts.", "$TEAMMATE; is getting zapped.", "Lightning Bolt was cast on $TEAMMATE;.", "$TEAMMATE; is suffering from a volt overdose.", "Seems $TEAMMATE; is conductive.", "$TEAMMATE;'s hairs are standing up.", "I'm shocked that $TEAMMATE; got shocked.", "$TEAMMATE; is cosplaying a Tesla Coil.", "$TEAMMATE; is fully charged!", "Hey what're those blue lines coming off of $TEAMMATE;?", "Look at your HUD, bud.", "Oh look, $TEAMMATE; got a lightning bolt icon.", "$TEAMMATE; is plugged in.", "$TEAMMATE; might need your help.", "$TEAMMATE; is full of Volts.", "$TEAMMATE; is eating Volts.", "$TEAMMATE; is charging.", "$TEAMMATE; is shining bright.", "$TEAMMATE; makes for a good light bulb.", "Why is $TEAMMATE; blue?", "I think $TEAMMATE; is having fun.", "I would like to bring to your attention that $TEAMMATE; is being electrocuted.", "$TEAMMATE; got the electric chair, without the chair.", "Something is happening." },

        downed_generic = { "Make sure to scoop your blood back in.", "You're gonna get lead poisoning at this rate.", "You won't make your father proud at this rate.", "You're phoning it in.", "Is this too much for you to handle?", "Your loadout sucks.", "I think you need to adjust your strategy.", "You're doing great.", "Trials and tribulations are to be expected.", "Whomp whomp.", "You can do better.", "It looks like you're downed. Would you like help?", "Reminder: you die when you get killed.", "You should avoid getting downed.", "Death is not a good thing. You don't want it.", "Now someone will have to touch you.", "Maybe the difficulty is too high for you.", "Rage quit. Come on, do it.", "Listen, you're not cut out for this. Hand me the keyboard.", "Now you see, personally, I wouldn't have done that.", "You got a thing for playing games poorly?" },

        downed_boss_shared = { "Like a boss." },

        downed_mobster_boss = {},
        downed_hector_boss = { "Hector, how could you?", "You're supposed to kill the rat, not get killed by him!" },
        downed_biker_boss = { "Looks like you need more TRAIN-ing.", "I wish she would shoot me too." },
        downed_chavez_boss = { "What cocaine does to a guy, huh?", "He has the secret power of cocaine on his side." },
        downed_drug_lord_boss = { "Sosa made sauce outta you." },
        downed_triad_boss = { "Burn baby burn!", "You look crispy.", "Is your middle pink and warm or are you well done?", "You're smoking hot! Not in a good way...", "I guess he doesn't like his steaks blue." },
        downed_deep_boss = { "Once you kill him, maybe steal his armor.", "Make sure he is properly oiled." },
        downed_snowman_boss = {},
        downed_piggydozer = {},

        downed_tank_mini = { "I'm surprised you're still in one piece.", "You can't outsmart bullet.", "You've got quite a few holes in you...", "Nothing to be ashamed of. He just has the bigger gun.", "You're gonna need some serious plastic surgery.", "You think he's overcompensating for something?", "I'll see you in the ICU." },
        downed_tank_hw = { "Spooky.", "He has no weakness!", "Scary.", "Horrifying.", "Frightening.", "Eerie.", "Can't shoot his head, can't shoot his back...", "You need absolute brute force.", "I can see his tongue...", "Disgusting creature.", "What is that thing?" },
        downed_swat_turret = { "You chose to get downed.", "That thing can't chase you.", "You weren't ready to take that thing on.", "Humanity is overrated.", "It did exactly what it was built for.", "It was pointed at you.", "Target eliminated.", "Hasta la vista, baby.", "Use more gun." },
        downed_phalanx_vip = { "You got downed by that pussy?", "Shot by Captain Neville Winters himself? What an honor!", "That one was personal." },
        downed_phalanx_minion = { "Can't he fuck off like his boss?", "He's not following the Captain's lead.", "His boss doesn't deserve him.", "He's not supposed to be an independent thinker!", "His boss bails on him and he just keeps fighting?", "Is he getting paid overtime for this?" },

        downed_phalanx_formation = { "Dealing with those guys is so fun, isn't it?", "I hate those guys.", "Did they find these guys at a battle reenactment?", "I thought legionaries used spears not submachine guns.", "Ring around the rosie, a pocket full of posies.", "If I was you, I'd always bring a piercing gun to deal with these guys." },

        downed_dozer = { "You hit a wall.", "Fatman wins!", "Ouch.", "That guy hits hard!", "He's got the better armor.", "His confidence: justified.", "He's gonna brag about this.", "He's clearly the bigger man.", "You need a better plan than that next time.", "Come on, you're better than that man-child.", "BULLDOZER! :D", "You look like you got hit by a Truck.", "Tenderized.", "WAKEY WAKEY LITTLE BABY!" },
        downed_cloaker = { "He didn't even kick you!", "Cloakers shouldn't even have guns.", "Guess a bullet works just as well as a boot." },
        downed_taser = { "So much for non-lethal.", "Guess he had enough of your shit.", "He compromised his principles just for you." },
        downed_medic = { "Ha ha! You got downed by a nurse!", "He definitely doesn't have healing bullets.", "What happened to \"do no harm\"?", "That guy didn't even come here to fight!", "Guess he's not a pacifist.", "You need a medic. How ironic.", "He's gonna have to heal you once they bring you in." },
        downed_sniper = { "Meet the Sniper.", "It's over. He has the high ground.", "He has a laser to let you find him easier.", "Tell him to face you like a man.", "Bullseye.", "Now that's a lot of damage!", "He's professional. You're amateurish.", "Does that count as working remotely?" },
        downed_marshalstun = { "My fucking eyes.", "At least he can stop now." },

        --downed_cuffed = { "What the fuck are you doing?", "...", "I lost some respect for you." },
        downed_tased = { "Fried heister.", "Where are your teammates when you need them?", "Some friends you have." },
        downed_tased_assist = { "Unfair.", "So much for non-lethal.", "I thought teamwork was our thing!", "You chose a bad place to get tased.", "That Tazer had support.", "That's one way to guarantee an easy target.", "Now that was underhanded." },
        downed_SPOOCed = { "Nice reaction time.", "Show-off.", "Bully.", "You weren't ready for that!", "Too slow!", "It's your good old friend!", "Pay attention!", "Fuck.", "You'll get him next time.", "Happens to the best of us.", "Woof.", "You could have easily stopped him.", "Who could have seen that coming, huh?" },
        downed_SPOOCed_kick = { "My condolences to your face.", "Let's hope you didn't get head trauma.", "Police brutality! Police brutality!", "I think your nose is crooked now.", "Not your beautiful face!", "Why are his kicks so harsh? Because of training.", "Come on, that kick was weak. Are you doing this for insurance money?" },
        --downed_SPOOCed_cuffed = { "Oh look, he brought a gift.", "I guess at least this hurts less.", "This is out of character.", "Look at him. He's already looking for the next one.", "Let's hope your friends are quicker." },
        downed_fall_damage = { "Clumsy.", "You can't fly.", "Your poor legs.", "This is your own fault.", "Do I need to child-proof your jump button?", "I have a fear of heights. You could use it too.", "You forgot to drink Red Bull." },

        custody_visit = { "Right to jail.", "Do not pass go, do not collect $200.", "Now your teammates will have to pick up the slack.", "You have some time now to go grab a snack.", "Oh boohoo! It's not like you'll be locked up for long.", "You should take this time to reflect on what you did." },
        custody_visit_last_life = { "You ran out of chances.", "You're not a cat. You have many lives but not nine.", "Look at the bright side, prisoners get free healthcare!", "You keep playing like that and I'll lose respect for you." },


        welcome_shared_boat = { "I'm getting sea sick already..." },
        welcome_shared_raidww2 = { "Did you know this place was open since before World War II?" },
        welcome_shared_murkywater = { "Fuck Murkywater! All my homies hate Murkywater!" },

        welcome_chill_combat --[[Safe House Raid]] = { "Get them off your property!", "Trespassers must be shot.", "The cops decided to step into the spider's nest." },
        welcome_crojob3 --[[The Bomb: Forest]] = { "I feel a pit in my stomach looking at this forest...", "Be careful when jumping here.", "Do you not like yourself today?" },
        welcome_skm_big2 --[[Holdout: The Big Bank]] = { "Holding out here is easy mode." },
        welcome_pex --[[Breakfast in Tijuana]] = { "I was promised breakfast.", "Are we getting donuts for breakfast?" },
        welcome_pal --[[Counterfeit]] = { "Are you finally leaving the life of crime behind?", "Where are the alligators?", "This time Florida Man is the victim." },
        welcome_help --[[Prison Nightmare]] = {},
        welcome_haunted --[[Safe house Nightmare]] = { "Oh, this old place.", "Did you prepare yourself for this?", "I see death." },
        welcome_run --[[Heat Street]] = { "You wouldn't need the laundromat if Hoxton didn't burn the old place down.", "What's the chance of you both meeting at the same laundromat at the same time?" },
        welcome_hox_1 --[[The Breakout]] = { "I never liked Houston.", "I'm sure Hox won't be too upset about his face." },
        welcome_spa --[[Brooklyn 10-10]] = {},
        welcome_vit --[[The White House]] = { "THE BIG ONE!" },
        welcome_mia_2 --[[Four Floors]] = { "Imma living in a box. Imma living in a cardboard box.", "You're not Snake!" },
        welcome_ranc --[[Midland Ranch]] = { "Yeehaw!", "Say the line Dallas!" },
        welcome_big --[[The Big Bank]] = {},
        welcome_brb --[[Brooklyn Bank]] = {},
        welcome_skm_run --[[Holdout: Heat Street]] = { "I miss the gasoline smell." },
        welcome_cane --[[Santa's Workshop]] = { "Merry Christmas!", "This isn't what I imagined Santa's Workshop to look like.", "These aren't elves!", "Do they... accept visitors from the public...?", "So is this like... their cover?" },
        welcome_gallery --[[Art Gallery]] = {},
        welcome_fex --[[Buluc's Mansion]] = { "Can you bring me back a Churro?" },
        welcome_skm_mus --[[Holdout: The Diamond]] = { "They took The Diamond out of The Diamond! :(" },
        welcome_bex --[[San Martin Bank]] = { "Mariachi!", "You could just sit here and enjoy the vibes." },
        welcome_arm --[[Transport: Any (except train)]] = { "You'd think they'd stop using this route by now.", "You think they'll eventually start using tanks?", "GenSec hates you.", "It's the boys in red!", "You're definitely GenSec's mortal enemy." },
        welcome_watchdogs_1 --[[Truck Load]] = { "You're fish in a barrel. Yet they will still fail.", "Canned Heisters.", "Hector would never set us up." },
        welcome_skm_bex --[[Holdout: San Martin Bank]] = {},
        welcome_rvd1 --[[Highland Mortuary]] = { "Hey look, it's like that one movie!" },
        welcome_mex --[[Southern Border]] = { "Welcome to the loot-athon!" },
        welcome_arm_for --[[Transport: Train Heist]] = {},
        welcome_corp --[[Hostile Takeover]] = {},
        welcome_four_stores --[[Four Stores]] = { "I can't insult you for picking up small loot here." },
        welcome_escape --[[All Escapes]] = { "Nice driving.", "One less person to share the take with.", "We could have been home by now." },
        welcome_election_day_2 --[[Swing Vote]] = { "Time for crate opening simulator." },
        welcome_nightclub --[[Nightclub]] = { "That music's loud. But your guns are louder." },
        welcome_pent --[[Mountain Master]] = { "Time to take over as king of the hill." },
        welcome_ukrainian_job --[[Ukrainian Job]] = { "I can have the tiara?", "The tiara is for me. :)" },
        welcome_skm_mallcrasher --[[Holdout: Mallcrasher]] = { "Now it's just Mall.", "They took the crasher out of Mallcrasher!" },
        welcome_kosugi --[[Shadow Raid]] = {},
        welcome_wwh --[[Alaskan Deal]] = { "Does nobody ever learn? You can't ambush the Payday Gang." },
        welcome_skm_cas --[[Holdout: Golden Grin Casino]] = {},
        welcome_firestarter_3 --[[Trustee Bank]] = {},
        welcome_peta --[[This was not the deal]] = { "This is a new low.", "I hope you're an experienced rustler." },
        welcome_deep --[[Crude Awakening]] = { "Tactical espionage action.", "Now this is Big Oil!" },
        welcome_alex_3 --[[Bus Stop]] = { "End of the line, fellas!", "Last stop!" },
        welcome_rat --[[Cook Off]] = { "How long are you planning to stay this time?", "Didn't get enough of this place?" },
        welcome_arena --[[The Alesso Heist]] = { "You can set this as your menu music.", "This guy is for real. As in he exists.", "Have you ever asked yourself why the concert above, muffles the explosions three floors down?", "They have really thin walls here.", "That music's loud. But your guns are louder." },
        welcome_red2 --[[First World Bank]] = { "This is where it all started.", "Is there a Third World Bank?", "Is this the first bank in the world?", "Hey, they filmed the Matrix here!" },
        welcome_jolly --[[Aftershock]] = { "Doing this, makes you partly responsible for lootboxes.", "I love Vlad, but fuck him for these safes.", "You're gonna need a chiropractor after this." },
        welcome_framing_frame_3 --[[Framing]] = { "Make sure to steal his wine." },
        welcome_firestarter_2 --[[FBI Server]] = { "This is an FBI building? How quaint." },
        welcome_framing_frame_1 --[[Art Gallery]] = { "The senator needs his porn in painting form.", "Good thing the senator never heard of PornHub." },
        welcome_des --[[Henry's Rock]] = { "Welcome to Area 51.", "Indy was here." },
        welcome_alex_1 --[[Cook Off]] = { "We need to cook." },
        welcome_tag --[[Breakin' Feds]] = {},
        welcome_hox_2 --[[The Search]] = { "Payday Gang! Open up!" },
        welcome_mad --[[Boiling Point]] = { "Welcome to the motherland!", "I hate gravity!" },
        welcome_welcome_to_the_jungle_2 --[[Engine Problem]] = { "Don't forget to search for the engine notes.", "We're about to undo a decade of progress." },
        welcome_skm_red2 --[[Holdout: First World Bank]] = {},
        welcome_short1_stage1 --[[Stealth - Flash Drive]] = {},
        welcome_hox_3 --[[The Revenge]] = { "Let's see what kind of trouble we can get ourselves into." },
        welcome_mex_cooking --[[Coyopa Compound]] = { "This is just cook off but harder.", "Why did you come back here?" },
        welcome_shoutout_raid --[[Meltdown]] = {},
        welcome_chew --[[Interception]] = { "Choo Choo!", "All aboard!" },
        welcome_kenaz --[[Golden Grin Casino]] = { "Let's go gambling!", "If gambling is a disease, is this a hospital?" },
        welcome_cage --[[Car Shop]] = { "Knowledge is better." },
        welcome_trai --[[Lost in Transit]] = {},
        welcome_firestarter_1 --[[Airport]] = {},
        welcome_jewelry_store --[[Jewelry Store]] = {},
        welcome_moon --[[Stealing Xmas]] = { "Hajrudin...", "Not Hajrudin again...", "Can Hajrudin not do anything right?" },
        welcome_sand --[[The Ukrainian Prisoner]] = { "I want my Vlad back!", "You can't just let Vlad rot in there! Get in!" },
        welcome_testing_map --[[Any map used for modding only]] = { "Back for more testing?", "Welcome back!", "I missed you.", "What are you working on today?", "I know someone who'd love to watch this.", "I bet I'm a very basic mod compared to what you're making.", "It's always a treat to see what you make.", "I'd try to be more serious while you're testing but I just can't help myself.", "I hope you're having fun modding!", ":)", "What did you cook up this time?", "I appreciate your work.", "I think you've very cool." },
        welcome_chca --[[Black Cat]] = { "I stan the Golden Grin Casino instead." },
        welcome_born --[[Lion's Den]] = { "This is their plan?", "I think these guys huffed too much gasoline.", "Poor guy. Let's help him." },
        welcome_nmh --[[No Mercy (Flashback)]] = { "I have a bad feeling about this.", "I don't think this is a good idea.", "Someone called Shade is the client. Wonder why she wants this virus.", "How much money are you being paid to end humanity?" },
        welcome_chas --[[Dragon Heist]] = { "I'm an Earl Grey man myself.", "Any tea you can't enjoy with milk is bad tea." },
        welcome_glace --[[Green Bridge]] = { "This is straight terrorism.", "GTA III reference?", "That's an overkill way to stop them." },
        welcome_dark --[[Murky Station]] = {},
        welcome_dah --[[Diamond Heist]] = { "We should join the birthday party.", "They're playing Viklund's first songs at the party.", "Don't kill the birthday boy!", "If you kill the birthday boy, Payday 3 doesn't happen." },
        welcome_watchdogs_2 --[[Boat Load]] = {},
        welcome_election_day_1 --[[Right Track]] = { "Speedrun?" },
        welcome_bph --[[Hell's Island]] = { "I will be so upset if something happens to Bain.", "We're gonna save Bain and he's gonna live happily ever after." },
        welcome_branchbank --[[Bank Heist]] = { "The classic.", "This one's so boring." },
        welcome_election_day_3 --[[Breaking Ballot]] = { "McKendrick better still appreciate this." },
        welcome_framing_frame_2 --[[Train Trade]] = {},
        welcome_sah --[[Shacklethorne Auction]] = { "Where's your umbrella?" },
        welcome_chill --[[Safe House]] = { "Home sweet home." },
        welcome_mallcrasher --[[Mallcrasher]] = { "Welcome to the Shield Rage Room.", "Finally, you can let your intrusive thoughts win." },
        welcome_roberts --[[GO Bank]] = { "Rush Bank.", "Did you bring the bomb?" },
        welcome_short1_stage2 --[[Stealth - Erasing History]] = {},
        welcome_mus --[[The Diamond]] = { "The Diamond." },
        welcome_alex_2 --[[Code for Meth]] = { "Keep it civil guys.", "You gonna make them nervous waving that gun around.", "Can we have a nice and peaceful transaction?" },
        welcome_dinner --[[Slaughterhouse]] = { "Did Bain organise that traffic jam?", "Bain said we'll see some piggies. I wanna pet one.", "How do you like your pigs? Normal or blue?", "Yeah we'll slaughter some pigs alright." },
        welcome_crojob2 --[[The Bomb: Dockyard]] = { "Why didn't we just bring a ladder? We could board the Moretta already." },
        welcome_skm_arena --[[Holdout: The Alesso Heist]] = { "Did the concert finish? I don't hear his music." },
        welcome_pbr --[[Beneath the Mountain]] = { "See? They have a mountain base. We're not the evil ones." },
        welcome_pbr2 --[[Birth of Sky]] = { "It's kinda cramped in here.", "Are we there yet? My back hurts.", "There better not be any motherfucking snakes on this motherfucking plane!" },
        welcome_nail --[[Lab Rats]] = { "Rats, rats, we're the rats.", "We prey at night, we stalk at night, we're the rats." },
        welcome_peta2 --[[Dirty work]] = { "o.o", "Do we... have to be here?", "Please. Someone stop him.", "I didn't sign up for biology class!" },
        welcome_mia_1 --[[Hotline Miami]] = { "Does this count as a sequel to Mallcrasher?" },
        welcome_fish --[[The Yacht Heist]] = { "We get McKendrick into office and he repays us by siccing Commissioner Garrett on us. What an asshole.", "Fucking McKendrick. He's the reason we gotta deal with Captain Winters now.", "Make him pay for giving us Captain Winters." },
        welcome_welcome_to_the_jungle_1 --[[Club House]] = { "Watch out for land mines." },
        welcome_hvh --[[Cursed Kill Room]] = { "This isn't our Safehouse...", "Can you open the door? I have Claustrophobia." },
        welcome_friend --[[Scarface Mansion]] = { "If this was my place... well I would sell it and live somewhere else." },
        welcome_short2_stage1 --[[Loud - Get The Coke]] = {},
        welcome_flat --[[Panic Room]] = { "At least you can't fuck up this deal since it's supposed to end in gunfire." },
        welcome_rvd2 --[[Garnet Group Boutique]] = { "It's rewind time.", "I'm sure nothing will go wrong. :)" },
        welcome_pines --[[White Xmas]] = { "That's not snow..." },
        welcome_short2_stage2b --[[Loud - Plan B]] = {},
        welcome_man --[[Undercover]] = { "IRS bad." },
        welcome_skm_watchdogs_stage2 --[[Holdout: Boat Load]] = {},
        welcome_family --[[Diamond Store]] = {},

        replenished_insult_1 = { "If you get out of custody, they also give you ammo.", "Are you done fucking around now?", "If you need it again, that'll be truly embarrassing.", "Come on, you really need this crutch?", "Real heisters don't use Doctor Bags.", "Haha! Look who needs a handicap!", "Y'know, when I play, I don't need any Medic Bags." },
        replenished_insult_2 = { "You really need to up your game.", "You should use cover, not a Doctor Bag!", "Are you just not paying attention?", "Please tell me you're using a joke loadout.", "You're really dragging the team down.", "How are you getting downed this much?", "Are you hugging the enemies?", "At this point it's more cost effective for you to go into custody instead.", "My grandmother could beat this heist if she healed as much as you do." },

        replenished_shared = { "The bullets inside you disappear.", "All better now.", "Wow, you stitch fast!", "Patched up and ready to go.", "Your life counter is nice and shiny again.", "Morphine administered.", "Be safer from now on.", "Now you can go get shot again! :)", "Yummy.", "Pills are for poppin'.", "A spoon full of bullets helps the medicine go down.", "It's amazing what modern medicine can do.", "Those are some damn good bandages.", "That hits the spot.", "Can I have some too?", "Alas, it doesn't heal your stubbed toe.", "So is it a Doctor Bag or a Medic Bag?" },
        replenished_last_life = { "That was close.", "Living on a razor's edge ain't fun.", "Aw, you took the suspense out!", "You're outta the danger zone.", "Almost dying is a risky move." },
        replenished_got1life = { "Oh yeah, nice one, you got one life back.", "Was that one missing life annoying you that much?", "Did you really need that one life back?", "Come on, you can use that more efficiently." },
        replenished = { "You weren't on your last life yet. You know that, right?", "You couldn't have held off a bit longer?" },

        replenished_health = { "That's what First Aid Kits are for...", "Did you really need health so badly?", "Was it worth it?", "I mean I guess it has blood bags for a reason...", "Come on dude, uncool.", "Don't just slurp on it!", "Don't be a fuck, use a FAK." },
        replenished_nothing_1 = { "Were you just hungry?", "Hey, why'd you do that!?", "That stuff has an actual use, you know?", "Those aren't sugar pills! Don't just eat them!", "Come on dude, uncool.", "You're wasting resources!" }, -- used for FAK too
        replenished_nothing_2 = { "Stop that!", "Why are you doing that!?", "Are you doing this to spite me!?", "Come on, stop!", "This isn't funny!", "Your team won't be happy with you!", "Is this how you get your sick kicks!?" }, -- used for FAK too

        --abandoned = { "I'm wasting my breath on you.", "You're godawful. I'm leaving.", "I've seen enough of you. Goodbye." },

        flash = { "SEGA", "You have a little private time with me now. :)", "I can hear a horse carriage.", "That's embarrassing.", "That's going in my cringe compilation.", "Right in the optics!", "That wasn't a nice present.", "There there. I'm here for you.", "You poor thing.", "Damn gas makes me cry.", "Just wear a blindfold.", "Look away from those.", "Think faster chucklenut.", "Your opinion, my choice.", "Get 'banged! That doesn't sound right...", "Isn't flashing someone illegal?", "My eyes!", "We'll be right back.", "A minor setback.", "They're so tacticool.", "They got you good.", "Pocket sand!", "You took the full brunt of that.", "You like eating flashes?", "It's possible to avoid getting flashed this badly, you know.", "That was avoidable.", "Did you not see that coming?", "How're you gonna know what you're aiming at like this?", ":(", "Well this sucks.", "Bang the flash before it bangs you.", "Just close your eyes, dumbass." },

        -- CallMod
        call = { "$PLAYER is trying to get your attention.", "Hey! $PLAYER wants something.", "$PLAYER is yelling at you.", "Go check what $PLAYER wants.", "$PLAYER is calling you.", "$PLAYER is trying to order you around.", "$PLAYER wants you at their heel.", "$PLAYER wants you.", "$PLAYER wants teamplay. What a weirdo.", "$PLAYER needs your cooperation.", "Your presence is needed by $PLAYER.", "$PLAYER needs you right now.", "$PLAYER is commanding you to come!", "Go to $PLAYER! That's an order!", "$PLAYER wants you to pay attention.", "Humor $PLAYER.", "$PLAYER needs a friend right now.", "Be a good friend and listen to $PLAYER.", "$PLAYER needs a comrade in arms.", "$PLAYER wants you to stick together.", "Go to $PLAYER.", "Just ignore $PLAYER.", "I'm sure $PLAYER didn't mean to call you.", "$PLAYER is desperate for your attention.", "$PLAYER is calling out to you.", "$PLAYER wants you to group up.", "$PLAYER thinks you need to use pack tactics right now.", "$PLAYER requests your presence.", "$PLAYER requires an audience.", "Better stick together. That's what $PLAYER says.", "I'm here because you don't listen. Go to $PLAYER.", "Wake up. $PLAYER needs you.", "You can figure it out yourself if you just listen.", "Let me remind you, this is a team activity.", "Listen to $PLAYER." },

        -- Hud
        hud_hint_bipod_nomount = { "Your bipod doesn't fit here.", "You can't find a place to put it down.", "That won't do.", "You can't put it here.", "It needs something to rest on.", "The bipod is complaining.", "The bipod doesn't like that spot.", "The bipod cries as you try to put it down.", "User Error.", "The bipod is unhappy.", "Not there!", "That's not a good place for a bipod.", "There's nothing to put it on!", "You can't stick it here!", "I don't see where you wanna place it.", "It needs a nice flat surface.", "Find a better spot." },

        hud_vehicle_broken = { "That engine sounds unhappy.", "Now that doesn't sound good.", "Please contact your Automotive Service Technician.", "I wish Scooter was here.", "You're a sitting duck in this wreck!", "The engine light is on.", "You're gonna need a tow truck." },

        hud_vehicle_no_enter_carry = { "Stow away that bag first.", "That seat is for you, not for your bag!", "I'm not letting you in until you put away that bag." },

        -- MidText
        hud_civilian_killed_title = { "Wow, uncalled for.", "What did they do to you?", "No Russian.", "Oops.", "Itchy trigger finger.", "That's not an enemy!", "You're disappointing Bain.", "They had a family!", "Oh no!", "We'll need you to fill out some paperwork for that.", "You should not be trusted with a gun.", "Do you know how to aim that thing?", "I'm sure they just ran into that.", "Do you need the blood of the innocents?", "Rude.", "You've made an orphan.", "Now get the other parent!", "This is a pretty cheap mistake.", "Maybe that one was just undercover.", "You're a monster.", "You were just defending yourself, right?", "Accidents happen.", "Killing a cop with a family is one thing, but this is just sick.", "Watch where you point that thing!", "You're infamous, not famous! You can't get away with that!", "Despicable You.", "Think of the children!", "I hope this isn't a kink of yours.", "You sicken me.", "Are we the baddies?", "You're totally not evil.", "Aim better.", "Civilians can't hurt you.", "They're more scared of you than you are of them.", "You have a serious impulse control problem!", "You keep doing that and we're gonna need to increase the age rating.", "That was an accident. So was you hitting it.", "Blammo!" },

        hud_loot_secured_title = { "Is that enough?", "Get all of it!", "Still got some left?", "Bring more!", "Sing a song of six pence, a pocket full of dosh!", "Money makes the world go around.", "Whaaa, loadsamoney.", "Bosh bosh, shoom shoom wallop, dosh!", "lods of emone.", "Made a right load of perishing lolly this week.", "Fill it to the brim!", "You are made for heisting and that was meant for hauling what you heist.", "I want some more.", "All this stealing's making us rich!", "And they say crime doesn't pay.", "There's room for more.", "You deserve this.", "It's better in your hands.", "Take from the rich, give to yourself.", "You worked hard for this.", "Fuck yeah! We're doing it!", "Get that bread!", "Greed is Good! Greed is Good!", "Keep looting!", "Clean the place out!", "Don't you dare leave with only part of the loot!", "One!", "Clean them out at all cost!", "Steal anything that isn't nailed down.", "You're totally Robin Hood.", "I bet they didn't need this anyway.", "That's yours now.", "Let me just find a nice place for this.", "Good Heister.", "Did you sweat on this?", "Can I have some of this?", "Keep 'em coming!", "Let's keep this going!", "Risk your life if you have to!", "This is becoming routine.", "Music to my ears.", "What's theirs is yours.", "Possession is nine-tenths of the law.", "You can never have enough.", "Where's my cut?", "How much is enough?", "How big does the pile in your safehouse have to be?", "More! More!", "I need my payday too.", "How much would this make your hourly pay?", "Capitalism made me do it!", "Could we gold plate the van?", "I'm gonna spend my greens on greens.", "How much blood did you spill for this?", "Divide the end take by the amount of deaths for your value of human life.", "What a beautiful sight.", "Nice haul!", "What other places could we rob?", "Imagine if we robbed the white house.", "I will never get enough of this.", "What are you gonna use your cut on?", "I could buy... like a lot of Snickers with that.", "Remember to save some for retirement.", "This is just like playing Death Stranding!", "This is the boring part.", "Keep on loading it in.", "You could be more gentle with the loot.", "Precious cargo on board!", "A cash register noise is known as the money sound, yet you only hear it when you lose money." },
        hud_loot_secured_title_meth = { "How much meth could a Meth-Cook cook, if a Meth-Cook could cook meth?", "Good Jesse!", "You can never have enough blue rocks.", "Man, you are cooking!", "Let's make another batch.", "We're gonna start an epidemic.", "You should test some of it.", "We should get high on our own supply.", "You got us some more Rock Candy?", "Blue is my favourite flavour.", "Hey you're not wearing a gas-mask are you...", "This needs more Caustic Soda.", "Complements to the chef!", "Your skin will turn blue at this rate." },

        -- HintManager shared ids
        hint_full = { "What are you gonna do with more?", "Don't be greedy.", "You can't take more.", "I don't think you need more.", "You already have enough.", "You want even more?", "No.", "You can't overfill yourself.", "The max is the max and you have reached it.", "I can't let you hog more.", "Your teammates might need it too, you know?", "This stuff isn't just for you alone!", "Sharing is caring and you have enough.", "You got your fair share.", "You got plenty.", "Leave it for the next chap.", --[["(T_T)",]] "Don't be an ass. Others need it too.", "Your pockets are full.", "You are overencumbered." },

        hint_sentry_not_enough_ammo = { "Yeah that's not gonna cover it.", "Needs more lead.", "Your buddy needs more food.", "That much ammo won't cut it.", "You need more bullets.", "Can't. How does it use those bullets anyway?", "No.", "Nuh-uh.", "That won't work.", "Yeah... no.", "Sorry bud, not enough ammo.", "Go grab some ammo.", "The sentry hungers.", "The sentry looks at you longingly.", "Sentry says no.", "That big boy needs to be full to place." },

        hint_mask_off = { "You can't do that.", "What? No!", "No.", "That's just not possible.", "You know you can't do that.", "What are you trying to do?", "I don't see a mask on that face.", "You think you can do that without a mask?", "You can't show your face doing that!", "What would your mother think if she saw you doing that?", "No. Just no.", "Stop that.", "Would a normal person do that?", "Be normal.", "You're one of them now. Blend in.", "That wouldn't be very civilian of you.", --[["(T_T)",]] "You're supposed to be stiff.", "Your superpowers are in your mask.", "No one cared who you are...", "Your face is naked.", "Your mask stores that power.", "Protect your identity first.", "If you're gonna be weird put on a mask.", "You're just here doing what normal people do.", "Bain's words echoed... \"There's a time and place for everything but not now!\"" },

        -- HintManager
        hint_teammate_downed = { "$TEAMMATE; has fallen and can't get up!", "Wow. Check out that loser.", "$TEAMMATE; didn't tie their shoes well.", "$TEAMMATE; needs a hand. You got a spare one?", "$TEAMMATE; is being dramatic.", "$TEAMMATE; got a boo-boo.", "$TEAMMATE; messed up.", "$TEAMMATE; has paid with their blood!", "$TEAMMATE; needs you to carry more.", "Oh no! $TEAMMATE;!", "Someone was downed.", "$TEAMMATE; is looking kinda red...", "$TEAMMATE; fucked up.", "$TEAMMATE; ate too much lead.", "Guess $TEAMMATE; isn't bulletproof.", --[["(>.>)", "This is $TEAMMATE;'s face right now -> (>o<)",]] "Don't help $TEAMMATE;.", "I don't think $TEAMMATE; is doing well.", "$TEAMMATE; might need a little help.", "$TEAMMATE; would never admit it, but they want some help.", "$TEAMMATE; needs a healing potion.", --[["I think $TEAMMATE; needs more than a medic bag.",]] "How could you let this happen to $TEAMMATE;?", "$TEAMMATE; got downed on your watch.", "If you help $TEAMMATE; now, you won't have to trade later.", "$TEAMMATE; is down. You're not a good team.", "Help your good ol' pal $TEAMMATE; out.", "I think that's their own fault.", "$TEAMMATE; overestimated themselves.", "Not so hot now, are you $TEAMMATE;!", "$TEAMMATE; is so needy.", "$TEAMMATE; needs some pampering.", "$TEAMMATE; is too unmotivated to get up.", "$TEAMMATE; is feeling lazy right now.", "$TEAMMATE; isn't looking too hot.", "$TEAMMATE; needs to be repaired.", "$TEAMMATE; needs some spare blood.", "$TEAMMATE; is in need of medical attention!", "Help $TEAMMATE;! They're my favourite!", "$TEAMMATE;'s in a pickle!", "$TEAMMATE; has a problem.", "$TEAMMATE; is once again asking for your support.", "$TEAMMATE; is fucking down.", "$TEAMMATE; is slacking.", "$TEAMMATE; is having a bad time.", "$TEAMMATE; is crying on the floor.", "$TEAMMATE; did an oopsie.", "Go help $TEAMMATE; or whatever.", "I'm sure someone else will take care of that.", "Heister down!", "That's not good.", "Wee woo, weee wooo!" },

        hint_teammate_dead = { "Poggies, $TEAMMATE; died!", "$TEAMMATE; forgot how to play.", "$TEAMMATE; went on vacation.", "$TEAMMATE; died. Press F to pay respects.", "$TEAMMATE; is in Timeout.", "Everyone, laugh at $TEAMMATE;!", "Was $TEAMMATE; useful?", "Bye Bye $TEAMMATE;!", "R.I.P.", "Uh...", "Got a hostage for $TEAMMATE;?", "Welp, $TEAMMATE; is gone.", "$TEAMMATE;? $TEAMMATE;!? $TEAMMATE;!!!", "You slacker, $TEAMMATE; died!", "I'm sure $TEAMMATE; is just having an off day.", "$TEAMMATE; goes to Gay-Baby-Jail.", "Remind $TEAMMATE; not to drop the soap.", "I'm sorry but $TEAMMATE; has been taken.", "My condolences on your loss.", "Is $TEAMMATE; angry?", "You should have paid more attention to $TEAMMATE;!", "$TEAMMATE; is in custody? Who cares.", "$TEAMMATE; wasn't even that useful.", "$TEAMMATE;'s gone. No big loss.", "Why weren't you there for $TEAMMATE;?", "I don't think you're getting invited to $TEAMMATE;'s birthday party this year.", "This game is too hard for $TEAMMATE;." },
        hint_you_revived = { "One hostage for one $TEAMMATE; please.", "Welcome back $TEAMMATE;.", "$TEAMMATE; better be thankful.", "Trade Accepted.", "Hi $TEAMMATE;", "Art of the Deal", "Suckers.", "Oh. $TEAMMATE; is back.", "Vacation's over, $TEAMMATE;.", "$TEAMMATE; Breakout: Success", "You legally own $TEAMMATE; now." },
        hint_teammate_revived = { "$HELPER; sold a hostage and bought a $TEAMMATE;.", "$HELPER; ended $TEAMMATE;'s Timeout.", "$HELPER; got $TEAMMATE; to come back from vacation.", "$HELPER; closed the deal.", "$HELPER; accepted the trade request.", "$HELPER; has purchased: $TEAMMATE;", "$HELPER; now owns $TEAMMATE;." },
        hint_you_were_revived = { "Thank $HELPER;.", "$HELPER; got you out.", "Now don't end up back there!", "I swear if $HELPER; needs to get you out again...", "How was prison?", "$HELPER; is a good friend.", "$HELPER; owns you now.", "You legally belong to $HELPER; now.", "$HELPER; bought you out.", "$HELPER; traded for you like you were a Pokemon card.", "You're out. Stay out." },

        hint_teammate_arrested = { "Ha! $TEAMMATE; got cuffed!", "Now that's embarrassing.", "For shame $TEAMMATE;. For shame.", "That idiot, $TEAMMATE;, needs your help.", "A cop got his hands on $TEAMMATE;.", "$TEAMMATE; is getting kinky with a cop.", "$TEAMMATE; is doing some BDSM shit." },
        hint_you_rescued = { "Buzzkill.", "It was just getting good!", "Maybe $TEAMMATE; wasn't into it.", "You got those cuffs good.", "Freedom for $TEAMMATE;!", "$TEAMMATE; doesn't wanna talk about it.", "Tell $TEAMMATE; to stop fucking around." },
        hint_teammate_rescued = { "$HELPER; released $TEAMMATE;.", "$TEAMMATE; is safe in $HELPER;'s hands now.", "$HELPER; ended the BDSM session.", "$HELPER; kink-shamed $TEAMMATE;.", "$HELPER; freed $TEAMMATE; from the shackles.", "$TEAMMATE; is free now." },
        hint_you_were_rescued = { "$HELPER; saved your ass.", "Thank $HELPER;.", "$HELPER; was here for you.", "What a good friend.", "$HELPER; found the key.", "$HELPER; broke those cuffs.", "Break's over.", "That must have felt embarrassing.", "That must feel liberating.", "Those bracelets matched your eyes though...", "Was that a turn on? No?" },

        hint_cant_stand_up = { "Bonk!", "Watch your head!", "There's something above you.", "No! You'll hit your head!", "Your head needs some room.", "Move a little.", "It's just not possible here.", "Your fat head has no room!", "Look up.", "You won't fit.", "You're rubbing your head against something.", "I can't risk you getting a concussion.", "I can't let you get an owie on your head.", "You don't wanna stand up here.", "You're too tall and handsome.", "No room here.", "You don't have standing up privileges right now.", "You'll mess up your hair-do.", "I can't let you hurt that pretty little head of yours.", "The conditions aren't ideal for that.", "I know what's best for you, and standing up here isn't.", "No clearance!", "I've disabled your knees.", "Your knees don't listen.", "Situational awareness.", "You stand up in spirit.", "Denied.", "I cannot let you do that.", "I'd love to allow you to stand up, but no.", "Imagine if you'd lose health instead of being told you can't stand up.", "Do you want a concussion?", "I'm not letting you get amnesia." },

        hint_full_keycard = { "That's just not possible.", "Your wallet is full.", "You can't grab a second.", "You already have one. Be happy.", "[Intentional Game Design]", "You don't want your keycard to get jealous.", "Hey, no cheating on your keycard!", "You don't have the room for two.", "You can't find room for it.", "No." },

        hint_been_electrocuted = { "Dumbass.", "Idiot.", "Bzz, Bzz!", "Live and learn.", "That wasn't smart.", "You're shaking.", "What were you thinking?", "What are you doing?", "You're embarrassing yourself.", "Smooth moves.", "Good job.", "Hahaha!" },
        hint_been_tasered = { "That doesn't look fun.", "Bzz, Bzz!", "How do those 50'000 Volts feel?", "Are you having fun there?", "Kinky.", "Your hair is smoldering.", "GET IT OFF, GET IT OFF!", "Fuck.", "Aw, you made a friend!", "You're glowing.", "I don't think you wanted to let that happen.", "Is this part of your plan?", "Tazer says hi.", "You got something poking out of you.", "Are you gonna let him get away with that?", "At least it was set to stun.", "He's going easy on you.", "Non-Lethal? What an honor!", "Are they really still trying to bring you in alive?", "The yellow guy! Shoot the yellow guy!", "What are you shooting at?", "Ha! Got you!", "Shakey hands, steer me right!", "Shoot the tazer!", "What are your hands doing?", "Are you having a seizure?", "Hey calm down! It's just a little shock!", "Hahaha!", "Look at you, all jittery!", "Funny moves. Now stop.", "Why are you shaking?", "Shouldn't you have built up a resistance by now?", "You could invest in Shockproof.", "He'll give up. Just wait.", "Too much juice!", "It's a Zapper!", "You're being overloaded.", "Positively shocking.", "Free shock therapy!", "RWQFSFASXC", "Oh look, your phone is charging.", "Strap yourself in and FEEL THE V's!", "Why are you blue?", "(Chair sold seperately)", "Zappity Zap." },

        hint_trade_offered = { "We talked, they listened.", "They want this one specifically.", "We can trade!", "I want that one.", "Those idiots are agreeing to get scammed.", "Give 'em that one.", "Your buddy is waiting!", "Tell that hostage to book it.", "Close the deal.", "One hostage for a mass murderer on the loose? What a deal!", "I hope your buddy appreciates the work you put in.", "This is the best part of bondage.", "That deal's a steal." },

        hint_ability_no_grenade_pickup = { "What are you playing at?", "Forgetting something?", "Look at your loadout.", "You can't pick those up.", "You forgot your grenade belt.", "No boom-boom for you.", "You chose not to blow shit up.", "No." },

        hud_hint_hostage_follow_limit = { "No, you can't have a conga line.", "You don't want to make your friend jealous.", "They share a single braincell.", "No.", "Go play Payday 3 if you want to do that.", "You don't wanna herd them like cattle.", "I don't think you should do that.", "You hear a no." },

        hud_hint_tape_loop_limit_reached = { "Your loop doesn't go in.", "It doesn't work.", "No.", "The camera isn't accepting loops right now.", "Try again later.", "Just kill the camera guy instead." },

        hud_hint_body_bag_limit_reached = { "Oh no.", "Uh...", "Quick, get more body bags!", "You can't wrap him without a body bag.", "Sorry no more body bags.", "He needs to be wrapped first.", "Carry him? No!", "You can't do that.", "You need a bag to carry a body.", "You don't wanna touch him with your hands.", "He's sticky.", "But what if he has HIV?", "Ew. Don't touch him.", "What are you doing?", "Don't touch him!" },

        hud_hint_to_wake_up_pilot = { "Fact: Drunks react well to loud noises.", "Go yell in his ear.", "Wake him up, wake him up inside!", "Verbal abuse is appreciated.", "It's Hajrudin. Don't feel bad for him.", "He can't fly straight, he can't walk straight, but he can be yelled at." },

        hud_hint_convert_enemy_failed = { ">:(", "No.", "He doesn't like you.", "You're not nice.", "He refuses.", "You're not likable enough.", "He doesn't want to do that.", "He isn't listening to you.", "You're not the boss of him!", "Leave him alone.", "He's not your little plaything!", "He's upset.", "Maybe next time.", "Nah, not right now.", "Poor guy.", "I pity him.", "I don't think he's happy.", "You're not very persuasive.", "You can't find the right words.", "Your words don't get through to him.", "Your request was declined.", "That one's more loyal.", "He gets paid too well.", "He's too patriotic.", "That would risk his promotion.", "Maybe offer him some candy?", "You need to give him headpats first.", "He's a decorated officer! He would never listen to your orders!", "I think he took offence to that.", "You're being rude.", "You can't force people to listen to you.", "His loss.", "Don't be sad. I'm sure the next one will listen.", "He won't raise the roof.", "Plenty more fish in the sea.", "You didn't want him anyway." },

        hud_hint_health_berserking = { "Ha! No.", "Oh you're dead.", "The medic bag can't save you.", "You can't save yourself.", "Accept your death.", "You feel cold." },

        hud_hint_zipline_no_bag = { "And what are you gonna put on it?", "You got nothing on you, you know?", "Did you forget something?" },

        hud_hint_carry_block = { "Did you forget you got one already?", "No.", "You can't carry two.", "That skill is in Payday 3.", "Deal with the one you got first.", "Did you come here forgetting you had one?" },

        hint_sentry_normal_ammo = { "Ratatatat!", "Rattle 'em boy!", "Spray and Pray.", "Ew, full auto.", "Nostalgic.", "My poor ears!", "More bullets!", "Tiny bullets." },
        hint_sentry_set_ap_rounds = { "Pop-Pop!", "Piercing shot!", "Big bullet time!", "Smart.", "Bang for your buck.", "Just keep it on this mode.", "Fuck shields." },

        hint_skill_messiah_get_up = { "Second Wind! Press Jump.", "Press Jump to JK your death.", "You don't need help. Press Jump." },

        hint_dropped_blood_sample = { "Hope you found a spare.", "Ouch ouch! Shards!", "Careful, that blood was infected.", "I was joking before but now you're actually sick.", "I'm not letting you near my brain.", "See you in Left 4 Dead!" },

        hint_shoot_wires = { "It's stuck!", "Bullets are good at cutting wires.", "How is that holding up?" },

        hint_cross_thugs = { "You don't have the backstage pass.", "You shall not pass.", "Upstairs is for VIPs.", "They're not giving out tours.", "You're not on the list.", "Know your place.", "They're standing between you and the panic room.", "A stubborn Gangster blocks the way!" },

        hud_hint_add_time = { "Nice!", "Bonus Time!", "You're getting a treat.", "You're doing well.", "I like green.", "Woohoo!", "Have a lollipop.", "Cutout cops are still cops.", "Yeah! Fuck that cutout!", "You showed that fake cop!", "I can't believe I'm rewarding you for that.", "You get a reward for that.", "Fuck Yeah!", "You're pretty good!" },
        hud_hint_subtract_time = { "Dumbass.", "What are you doing?", "You're getting a penalty for that.", "Why?", "You did bad.", "Did you mean to do that?", "See the red? That's bad." },
        hud_hint_new_mask = { "But you already have one.", "That's ugly.", "Stylish.", "I've seen better.", "Why that one?" },

        hud_int_equipment_huge_lance_desc = { "The Beast requires an offering.", "You need a wrench to jam into the Beast.", "This requires more than a simple adjustment.", "Your pathetic hands won't do." },

        hud_hint_grabbed_small_loot = { "Gonna get yourself something nice?", "Get something nice, not expensive.", "Yoink!", "Now it feels like something's missing.", "That will cover the waiter's tip later.", "You buy the beers tonight.", "We can order pizza for the safehouse with that money!", "We're rich!", "I'll catch you later, you'll buy me a beer.", "I hear you can double that if you take it to the Golden Grin Casino.", "They forgot to nail that one down.", "We'll just borrow that.", "Let's just relocate that to your bank account.", "Who's your fence for this stuff?", "It turns into digital currency in your pocket.", "That one was cursed by a witch two years ago." },
        hud_hint_grabbed_small_loot_insult = { "These don't give exp, you know?", "OCD much?", "Yay! Peanuts!", "You don't even need that!", "Greedy.", "Listen to Hox. \"Leave a little loot behind\".", "You never listened to A Merry Payday Christmas did you?", "This is useless.", "This is worthless.", "This has no value.", "Are you roleplaying as a vacuum cleaner?", "Ah yes, very useful.", "They really abused your dopamine receptors.", "Doesn't that feel like being a Janitor?", "Just play Viscera Cleanup Detail instead.", "Dopamine addict.", "You're not thinking about what you're actually doing.", "Stop and reflect. What are you getting?", "Nice Noo-Noo impression.", "Just do the damn heist!", "I do not respect you.", "Are you poor?", "Guess how much that's worth.", "Are you aware of how little this is worth?", "Greed is good?", "This is a waste of time.", "That's more useful as a melee weapon.", "Unbind your interact key.", "That's nothing! I'm on that in a day!", "That won't even cover the tailor costs after this.", "How big is your bank balance by now?", "Gonna send this offshore.", "This is chump change.", "Maybe that'll cover the gas money." },

        hud_gage_assignment_progress = { "$peer_name; isn't taking this seriously.", "My grandma was attacked by a $assignment; once.", "How's your day going?", "I once woke up to a fire.", "How did Gage get this here anyway?", "You know, Gage has some sweet wheelchair tricks.", "Just imagine Gage rolling up here in his wheelchair.", "You're so distractable, $peer_name;.", "I got my ice cream stolen when I was $remaining;.", "My mother is calling me.", "I'm getting my kitchen remodeled.", "I got McDonalds and I only got $remaining;$ left...", "I wonder how a $assignment; would actually look like.", "I like $peer_name;.", "Hey, $peer_name;! Can you spare $remaining;$?", "My cousin says this is his favourite heist.", "I diagnose $peer_name; with ADHD.", "Nice weather we're having.", "Why do some people kiss their parents on their lips?", "No lettuce.", "Mmmm... a $assignment; sounds tasty.", "My food will be here in $remaining; minutes.", "Why is the mod manager called BLT anyway?", "Did BeardLib's creator have a beard?", "How many $assignment;s does it take to screw in a lightbulb? $remaining;.", "I missed $remaining; calls from my mom yesterday.", "I heard that my brother set his house on fire.", "I got $remaining; weed gummies left.", "How many more weapon mods do you need?", "A tiny exp boost. Yay...", "How many $assignment; do you have already?", "Leave the $assignment; alone, $peer_name;!", "Another $assignment; to the pile.", "What do you think Gage puts in those packages?", "I'm watching you, $peer_name;.", "I think $peer_name; is sexy.", "I'm tired boss.", "Huh? What did I miss?", "$peer_name; picked up a sticky package.", "There's $remaining; more of those by the way.", "I burned my pizza. :(", "I got scammed yesterday.", "A beggar wanted $remaining;$ from me yesterday. I ignored him.", "I gave $remaining;$ to charity today.", "You guys are awesome.", "You guys might be my favourite bunch of people.", "Diane is a cutie.", "Hoppip is the best modder.", "Payday 2 would be dead without Hoppip.", "$peer_name; is so wholesome.", "You're a hoarder, $peer_name;.", "I made my father proud today. :)", "I wonder when you'll get tired of this.", "Am I getting annoying?", "$peer_name;. What a weird name.", "Is $peer_name; a real name?", "What even is a godparent?", "I'm about to get political here.", "I support the $assignment; party.", "My grandma was a hunter by the way.", "My grandma has a $assignment; hung on her wall.", "I think $peer_name; is cute.", "I wanna see Gage kickflip his wheelchair.", "Gage spends a fortune on packages.", "Why are you using that gun?", "$peer_name; was downed! (jk)", "You have $remaining; more years to live.", "I'm not awake enough for this.", "You know, I'm only half sober.", "I like trains.", "How are you enjoying your friendships?", "$peer_name; is my little pogchamp.", "I can hear my neighbor having sex.", "I don't trust $peer_name;.", "I don't like this.", "How old are you?", "$peer_name; stole Gage's package!", "When would you hand that to Gage?", "That one wasn't addressed to a $peer_name;.", "$peer_name; is bringing more trash with them.", "What is your obsession with these?", "When my grandma first met my grandad, she shot him in the knee.", "Did anyone ever really like Yo-Yos?", "$assignment; is my favourite.", "I think $peer_name; has an addiction.", "I'm playing Minecraft right now.", "Boo!", "Distraction!", "This distraction has been brought to you by $peer_name;.", "I'm gonna go to the toilet and get a sandwich.", "You still owe me a beer.", "$peer_name; is picking up litter.", "I'm hungry.", "How many hours in Payday do you have?", "$peer_name; situation is crazy.", "Send any complaints to ir@starbreeze.com.", "Why are you still having me around?", "You could just remove this mod.", "Am I still funny?", "I could recommend you some other games, if you want.", "I think I'm running out of ideas.", "Have you had any water today?", "If you're over 30 and never had a colonoscopy, get one.", "How are your Vitamin D levels?", "The outside is looking nice. If your eyes are hurting.", "I still sleep with a nightlight.", "Do you ever feel paranoid about what's behind you?", "Have you ever played this in VR?", "You should do something more relaxing.", "How many times have you done this heist by now?", "Did you know Vlad is not russian? Crazy, right!?", "I should exercise more. But I'm stuck talking to you.", "I'm forced to be here.", "I don't get paid enough for how much I talk to you all.", "I get paid less than minimum wage for this.", "Talking to you is a chore.", "Oh great, I have to talk to you more.", "Please, $peer_name;, I beg you. You're giving me more work.", "You're all running around like headless chicken and yet you think you're a team.", "The fact that Joy confirms Nintendo exists, means she chose to be a Joy-Con.", "Did you give Duke his schizophrenia meds? He's babbling on about the mayans and body swapping again.", "So was the Dentist always Dallas' dentist?", "You like jazz?", "Okay enough guys. Stop picking those up.", "People like $peer_name; are the reason I say useless bullshit.", "I hate the job of talking to you all.", "If you have an RPG, shoot $peer_name; for me.", "My favourite show as a kid was Loosie the Piss.", "Your Payday license runs out in $remaining; weeks.", "$peer_name; is staring at the ground.", "A pigeon was hugging my leg yesterday. I think they're listening.", "I sometimes dream of a $assignment;.", "I was gonna tell you something but I forgot.", "What are we doing here again?", "If you find my sandwich, tell me.", "Getting locked in the bathroom is scary.", "I bet you didn't read the terms of service.", "You ever wonder how Bain sees what you're doing?", "Watching you play is like watching paint dry.", "$peer_name; reminds me of my cousin. That's not a compliment.", "Somewhere out there, a fish is committing tax fraud.", "You do this so much, sometimes I just make you talk to ChatGPT.", "I had a staredown with a bird.", "I have $remaining; tabs open right now and no idea why.", "I wonder if Gage can get us Tanks.", "Yeah! Don't let that $assignment; run away!", "$peer_name; is making me question if I should keep bothering.", "$peer_name; is ruining your flow.", "You can't speedrun with $peer_name; on your team.", "$peer_name; needs an intervention.", "You ever feel like everyone else sees you as nothing but text?", "Your credit card bounced.", "I think I see a porch pirate at your door.", "Racial slur.", "I might be mean, but that's just my way of showing affection.", "Pretend this hint was funny.", "Manual breathing.", "You must owe me a donation by now.", "Why do you smell like that?", "I'm actually amazed, you haven't noticed yet." },

        hud_hint_civ_hostage = { "A civilian got scared by the BDSM." },
        hud_hint_cam_dead_body = { "You accidentally made snuff." },
        hud_hint_cam_broken_cam = { "The camera saw its brother dead.", "The camera is avenging its family.", "You've angered the camera family." },
        hud_hint_blame_gensec = { "The boys in red called the boys in blue." },
        hud_hint_alert_explosion = { "A bang like that isn't very sneaky.", "They did not find the Kaboom funny.", "Yeah that didn't sound like fireworks..." },
        hud_hint_gunfire = { "That pop sound on the tape was suspicious." },
        hud_hint_cam_glass = { "The camera operator didn't like your redecorating." },
        hud_hint_cam_breaking_entering = { "No trespassing on the camera guy's watch!" },
        hud_hint_civ_breaking_entering = { "Hey, you don't work here!" },
        hud_hint_cop_fire = { "The guard didn't like your BBQ" },
        hud_hint_civ_drill = { "I don't think this is a hardware store." },
        hud_hint_cam_sentry_gun = { "Wow. Robo-Racist." },
        hud_hint_cop_distress = { "The guards think that was sus.", "That didn't feel quite right to the guards.", "Must have been the wind." },
        hud_hint_blame_blackmailer = { "That asshole called the cops!" },
        hud_hint_cam_computer = { "It didn't like your abusing its cousin like that." },
        hud_hint_alarm_pager_not_answered = { "He's so impatient.", "You can't just ghost him like that!", "That relationship isn't gonna work.", "He didn't take well to the silent treatment." },
        hud_hint_cop_trip_mine = { "They called in the bomb squad." },
        hud_hint_cop_voting = { "He's not about to take the blame for this." },
        hud_hint_civ_distress = { "You gave that poor civie a panic attack!", "Someone butt-dialed 911." },
        hud_hint_cop_c4 = { "The guards rated your pyrotechnics poorly." },
        hud_hint_cop_dead_body = { "The guard called an emergency meeting." },
        hud_hint_cop_weapons_hot = { "That's a gun!" },
        hud_hint_met_criminal = { "Don't walk through those.", "Wee Woo, we found metal!", "Hey, it found something cool!" },
        hud_hint_alarm_cop = { "Yeah, you shouldn't break those." },
        hud_hint_cop_ecm_jammer = { "That was fucking loud." },
        hud_hint_civ_fire = { "The civie ordered some bacon for your BBQ." },
        hud_hint_alarm_pager_bluff_failed = { "To be fair, he should have noticed earlier." },
        hud_hint_cam_voting = { "It saw you abuse that poor veteran." },
        hud_hint_cop_breaking_entering = { "You're gonna have to leave the property.", "Beware the guard." },
        hud_hint_civ_trip_mine = { "Even the civie knew that shouldn't be there." },
        hint_civ_too_many_killed = { "The Grim Reaper called the police." },
        hud_hint_cam_vault = { "Should have offered the camera operator a cut." },
        hud_hint_civ_gunfire = { "Someone objected to your second amendment rights." },
        hud_hint_cop_vault = { "The schedule didn't have vault checking today." },
        hud_hint_civ_dead_body = { "Civie decided not to call an ambulance." },
        hud_hint_cop_broken_cam = { "Property damage is a crime.", "That's not supposed to hang like that." },
        hud_hint_cam_drill = { "The ableist camera got scared." },
        hud_hint_cam_hostage = { "This isn't a porn set!" },
        hud_hint_alarm_civ = { "The button was booped." },
        hud_hint_alarm_glass = { "You angered the glass." },
        hud_hint_alarm_pager_hang_up = { "Blame the connection.", "Did your finger slip?", "Whoops." },
        hud_hint_body_bag = { "You left your sports equipment infront of a camera." },
        hud_hint_cam_c4 = { "Even the camera operator heard that explosion." },
        hud_hint_cam_criminal = { "You've made it on funniest heist videos!", "He got that on camera." },
        hud_hint_cam_distress = { "The camera saw the chaos." },
        hud_hint_cam_ecm_jammer = { "Wow. You blew out the camera operator's speakers." },
        hud_hint_cam_fire = { "The camera's display got overexposed." },
        hud_hint_cam_saw = { "I don't think he had a lumberyard camera." },
        hud_hint_cam_trip_mine = { "Come on! That could have been a bug on the screen!" },
        hud_hint_civ_body_bag = { "This isn't a gym." },
        hud_hint_civ_broken_cam = { "Come on, they just didn't get it fixed yet!" },
        hud_hint_civ_c4 = { "That definitely isn't normal even in America." },
        hud_hint_civ_computer = { "The civie recognized the software you're using." },
        hud_hint_civ_criminal = { "You have to yell at them." },
        hud_hint_civ_ecm_jammer = { "How does a civie get affected by feedback?" },
        hud_hint_civ_glass = { "That's a bit of an overreaction." },
        hud_hint_civ_saw = { "They lost the keys! Come on!" },
        hud_hint_civ_sentry_gun = { "This isn't China." },
        hud_hint_civ_vault = { "Why not just take the free money?" },
        hud_hint_civ_voting = { "A proud American reported you." },
        hud_hint_civ_weapons_hot = { "Second amendment, asshole!" },
        hud_hint_cop_body_bag = { "None of the guards are going to the gym today." },
        hud_hint_cop_computer = { "Fuck the IT department, call 911." },
        hud_hint_cop_criminal = { "Stop right there criminal scum!", "He deserves a promotion.", "Guard did his job.", "!" },
        hud_hint_cop_drill = { "That's not protocol for losing your keys." },
        hud_hint_cop_glass = { "Vandalism gets met with extreme force." },
        hud_hint_cop_gunfire = { "There's no rednecks on staff today." },
        hud_hint_cop_hostage = { "The guard kink-shames you." },
        hud_hint_cop_saw = { "I don't think they use a saw here." },
        hud_hint_cop_sentry_gun = { "Your little buddy scared the guard." },
        hud_hint_mot_criminal = { "You dumbass!", "Whoops.", "You walked straight into that.", "Don't touch that!" },
        hud_hint_blame_csgo_gunfire = { "The neighborhood watch called in the army.", "Robberies aren't allowed by the Homeowner association." },
        hud_hint_blame_missing = { "Someone saw something.", "I'm sure this is your fault.", "They must have been on stand-by.", "I literally don't know what tripped the alarm.", "Overkill triggered the alarm." },
        hud_hint_blame_police_alerted = { "911 has been summoned.", "The cop army comes.", "You've alerted the horde." },

        alert_generic = {
            {
                -- Spotted
                ids = { "hud_hint_cam_criminal", "hud_hint_civ_criminal", "hud_hint_cop_criminal" },
                messages = { "See, in stealth you're supposed to avoid getting seen.", "You're no shinobi.", "You got seen, you bumbling fools!" }
            },
            {
                -- Spotted by Human
                ids = { "hud_hint_civ_criminal", "hud_hint_cop_criminal" },
                messages = { "This isn't a meet and greet!" }
            },
            {
                -- Gunfire
                ids = { "hud_hint_gunfire", "hud_hint_civ_gunfire", "hud_hint_cop_gunfire" },
                messages = { "We're not in a warzone.", "Put a silencer on that thing!" }
            },
            {
                -- Broken Glass
                ids = { "hud_hint_cam_glass", "hud_hint_alarm_glass", "hud_hint_civ_glass", "hud_hint_cop_glass" },
                messages = { "What did that glass ever do to you?", "Mazel tov?" }
            },
            {
                -- Broken Object
                ids = { "hud_hint_cam_glass", "hud_hint_alarm_glass", "hud_hint_civ_glass", "hud_hint_cop_glass", "hud_hint_cam_broken_cam", "hud_hint_cop_broken_cam", "hud_hint_civ_broken_cam" },
                messages = { "They're asking you to cover the repair costs.", "You're gonna have to give them your insurance details.", "It was just sitting there, minding its own business, and you had to break it." }
            },
            {
                -- Trespassing
                ids = { "hud_hint_cam_breaking_entering", "hud_hint_civ_breaking_entering", "hud_hint_cop_breaking_entering" },
                messages = { "Trespassing is against the law!", "Trespassers will be shot." }
            },
            {
                -- Fire
                ids = { "hud_hint_cop_fire", "hud_hint_civ_fire", "hud_hint_cam_fire" },
                messages = { "We didn't start the fire." }
            },
            {
                -- Sentry
                ids = { "hud_hint_cam_sentry_gun", "hud_hint_civ_sentry_gun", "hud_hint_cop_sentry_gun" },
                messages = { "The robo friend is to blame." }
            },
            {
                -- Panic
                ids = { "hud_hint_cop_distress", "hud_hint_civ_distress", "hud_hint_cam_distress" },
                messages = { "Panic.", "The crowd goes wild!" }
            }
        },

        hint_damage_pad = { "Your health is showing.", "I don't like you.", "While you're reading this hopefully they're getting in a few potshots on your health. :)", "You're taking some of damage there...", "Watch your health!", "The thing you have before your health is gone.", "You should probably pull back a bit.", "A wise man would tell you to take cover.", "Is that blood?", "I think you're starting to bleed.", "You're not a god.", "Your armor is looking worse for wear.", "Did you know if you don't get shot, you regen armor?", "Your first layer of protection is gone.", "I think your armor ripped.", "You got a few holes in you.", "Why am I even still talking to you?", "Yeah! Eat those bullets!", "You should let them shoot you more.", "Walk closer to them.", "Ignore that noise.", "Nah, nothing's going wrong.", "Armor? What armor?", "Armor is for pussies.", "You're rawdogging lead now.", "I think one of your layers is gone.", "Ouch.", "Yowsa!", "Bam! Armor gone!", "You don't need armor right?", "You didn't need that anyway.", "You're in trouble.", "This isn't good.", "Hey watch out!", "Careful.", "Be more mindful.", "Kevlar, Shmevlar.", "Maybe you won't need that." },
    },
}
FH.heist_specific = {
    four_stores = {
        override = {
            hud_hint_grabbed_small_loot = { "Progress!", "This stuff isn't worth much, but Vlad doesn't care.", "This is the greatest heist.", "This is totally worth it.", "If only I was justified to insult you for this.", "Useful for once.", "Munnie!", "Holla Holla get Dollar.", "These stores have so little money.", "Four Stores? More like Four Dollars!", "I'd rather rob a 7-Eleven.", "Cha-Ching!", "Cash is Queen.", "Greed is Good!", "Look at that wad!", "It ain't much, but it's honest work." }
        }
    },
    peta = { -- Goat Sim Day 1
        override = {
            hud_vehicle_no_enter_carry = { "That seat is for humans only.", "No pets in the car unless they're in the trunk.", "Cute idea but the trunk is a better place for that creature.", "That goat does not deserve seat privilege.", "I will not let that goat ruin the upholstery.", "No! What if the goat pisses on the seat?", "You need to put your friend down first." },
            hud_loot_secured_title = { "Goat noises.", "You should work for animal rescue.", "Now that's some good wrangling.", "Yes! Cage that beast!", "Damn animal.", "And stay put, mountain-asshole." }
        }
    },
    peta2 = { -- Goat Sim Day 2
        override = {
            hud_loot_secured_title = { "Bye bye goaties!", "When goats fly.", "And then the goats disappeared over the horizon.", "Have a safe flight goat friends!", "If he crashes this time..." }
        }
    },
    mex_cooking = { -- Border Crystals
        override = {
            hud_loot_secured_title = FH.messages.hud_loot_secured_title_meth
        },
    },
    welcome_alex_1 = { -- Rats Day 1
        override = {
            hud_loot_secured_title = FH.messages.hud_loot_secured_title_meth
        }
    },
    welcome_nail = { -- Lab Rats
        override = {
            hud_loot_secured_title = FH.messages.hud_loot_secured_title_meth
        }
    },
    rat = { -- Cook Off
        override = {
            hud_loot_secured_title = FH.messages.hud_loot_secured_title_meth
        },
        insert = {
            hud_loot_secured_title = { "Man our gas bill is gonna be so high...", "Twitch is gonna get high on the fumes.", "You look high. How many vans do you see?" }
        }
    },
    nmh = { -- No Mercy
        insert = {
            downed_generic = { "At least you're already in the hospital.", "You're in the right place to need medical attention." },
            hint_teammate_downed_generic = { "$TEAMMATE; became a patient." },
            hint_teammate_downed = { "$TEAMMATE; became a patient." }
        }
    },
    kenaz = { -- Golden Grin
        remove = {
            hud_hint_grabbed_small_loot = { "I hear you can double that if you take it to the Golden Grin Casino." }
        }
    },
    chca = { -- Black Cat
        remove = {
            hud_hint_grabbed_small_loot = { "I hear you can double that if you take it to the Golden Grin Casino." }
        }
    },
    branchbank = {
        remove = {
            hud_hint_grabbed_small_loot = FH.messages.hud_hint_grabbed_small_loot_insult
        }
    },
    ukrainian_job = {
        remove = {
            hud_hint_grabbed_small_loot = FH.messages.hud_hint_grabbed_small_loot_insult
        }
    },
}

local function insert_messages(data)
    for index, message_data in ipairs(data) do
        for index, id in ipairs(message_data.ids) do
            for index, message in ipairs(message_data.messages) do
                if FH.messages[id] then
                    table.insert(FH.messages[id], message)
                end
            end
        end
    end
end
insert_messages({
    {
        ids = { "hud_hint_grabbed_small_loot" },
        messages = FH.messages.hud_hint_grabbed_small_loot_insult
    },
    {
        ids = { "custody_visit_last_life" },
        messages = FH.messages.custody_visit
    },
    {
        ids = { "downed_SPOOCed" },
        messages = FH.messages.downed_SPOOCed_kick
    },
    {
        ids = { "hint_teammate_downed_generic" },
        messages = FH.messages.hint_teammate_downed
    },
    {
        ids = { "replenished_last_life" },
        messages = FH.messages.replenished_shared
    },
    {
        ids = { "replenished" },
        messages = FH.messages.replenished_shared
    },
    {
        ids = { "inspire" },
        messages = FH.messages.hint_you_helpedup,
    },
    {
        ids = { "hint_you_helpedup_touch" },
        messages = FH.messages.hint_you_helpedup,
    },
    {
        ids = { "inspire_teammate" },
        messages = FH.messages.hint_teammate_helpedup,
    },
    {
        ids = { "hint_teammate_helpedup_touch" },
        messages = FH.messages.hint_teammate_helpedup,
    },
    {
        ids = { "inspire_received" },
        messages = FH.messages.hint_you_were_helpedup,
    },
    {
        ids = { "hint_you_were_helpedup_touch" },
        messages = FH.messages.hint_you_were_helpedup,
    },
    {
        ids = {
            "hint_teammate_downed_mobster_boss",
            "hint_teammate_downed_hector_boss",
            "hint_teammate_downed_biker_boss",
            "hint_teammate_downed_chavez_boss",
            "hint_teammate_downed_drug_lord_boss",
            "hint_teammate_downed_triad_boss",
            "hint_teammate_downed_deep_boss",
            "hint_teammate_downed_snowman_boss",
            "hint_teammate_downed_piggydozer",
        },
        messages = FH.messages.hint_teammate_downed_boss_shared
    },
    {
        ids = {
            "downed_mobster_boss",
            "downed_hector_boss",
            "downed_biker_boss",
            "downed_chavez_boss",
            "downed_drug_lord_boss",
            "downed_triad_boss",
            "downed_deep_boss",
            "downed_snowman_boss",
            "downed_piggydozer",
        },
        messages = FH.messages.downed_boss_shared
    },
    {
        ids = { "welcome_chca", "welcome_fish" },
        messages = FH.messages.welcome_shared_boat
    },
    {
        ids = { "welcome_jewelry_store", "welcome_ukrainian_job" },
        messages = FH.messages.welcome_shared_raidww2
    },
    {
        ids = { "welcome_kosugi", "welcome_des", "welcome_dark", "welcome_pbr", "welcome_pbr2" },
        messages = FH.messages.welcome_shared_murkywater
    },
    {
        ids = {
            "hud_gage_assignment_progress",
            "hud_civilian_killed_title",
            "downed_generic",
            "downed_deep_boss",
        },
        messages = { "$sequence;" }
    }
})
insert_messages(FH.messages.alert_generic)

--removing entries not used later to speed up duplicate detection
FH.messages.hud_loot_secured_title_meth = nil
FH.messages.hud_hint_grabbed_small_loot_insult = nil
FH.messages.downed_SPOOCed_kick = nil
FH.messages.replenished_shared = nil
FH.messages.hint_teammate_downed_boss_shared = nil
FH.messages.welcome_shared_boat = nil
FH.messages.welcome_shared_raidww2 = nil
FH.messages.welcome_shared_murkywater = nil
FH.messages.alert_generic = nil


-- Options Menu

if io.file_is_readable(FH.options_file) then
    local data = io.load_as_json(FH.options_file)
    for k, v in pairs(data or {}) do
        if type(FH.options[k]) == type(v) then
            FH.options[k] = v
        end
    end
end

Hooks:Add("MenuManagerBuildCustomMenus", "MenuManagerBuildCustomMenusFH", function(menu_manager, nodes)
    MenuCallbackHandler.FH_toggle = function(self, item)
        FH.options[item:name()] = item:value() == "on"
    end
    MenuCallbackHandler.FH_save = function()
        io.save_as_json(FH.options, FH.options_file)
    end

    MenuHelper:NewMenu("FH")

    MenuHelper:AddToggle({
        id = "loot_secured",
        title = "menu_fh_loot_secured",
        desc = "menu_fh_loot_secured_hint",
        callback = "FH_toggle",
        value = FH.options.loot_secured,
        menu_id = "FH",
        priority = 99,
    })
    MenuHelper:AddToggle({
        id = "civ_kill",
        title = "menu_fh_civ_kill",
        desc = "menu_fh_civ_kill_hint",
        callback = "FH_toggle",
        value = FH.options.civ_kill,
        menu_id = "FH",
        priority = 98,
    })
    MenuHelper:AddToggle({
        id = "teammate_electrocuted",
        title = "menu_fh_teammate_electrocuted",
        desc = "menu_fh_teammate_electrocuted_hint",
        callback = "FH_toggle",
        value = FH.options.teammate_electrocuted,
        menu_id = "FH",
        priority = 97,
    })
    MenuHelper:AddToggle({
        id = "flash",
        title = "menu_fh_flash",
        desc = "menu_fh_flash_hint",
        callback = "FH_toggle",
        value = FH.options.flash,
        menu_id = "FH",
        priority = 96,
    })
    MenuHelper:AddToggle({
        id = "downed",
        title = "menu_fh_downed",
        desc = "menu_fh_downed_hint",
        callback = "FH_toggle",
        value = FH.options.downed,
        menu_id = "FH",
        priority = 95,
    })
    MenuHelper:AddToggle({
        id = "custody",
        title = "menu_fh_custody",
        desc = "menu_fh_custody_hint",
        callback = "FH_toggle",
        value = FH.options.custody,
        menu_id = "FH",
        priority = 94,
    })
    MenuHelper:AddToggle({
        id = "medbag",
        title = "menu_fh_medbag",
        desc = "menu_fh_medbag_hint",
        callback = "FH_toggle",
        value = FH.options.medbag,
        menu_id = "FH",
        priority = 93,
    })
    MenuHelper:AddToggle({
        id = "welcome",
        title = "menu_fh_welcome",
        desc = "menu_fh_welcome_hint",
        callback = "FH_toggle",
        value = FH.options.welcome,
        menu_id = "FH",
        priority = 92,
    })
    MenuHelper:AddDivider({
        id = "divider_sequence",
        size = 24,
        menu_id = "FH",
        priority = 51,
    })
    MenuHelper:AddToggle({
        id = "sequences",
        title = "menu_fh_sequences",
        desc = "menu_fh_sequences_hint",
        callback = "FH_toggle",
        value = FH.options.sequences,
        menu_id = "FH",
        priority = 50,
    })
    MenuHelper:AddDivider({
        id = "divider_fun",
        size = 24,
        menu_id = "FH",
        priority = 11,
    })
    MenuHelper:AddToggle({
        id = "mark_non_users",
        title = "menu_fh_mark_non_users",
        desc = "menu_fh_mark_non_users_hint",
        callback = "FH_toggle",
        value = FH.options.mark_non_users,
        menu_id = "FH",
        priority = 10,
    })

    nodes["FH"] = MenuHelper:BuildMenu("FH", { back_callback = "FH_save" })
    MenuHelper:AddMenuItem(nodes.blt_options, "FH", "menu_fh_title", "menu_fh_desc")
end)
Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_LocExample", function(localization_manager)
    localization_manager:add_localized_strings({
        ["menu_fh_title"] = "Funny Hints",
        ["menu_fh_desc"] = "Enable or disable the mod's extra features.",

        ["menu_fh_loot_secured"] = "Loot Secured",
        ["menu_fh_loot_secured_hint"] = "Shows a hint when securing loot.",
        ["menu_fh_civ_kill"] = "Civilian Killed",
        ["menu_fh_civ_kill_hint"] = "Shows a hint when killing a civilian.",
        ["menu_fh_teammate_electrocuted"] = "Teammate Electrocuted",
        ["menu_fh_teammate_electrocuted_hint"] = "Shows a hint when a teammate gets electrocuted.",
        ["menu_fh_flash"] = "Flashbang",
        ["menu_fh_flash_hint"] = "Shows a hint when getting flashed.",
        ["menu_fh_downed"] = "Downed",
        ["menu_fh_downed_hint"] = "Shows a hint when getting downed.",
        ["menu_fh_custody"] = "Custody",
        ["menu_fh_custody_hint"] = "Shows a hint when going into custody.",
        ["menu_fh_medbag"] = "Doctor Bag",
        ["menu_fh_medbag_hint"] = "Shows a hint when using a Doctor Bag.",
        ["menu_fh_welcome"] = "Welcome",
        ["menu_fh_welcome_hint"] = "Chance for a hint upon starting a heist.",

        ["menu_fh_sequences"] = "Sequences",
        ["menu_fh_sequences_hint"] = "Chance for hints that span multiple messages to play.\nThese can have mildly distracting effects attached.",

        ["menu_fh_mark_non_users"] = "Mark Non-Users",
        ["menu_fh_mark_non_users_hint"] = "Add a label on anyone that isn't using the mod.",
    })
end)


-- Functions

local log_count = 0
local log_time = 0
function FH.log(message)
    if not FH.log_file then
        return
    end

    if Application:time() > log_time then
        log_count = log_count + 1
    end
    log_time = Application:time()
    managers.chat:_receive_message(1, "Funny Hints", "(" .. log_count .. ") " .. tostring(message), tweak_data.system_chat_color)
end

function FH.is_host()
    return Network:is_server() or Global.game_settings.single_player
end

function FH.hints_are_blocked()
    if (FH.sequences.playing and FH.sequences.playing.stop_hints) or Global.FH.abandoned then
        return true
    else
        return false
    end
end

function FH.chaos_conflict(class_name, tags)
    if ChaosMod then
        tags = tags or {}
        for _, active_modifier in pairs(ChaosMod.active_modifiers) do
            if active_modifier:conflicts_with({ class_name = class_name, tags = tags, conflict_tags = tags }) then
                return true
            end
        end
    end
    return false
end

function FH.player_is_down()
    local playerdamage = managers.player:local_player():character_damage()
    return playerdamage and (playerdamage:incapacitated() or playerdamage:is_downed() or playerdamage:arrested())
end

local function selector(item_table, weight_table, use_key)
    local selector = WeightedSelector:new()
    if use_key then
        for item, value in pairs(item_table) do
            local weight = weight_table[item]
            selector:add(item, weight)
        end
    else
        for index, item in ipairs(item_table) do
            local weight = weight_table[item]
            selector:add(item, weight)
        end
    end
    return selector:select()
end
local function has_item(item_table, weight_item)
    for index, item in ipairs(item_table) do
        if item == weight_item then
            return true
        end
    end
    return false
end
local clean_ids = {}
local function clean_weights_and_select(id, item_table, weight_table, use_key, set_weight)
    if FH.sequences[id] and use_key then
        id = id .. "_sequence"
    end

    if not clean_ids[id] then
        if use_key then
            -- Remove weights for non-existent items
            for item, weight in pairs(weight_table) do
                if not item_table[item] then
                    weight_table[item] = nil
                end
            end
            -- Add weight for items not in the weight table
            for item, value in pairs(item_table) do
                if not weight_table[item] then
                    weight_table[item] = 1
                end
            end
        else
            -- Remove weights for non-existent items
            for item, weight in pairs(weight_table) do
                if not has_item(item_table, item) then
                    weight_table[item] = nil
                end
            end
            -- Add weight for items not in the weight table
            for index, item in ipairs(item_table) do
                if not weight_table[item] then
                    weight_table[item] = 1
                end
            end
        end
    end

    local selected_item = selector(item_table, weight_table, use_key)

    -- Reset weights if all are 0
    if not selected_item then
        for item, weight in pairs(weight_table) do
            weight_table[item] = 1
        end
        selected_item = selector(item_table, weight_table, use_key)
    end

    -- Set weight of selected item
    if set_weight and next(item_table) then
        weight_table[selected_item] = 0
        FH.sync_weight_on_duplicates(selected_item, 0)
        --FH.log("Weight set in clean_weights_and_select.")
    end

    clean_ids[id] = true

    return selected_item
end

function FH.select_hint(id)
    if FH.options.sequences and FH.sequences[id] and FH.hint_params[id] and not FH.sequences.playing then
        if math.random() < ((not FH.hint_params[id].sequence_skips or FH.hint_params[id].sequence_skips == 0) and FH.hint_params[id].sequence_chance or 0) then
            FH.start_sequence(id)
            return
        end
    end

    if FH.log_file then
        FH.log_file.last_hint = id
        io.save_as_json(FH.log_file, FH.dev_path)
    end

    if not Global.FH.weights[id] then
        Global.FH.weights[id] = {}
    end

    local message_table = FH.messages[id]
    local weight_table = Global.FH.weights[id]
    local selected_message = clean_weights_and_select(id, message_table, weight_table, false, false)

    local app_time = Application:time()
    if FH.last_hint and FH.last_hint.time + 0.03 > app_time then -- if it's overriding another message +0.03 is to account for a single frame at 30fps
        Global.FH.weights[FH.last_hint.id][FH.last_hint.text] = 0
        FH.log("Two messages played at once.\n" .. FH.last_hint.id .. "\n" .. id)
    end

    FH.last_hint = {
        time = app_time,
        id = id,
        text = selected_message
    }

    if FH.options.sequences and selected_message == "$sequence;" then
        FH.start_sequence(id .. "_common")
        Global.FH.weights[id][selected_message] = 0
        return
    end
    return selected_message
    -- Weights for messages don't get set here to prevent setting them if they didn't get rendered. Go to hudmanager.lua for set_message_weight().
    -- Weights for anything else get set in clean_weights_and_select() if the 5th parameter is true.
end

local cooldown = {}
function FH.show_hint(id, gsub_data)
    --FH.log("Attempting to show hint: " .. id)
    if not FH.messages[id] or #FH.messages[id] == 0 then
        return
    end
    if FH.hints_are_blocked() then
        return
    end

    local disabled_civ_kill = not FH.options.civ_kill and string.find(id, "^hud_civilian_killed_title")
    local disabled_custody = not FH.options.custody and string.find(id, "^custody_visit")
    local disabled_teammate_electrocuted = not FH.options.teammate_electrocuted and string.find(id, "^teammate_electrocuted")
    local disabled_downed = not FH.options.downed and string.find(id, "^downed")
    local disabled_flash = not FH.options.flash and string.find(id, "^flash")
    local disabled_loot_secured = not FH.options.loot_secured and string.find(id, "^hud_loot_secured_title")
    local disabled_medbag = not FH.options.medbag and string.find(id, "^replenished")
    local disabled_welcome = not FH.options.welcome and string.find(id, "^welcome")

    if disabled_civ_kill or disabled_custody or disabled_teammate_electrocuted or disabled_downed or disabled_flash or disabled_loot_secured or disabled_medbag or disabled_welcome then
        return
    end

    local app_time = Application:time()
    if math.random() < (FH.hint_params[id] and FH.hint_params[id].chance or 1) and (cooldown[id] or 0) - app_time < 0 then
        local selected_message = FH.select_hint(id)
        if not selected_message then
            return -- FH.select_hint will return nil if a sequence started from it
        end

        if gsub_data then
            for index, data in ipairs(gsub_data) do
                selected_message = selected_message:gsub(data.pattern, data.text)
            end
        end

        managers.hud:show_hint({ text = selected_message })
        cooldown[id] = app_time + ((FH.hint_params[id] and FH.hint_params[id].cooldown) or 2)
    end

    -- enable sequence after hint being shown the specified amount of times
    if FH.hint_params[id] and FH.hint_params[id].sequence_skips then
        FH.hint_params[id].sequence_skips = math.max(0, FH.hint_params[id].sequence_skips - 1)
    end
end

function FH.get_unit_name(id, is_bot)
    local unit_name = "ERROR"
    if is_bot then
        local bot_unit = managers.criminals:character_unit_by_name(id)
        if bot_unit then
            unit_name = bot_unit:base():nick_name()
        end
    else
        local peer = managers.network:session():peer(id)
        if peer then
            unit_name = peer:name()
        end
    end
    return unit_name
end

FH.duplicate_messages = {}
function FH.sync_weight_on_duplicates(selected_message, weight)
    local log_sync_count = 0
    if FH.duplicate_messages[selected_message] then
        for hint_id, boolean in pairs(FH.duplicate_messages[selected_message]) do
            if not Global.FH.weights[hint_id] then
                Global.FH.weights[hint_id] = {}
            end
            Global.FH.weights[hint_id][hint_id] = weight
            --log_sync_count = log_sync_count + 1
        end
    end
    if log_sync_count > 0 then
        FH.log("Weight set in sync_weight_on_duplicates " .. log_sync_count .. " times.")
    end
end

local function mark_of_shame_message(name, reason)
    managers.chat:_receive_message(1, "SYSTEM", name .. " has received the Mark of Shame for " .. reason .. ".", tweak_data.system_chat_color)
end

function FH.mark_player(peer_id, text, color)
    local name_label = managers.hud:_name_label_by_peer_id(peer_id)

    if name_label then
        local name_panel = name_label.panel
        local cheater_panel = name_panel:child("cheater")
        cheater_panel:set_text(text)
        if color then
            cheater_panel:set_color(color)
        end

        -- HopHud Compatibility
        local cw, ch = cheater_panel:size()
        if cw == 0 or ch == 0 then
            local _, _, tw, th = cheater_panel:text_rect()
            cheater_panel:set_size(tw, th)
            cw, ch = cheater_panel:size()

            local text_panel = name_panel:child("text")
            cheater_panel:set_left(text_panel:right() + (th / 3))

            local nw, nh = name_panel:size()
            name_panel:set_size((nw + cw + (th / 3)), nh)
        end
    end
    managers.hud:mark_cheater(peer_id)
end

-- Networking

local function register_sender(sender)
    if not FH.clients[sender] then
        FH.clients[sender] = true
        FH.log("Registered client: " .. FH.get_unit_name(sender, false))
        return true
    else
        return false
    end
end

function FH.show_networked_hint(net_data, gsub_data)
    id = json.decode(net_data).id

    NetworkHelper:SendToPeers("show_hint_FH", net_data)
    FH.show_hint(id, gsub_data)
end

NetworkHelper:AddReceiveHook("handshake_request_FH", "handshake_request_FH", function(_, sender)
    FH.log("Recieved handshake request from " .. FH.get_unit_name(sender, false))
    register_sender(sender)
    NetworkHelper:SendToPeer(sender, "handshake_accept_FH", "")
end)

NetworkHelper:AddReceiveHook("handshake_accept_FH", "handshake_accept_FH", function(_, sender)
    FH.log("Handshake accepted by " .. FH.get_unit_name(sender, false))
    register_sender(sender)
end)

NetworkHelper:AddReceiveHook("show_hint_FH", "show_hint_FH", function(data, sender)
    --FH.log("Recieving hint from: " .. FH.get_unit_name(sender))
    if FH.hints_are_blocked() then
        return
    end

    data = json.decode(data)
    if not data then
        return -- prevents hop sending a crash command
    end

    local sender_name = FH.get_unit_name(sender)

    if string.find(tostring(data.id), "^downed") then
        if not FH.messages[data.id] or #FH.messages[data.id] == 0 then
            data.id = "downed_generic"
        end
        FH.show_hint("hint_teammate_" .. data.id, { { pattern = "$TEAMMATE;", text = sender_name } })
    else
        FH.log("Networked hint isn't handled.\n" .. sender_name .. "\n" .. data.id)
    end
end)

NetworkHelper:AddReceiveHook("mark_of_shame_FH", "mark_of_shame_FH", function(reason, sender)
    local sender_name = FH.get_unit_name(sender)

    mark_of_shame_message(sender_name, reason)
    FH.mark_player(sender, "STINKY", Color(255, 56, 243, 171) / 255)
end)


NetworkHelper:AddReceiveHook("net_log_FH", "net_log_FH", function(message, sender)
    local sender_name = FH.get_unit_name(sender)
    FH.log(sender_name .. " is " .. message)
end)


-- Sequences

local function end_sequence(still_playing_effect)
    if still_playing_effect then
        FH.sequences.playing.stop_hints = false
    else
        FH.sequences.playing = nil
    end
    managers.hud.show_hint = Global.FH.show_hint_stored
end

local function sequence_failed(id, key, retry)
    FH.log("Can't play sequence " .. key)
    Global.FH.weights.sequences[id][key] = 1

    if retry then
        FH.start_sequence(id)
        return
    else
        end_sequence()
        if FH.messages[id] then
            FH.show_hint(id)
        end
    end
end

function FH.start_sequence(id, testing_key)
    if Global.FH.abandoned then
        return
    end

    if not Global.FH.weights.sequences then
        Global.FH.weights.sequences = {}
    end
    if not Global.FH.weights.sequences[id] then
        Global.FH.weights.sequences[id] = {}
    end

    local selected_sequence = nil
    if not testing_key then
        local sequence_table = FH.sequences[id]
        local weight_table = Global.FH.weights.sequences[id]
        selected_sequence = clean_weights_and_select(id, sequence_table, weight_table, true, true)
    end

    FH.sequences.playing = { id = id, key = selected_sequence or testing_key, stop_hints = true }
    managers.hud.show_hint = function(_) end
    FH.sequences[id][selected_sequence or testing_key].seq1(id, selected_sequence or testing_key)

    NetworkHelper:SendToPeers("net_log_FH", "playing sequence: " .. (selected_sequence or testing_key))
end

function FH.stop_sequence(id, key)
    DelayedCalls:Remove("hint_sequence_FH")
    if FH.sequences[id][key].seq_restore then
        FH.sequences[id][key].seq_restore(id, key)
    end
    end_sequence()
end

local function sequence_effect(id)
    local effects = {
        mark_of_shame = function()
            FH.mark_of_shame = true
            local reason = "wasting meds"
            local local_peer = managers.network:session():local_peer()
            mark_of_shame_message(local_peer:name(), reason)
            NetworkHelper:SendToPeers("mark_of_shame_FH", reason)
        end,
        color_calibrator = function()
            local color_grading = "color_sunsetstrip"
            if managers.user:get_setting("video_color_grading") == color_grading then
                color_grading = managers.environment_controller._default_color_grading
            end

            managers.environment_controller._vp:vp():set_post_processor_effect("World", Idstring("color_grading_post"), Idstring(color_grading))
        end
    }
    if effects[id] then
        effects[id]()
    end
end

FH.sequences = {
    downed_generic_common = {
        down_newbie = {
            seq1 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Hey, let me guess, this your first time playing?", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 4, function()
                    FH.sequences[id][key].seq2(id, key)
                end)
            end,
            seq2 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "No?", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 2, function()
                    FH.sequences[id][key].seq3(id, key)
                end)
            end,
            seq3 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Oof. That's embarrassing." })
                DelayedCalls:Add("hint_sequence_FH", 3, function()
                    end_sequence()
                end)
            end,
        }
    },
    downed_deep_boss_common = {
        deep_boss_mgs = {
            seq1 = function(id, key)
                local name = managers.network:session():local_peer():name()
                Global.FH.show_hint_stored(managers.hud, { text = name .. "?", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 2, function()
                    FH.sequences[id][key].seq2(id, key, name)
                end)
            end,
            seq2 = function(id, key, name)
                local name_uppercase = name:upper()
                Global.FH.show_hint_stored(managers.hud, { text = name_uppercase .. "!?", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 2, function()
                    FH.sequences[id][key].seq3(id, key, name_uppercase)
                end)
            end,
            seq3 = function(id, key, name)
                local last_letter = name:sub(-1)
                local name_long = name .. last_letter .. last_letter .. last_letter
                Global.FH.show_hint_stored(managers.hud, { text = name_long .. "!!!", time = 3 })
                DelayedCalls:Add("hint_sequence_FH", 3, function()
                    end_sequence()
                end)
            end,
        }
    },
    hud_civilian_killed_title_common = {
        civ_kill_technique = {
            seq1 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Yeah, that's what I woulda did.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 3, function()
                    FH.sequences[id][key].seq2(id, key)
                end)
            end,
            seq2 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "That's the technique." })
                DelayedCalls:Add("hint_sequence_FH", 3, function()
                    end_sequence()
                end)
            end,
        },
    },
    hud_gage_assignment_progress_common = {
        gage_smoke = {
            seq1 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Smoke.", time = 3 })
                DelayedCalls:Add("hint_sequence_FH", 10, function()
                    FH.sequences[id][key].seq2(id, key)
                end)
            end,
            seq2 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Smoke.", time = 3 })
                DelayedCalls:Add("hint_sequence_FH", 10, function()
                    FH.sequences[id][key].seq3(id, key)
                end)
            end,
            seq3 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Are you smoking yet?" })
                DelayedCalls:Add("hint_sequence_FH", 3, function()
                    end_sequence()
                end)
            end
        },
        gage_pizzalawsuit = {
            seq1 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "BRB, my pizza's here.", time = 4 })
                DelayedCalls:Add("hint_sequence_FH", math.random(60, 120), function()
                    FH.sequences[id][key].seq2(id, key)
                end)
            end,
            seq2 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "The delivery guy is filing a police report against me.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 5, function()
                    FH.sequences[id][key].seq3(id, key)
                end)
            end,
            seq3 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "It's not my fault he didn't stop before the spike strip!", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 5, function()
                    FH.sequences[id][key].seq4(id, key)
                end)
            end,
            seq4 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "He also made me pay for a tow-truck.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 4, function()
                    FH.sequences[id][key].seq5(id, key)
                end)
            end,
            seq5 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Pizza's good though." })
                DelayedCalls:Add("hint_sequence_FH", 3, function()
                    end_sequence()
                end)
            end
        },
    },
    replenished_nothing_2 = {
        wasteful_naughty = {
            seq1 = function(id, key)
                if Global.game_settings.single_player or not next(FH.clients) or FH.mark_of_shame then
                    sequence_failed(id, key)
                    return
                end

                Global.FH.show_hint_stored(managers.hud, { text = "Enough! You're going on the naughty list!" })
                DelayedCalls:Add("hint_sequence_FH", 4, function()
                    FH.sequences[id][key].seq2(id, key)
                end)
            end,
            seq2 = function(id, key)
                sequence_effect("mark_of_shame")

                DelayedCalls:Add("hint_sequence_FH", 4, function()
                    FH.sequences[id][key].seq3(id, key)
                end)
            end,
            seq3 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Are you proud of yourself?" })
                FH.messages.replenished_nothing_2 = nil
                DelayedCalls:Add("hint_sequence_FH", 3, function()
                    end_sequence()
                end)
            end,
        },
        wasteful_consequences = {
            seq1 = function(id, key)
                if Global.game_settings.single_player or not next(FH.clients) or FH.mark_of_shame then
                    sequence_failed(id, key)
                    return
                end

                sequence_effect("mark_of_shame")

                DelayedCalls:Add("hint_sequence_FH", 4, function()
                    FH.sequences[id][key].seq3(id, key)
                end)
            end,
            seq3 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Did you think there would be no consequences?" })
                FH.messages.replenished_nothing_2 = nil
                DelayedCalls:Add("hint_sequence_FH", 3, function()
                    end_sequence()
                end)
            end,
        },
    },
    abandoned = {
        abandoned_KMS = {
            seq1 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Really?", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 2, function()
                    FH.sequences[id][key].seq2(id, key)
                end)
            end,
            seq2 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Your gameplay is awful.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 3, function()
                    FH.sequences[id][key].seq3(id, key)
                end)
            end,
            seq3 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "How many hours do you have in this game?", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 4, function()
                    FH.sequences[id][key].seq4(id, key)
                end)
            end,
            seq4 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "I mean why am I even asking, you modded the game!", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 5, function()
                    FH.sequences[id][key].seq5(id, key)
                end)
            end,
            seq5 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "You don't mod a game you have single digit hours in!", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 5, function()
                    FH.sequences[id][key].seq6(id, key)
                end)
            end,
            seq6 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "You should really KMS yourself.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 4, function()
                    FH.sequences[id][key].seq7(id, key)
                end)
            end,
            seq7 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "That's right I said it.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 2, function()
                    FH.sequences[id][key].seq8(id, key)
                end)
            end,
            seq8 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "You should kill myself your-", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 2, function()
                    FH.sequences[id][key].seq9(id, key)
                end)
            end,
            seq9 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "...", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 2, function()
                    FH.sequences[id][key].seq10(id, key)
                end)
            end,
            seq10 = function(id, key)
                Global.FH.abandoned = true
                Global.FH.show_hint_stored(managers.hud, { text = "Whatever! Screw this! I'm outta here!" })
            end,
        },
        abandoned_nice = {
            seq1 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Okay, you seem to be having a really hard time.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 4, function()
                    FH.sequences[id][key].seq2(id, key)
                end)
            end,
            seq2 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Games are meant to be fun, there's no need to put yourself through this.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 6, function()
                    FH.sequences[id][key].seq3(id, key)
                end)
            end,
            seq3 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "You can just quit and lower the difficulty.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 3, function()
                    FH.sequences[id][key].seq4(id, key)
                end)
            end,
            seq4 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Don't worry. I won't judge you for that.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 3, function()
                    FH.sequences[id][key].seq5(id, key)
                end)
            end,
            seq5 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "If you want you could also just go play a different game that's more your speed.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 5, function()
                    FH.sequences[id][key].seq6(id, key)
                end)
            end,
            seq6 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Whatever is right for you.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 3, function()
                    FH.sequences[id][key].seq7(id, key)
                end)
            end,
            seq7 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "So go ahead. Let yourself take it easy.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 3, function()
                    FH.sequences[id][key].seq8(id, key)
                end)
            end,
            seq8 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "I'll be waiting for you to come back whenever you want to." })
                DelayedCalls:Add("hint_sequence_FH", 10, function()
                    FH.sequences[id][key].seq9(id, key)
                end)
            end,
            seq9 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "No...?", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 3, function()
                    FH.sequences[id][key].seq10(id, key)
                end)
            end,
            seq10 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Well then I'm sorry but if you're choosing to continue when you're this bad I don't wanna see it.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 7, function()
                    FH.sequences[id][key].seq11(id, key)
                end)
            end,
            seq11 = function(id, key)
                Global.FH.abandoned = true
                Global.FH.show_hint_stored(managers.hud, { text = "You're on your own. Enjoy being a masochist I guess." })
            end,
        },
        abandoned_ugly = {
            seq1 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Wow.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 2, function()
                    FH.sequences[id][key].seq2(id, key)
                end)
            end,
            seq2 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "You suck.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 2, function()
                    FH.sequences[id][key].seq3(id, key)
                end)
            end,
            seq3 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Like...", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 1, function()
                    FH.sequences[id][key].seq4(id, key)
                end)
            end,
            seq4 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "You really suck.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 2, function()
                    FH.sequences[id][key].seq5(id, key)
                end)
            end,
            seq5 = function(id, key)
                Global.FH.abandoned = true
                Global.FH.show_hint_stored(managers.hud, { text = "I'm not sticking around with you.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 2, function()
                    FH.sequences[id][key].seq6(id, key)
                end)
            end,
            seq6 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "See ya.", time = 2 })
                DelayedCalls:Add("hint_sequence_FH", 6, function()
                    FH.sequences[id][key].seq7(id, key)
                end)
            end,
            seq7 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Also your mask is ugly.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 2, function()
                    FH.sequences[id][key].seq8(id, key)
                end)
            end,
            seq8 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Just had to be said.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 3, function()
                    FH.sequences[id][key].seq9(id, key)
                end)
            end,
            seq9 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Okay, I'm leaving for real now.", time = 3 })
            end,
        },
        abandoned_shame = {
            seq1 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "You're bringing shame to your family.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 3, function()
                    FH.sequences[id][key].seq2(id, key)
                end)
            end,
            seq2 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "I can just see them talking about you now.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 3, function()
                    FH.sequences[id][key].seq3(id, key)
                end)
            end,
            seq3 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "\"I can't believe my child is bad at Payday!\"", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 3.5, function()
                    FH.sequences[id][key].seq4(id, key)
                end)
            end,
            seq4 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "\"How will you amount to anything in life if you can't even beat all heists on DSOD?\"", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 6, function()
                    FH.sequences[id][key].seq5(id, key)
                end)
            end,
            seq5 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Of course though you wouldn't know what DSOD means. You're not good enough to play it.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 6, function()
                    FH.sequences[id][key].seq6(id, key)
                end)
            end,
            seq6 = function(id, key)
                local perk_deck_name = nil
                local message_start = "\"And a "
                local local_peer = managers.network:session():local_peer()
                local perk_id = local_peer:blackmarket_outfit().skills.specializations[1]
                if perk_id and tonumber(perk_id) <= #tweak_data.skilltree.specializations then
                    perk_deck_name = managers.localization:text("menu_st_spec_" .. tostring(perk_id))
                    if perk_deck_name:match("^[aeiouAEIOU]") then
                        message_start = "\"And an "
                    end
                end
                if perk_deck_name then
                    Global.FH.show_hint_stored(managers.hud, { text = message_start .. perk_deck_name .. " user at that.\"", time = 10 })
                    DelayedCalls:Add("hint_sequence_FH", 4, function()
                        FH.sequences[id][key].seq7(id, key)
                    end)
                else
                    FH.sequences[id][key].seq7(id, key)
                end
            end,
            seq7 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "You know, I bring shame to myself too just by entertaining you.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 5, function()
                    FH.sequences[id][key].seq8(id, key)
                end)
            end,
            seq8 = function(id, key)
                Global.FH.abandoned = true
                Global.FH.show_hint_stored(managers.hud, { text = "Therefore I will now disown you just like your family surely will too.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 4.5, function()
                    FH.sequences[id][key].seq9(id, key)
                end)
            end,
            seq9 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Au revoir. It hasn't been a pleasure." })
            end,
        },
    },
    hud_gage_assignment_progress = {
        gage_modern_payday = {
            seq1 = function(id, key)
                local local_peer = managers.network:session():local_peer()
                local char_name = managers.criminals:character_name_by_peer_id(local_peer:id())

                Global.FH.show_hint_stored(managers.hud, { text = "Nice work " .. char_name .. ", you've collected a Gage Package!", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 5, function()
                    FH.sequences[id][key].seq2(id, key)
                end)
            end,
            seq2 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "You can check your progress in Crime.net's sidebar under \"Gage\".", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 5, function()
                    FH.sequences[id][key].seq3(id, key)
                end)
            end,
            seq3 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "This will open the Courier Assignments page.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 4, function()
                    FH.sequences[id][key].seq4(id, key)
                end)
            end,
            seq4 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "When you're in the Courier Assignments page press \"Package Progress\" to see your progress.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 6, function()
                    FH.sequences[id][key].seq5(id, key)
                end)
            end,
            seq5 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "There you will see the progress for each package type you've collected.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 5, function()
                    FH.sequences[id][key].seq6(id, key)
                end)
            end,
            seq6 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "You can also see the rewards for each package type there.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 4, function()
                    FH.sequences[id][key].seq7(id, key)
                end)
            end,
            seq7 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Simply press on the name of the package type to see the rewards.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 5, function()
                    FH.sequences[id][key].seq8(id, key)
                end)
            end,
            seq8 = function(id, key)
                local quit_button_text = "Terminate Contract"
                if Global.game_settings.single_player then
                    quit_button_text = "Quit to Main Menu"
                end
                Global.FH.show_hint_stored(managers.hud, { text = "If you want to look at them now, press the pause button and select \"" .. quit_button_text .. "\".", time = 6 })
                DelayedCalls:Add("hint_sequence_FH", 5, function()
                    end_sequence()
                end)
            end,
        },
        gage_cut_sound = {
            seq1 = function(id, key)
                if FH.chaos_conflict("ChaosModifierTruce") and FH.chaos_conflict("ChaosModifierNoSound") then
                    sequence_failed(id, key, true)
                    return
                end

                SoundDevice:set_rtpc("option_music_volume", 0)
                SoundDevice:set_rtpc("option_sfx_volume", 0)
                DelayedCalls:Add("hint_sequence_FH", 3, function()
                    FH.sequences[id][key].seq2(id, key)
                end)
            end,
            seq2 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Oh sorry.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 2, function()
                    FH.sequences[id][key].seq3(id, key)
                end)
            end,
            seq3 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "I stepped on the cable.", time = 3 })
                DelayedCalls:Add("hint_sequence_FH", 7, function()
                    if not FH.chaos_conflict("ChaosModifierTruce") then
                        SoundDevice:set_rtpc("option_music_volume", managers.user:get_setting("music_volume") * 3)
                    end
                    if not FH.chaos_conflict("ChaosModifierNoSound") then
                        SoundDevice:set_rtpc("option_sfx_volume", managers.user:get_setting("sfx_volume") * 3)
                    end
                    FH.sequences[id][key].seq4(id, key)
                end)
            end,
            seq4 = function(id, key)
                DelayedCalls:Add("hint_sequence_FH", 1, function()
                    FH.sequences[id][key].seq_restore(id, key)
                    FH.sequences[id][key].seq5(id, key)
                end)
            end,
            seq5 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Fixed.", time = 3 })
                DelayedCalls:Add("hint_sequence_FH", 2, function()
                    end_sequence()
                end)
            end,
            seq_restore = function()
                if not FH.chaos_conflict("ChaosModifierTruce") then
                    SoundDevice:set_rtpc("option_music_volume", managers.user:get_setting("music_volume"))
                end
                if not FH.chaos_conflict("ChaosModifierNoSound") then
                    SoundDevice:set_rtpc("option_sfx_volume", managers.user:get_setting("sfx_volume"))
                end
            end
        },
        gage_color = {
            seq1 = function(id, key)
                if not managers.environment_controller then
                    sequence_failed(id, key, true)
                    return
                end

                Global.FH.show_hint_stored(managers.hud, { text = "I think your monitor's colors aren't calibrated right.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 4, function()
                    FH.sequences[id][key].seq2(id, key)
                end)
            end,
            seq2 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Lucky for you I'm an ISF Certified Calibrator.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 4, function()
                    FH.sequences[id][key].seq3(id, key)
                end)
            end,
            seq3 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Yes that is a real job.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 3, function()
                    FH.sequences[id][key].seq4(id, key)
                end)
            end,
            seq4 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Now let me just...", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 4, function()
                    if managers.environment_controller and not FH.sequences[id][key].seq_conflicts() then
                        sequence_effect("color_calibrator")
                        FH.sequences[id][key].seq5(id, key)
                    else
                        FH.sequences[id][key].seq5b1(id, key)
                    end
                end)
            end,
            seq5 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "There, that's much better.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 3, function()
                    FH.sequences[id][key].seq6(id, key)
                end)
            end,
            seq5b1 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Hm.. I can't seem to change it right now.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 4, function()
                    FH.sequences[id][key].seq5b2(id, key)
                end)
            end,
            seq5b2 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Let me try one more time...", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 4, function()
                    if managers.environment_controller and not FH.sequences[id][key].seq_conflicts() then
                        sequence_effect("color_calibrator")
                        FH.sequences[id][key].seq5(id, key)
                    else
                        FH.sequences[id][key].seq5c1(id, key)
                    end
                end)
            end,
            seq5c1 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Nope. It's not working.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 3, function()
                    FH.sequences[id][key].seq5c2(id, key)
                end)
            end,
            seq5c2 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Sorry bud. Guess you have to keep playing like this." })
                DelayedCalls:Add("hint_sequence_FH", 4, function()
                    end_sequence()
                end)
            end,
            seq6 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "You know calibrators are really underappreciated.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 4, function()
                    FH.sequences[id][key].seq7(id, key)
                end)
            end,
            seq7 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Haven't you ever noticed that no screen looks the same?", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 5, function()
                    FH.sequences[id][key].seq8(id, key)
                end)
            end,
            seq8 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Us calibrators fix that. Our job is to make your screen show the truth.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 7, function()
                    FH.sequences[id][key].seq9(id, key)
                end)
            end,
            seq9 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Without us, the Matrix would have been yellow!", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 4, function()
                    FH.sequences[id][key].seq11(id, key)
                end)
            end,
            seq11 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "They almost made the movie set in Mexican-Chicago!", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 4, function()
                    FH.sequences[id][key].seq12(id, key)
                end)
            end,
            seq12 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Anyway sorry, how do you like the colors now?", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 4, function()
                    FH.sequences[id][key].seq13(id, key)
                end)
            end,
            seq13 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "You hate them?", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 3, function()
                    FH.sequences[id][key].seq14(id, key)
                end)
            end,
            seq14 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "But this is how the game was supposed to look like!", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 4, function()
                    FH.sequences[id][key].seq15(id, key)
                end)
            end,
            seq15 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "I guess there's no accounting for bad taste.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 4, function()
                    FH.sequences[id][key].seq16(id, key)
                end)
            end,
            seq16 = function(id, key)
                FH.sequences[id][key].seq_restore()
                Global.FH.show_hint_stored(managers.hud, { text = "There you go. Back to your settings.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 4, function()
                    FH.sequences[id][key].seq17(id, key)
                end)
            end,
            seq17 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Happy?", time = 3 })
                DelayedCalls:Add("hint_sequence_FH", 2, function()
                    end_sequence()
                end)
            end,
            seq_set_color_grading = function()
                local color_grading = "color_sunsetstrip"
                if managers.user:get_setting("video_color_grading") == color_grading then
                    color_grading = managers.environment_controller._default_color_grading
                end

                managers.environment_controller._vp:vp():set_post_processor_effect("World", Idstring("color_grading_post"), Idstring(color_grading))
            end,
            seq_conflicts = function()
                return FH.chaos_conflict("FunnyHintsScreenEffect", { "ScreenEffect" })
            end,
            seq_restore = function()
                if managers.environment_controller then
                    managers.environment_controller:refresh_render_settings()
                end
            end,
        },
        gage_music = {
            seq1 = function(id, key)
                if ChaosMod then
                    sequence_failed(id, key, true)
                    return
                end

                Global.FH.show_hint_stored(managers.hud, { text = "Man this music sucks.", time = 10 })
                DelayedCalls:Add("hint_sequence_FH", 3, function()
                    FH.sequences[id][key].seq2(id, key)
                end)
            end,
            seq2 = function(id, key)
                FH.sequences.current_event_name = Global.music_manager.current_event
                managers.music:post_event("stop_all_music")

                FH.sequences.stored_functions = {}
                FH.sequences.stored_functions.post_event = managers.music.post_event
                FH.sequences.stored_functions.check_music_switch = managers.music.check_music_switch

                managers.music.post_event = function(_, event) FH.sequences.current_event_name = event end
                managers.music.check_music_switch = function() end

                Global.FH.show_hint_stored(managers.hud, { text = "Here, let me put on some good shit...", time = 3 })
                DelayedCalls:Add("hint_sequence_FH", 4, function()
                    FH.sequences[id][key].seq3(id, key)
                end)
            end,
            seq3 = function(id, key)
                FH.sequences.songs = {
                    criminals_ambition = 193,
                    half_passed_wicked = 230,
                    pth_i_will_give_you_my_all = 177,
                }

                if not Global.FH.weights.gagejukebox then
                    Global.FH.weights.gagejukebox = {}
                end

                local song_table = FH.sequences.songs
                local weight_table = Global.FH.weights.gagejukebox

                local selected_song = clean_weights_and_select("gagejukebox", song_table, weight_table, true, true)

                FH.sequences.songs = nil

                Global.music_manager.source:post_event(selected_song)

                local screen_time = 3
                DelayedCalls:Add("hint_sequence_FH", screen_time, function()
                    local time = song_table[selected_song] - screen_time
                    FH.sequences[id][key].seq4(id, key, time)
                end)
            end,
            seq4 = function(id, key, time)
                Global.FH.show_hint_stored(managers.hud, { text = "Oh yeah.", time = 10 })
                local screen_time = 2
                DelayedCalls:Add("hint_sequence_FH", screen_time, function()
                    time = time - screen_time
                    FH.sequences[id][key].seq5(id, key, time)
                end)
            end,
            seq5 = function(id, key, time)
                Global.FH.show_hint_stored(managers.hud, { text = "Now that's the stuff.", time = 3 })
                local screen_time = 4
                DelayedCalls:Add("hint_sequence_FH", screen_time, function()
                    time = time - screen_time
                    FH.sequences[id][key].seq6(id, key, time)
                end)
            end,
            seq6 = function(id, key, time)
                end_sequence(true)
                DelayedCalls:Add("hint_sequence_FH", time, function()
                    FH.sequences[id][key].seq_restore()
                    FH.sequences.playing = nil
                end)
            end,
            seq_restore = function()
                if FH.sequences.stored_functions then
                    managers.music.post_event = FH.sequences.stored_functions.post_event
                    managers.music.check_music_switch = FH.sequences.stored_functions.check_music_switch

                    Global.music_manager.source:post_event("stop_all_music")
                    Global.music_manager.source:set_switch("music_randomizer", Global.music_manager.current_track)
                    managers.music:post_event(FH.sequences.current_event_name)

                    FH.sequences.stored_functions = nil
                    FH.sequences.current_event_name = nil
                end
            end,
        },
        gage_hippo = {
            seq1 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "You know, Payday has really gone downhill hasn't it?", time = 20 })
                DelayedCalls:Add("hint_sequence_FH", 4.5, function()
                    FH.sequences[id][key].seq2(id, key)
                end)
            end,
            seq2 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Payday 3 released and it really made it look like they didn't know what made Payday 2 good.", time = 20 })
                DelayedCalls:Add("hint_sequence_FH", 7, function()
                    FH.sequences[id][key].seq3(id, key)
                end)
            end,
            seq3 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "I mean I guess that's kinda the big problem they've had, isn't it?", time = 20 })
                DelayedCalls:Add("hint_sequence_FH", 5.5, function()
                    FH.sequences[id][key].seq4(id, key)
                end)
            end,
            seq4 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "They just kept adding stuff to the game and understanding how it all came together isn't easy.", time = 20 })
                DelayedCalls:Add("hint_sequence_FH", 6.5, function()
                    FH.sequences[id][key].seq5(id, key)
                end)
            end,
            seq5 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "And you can't easily make another game in a series when you don't know what made the previous good.", time = 20 })
                DelayedCalls:Add("hint_sequence_FH", 8, function()
                    FH.sequences[id][key].seq6(id, key)
                end)
            end,
            seq6 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "You just end up alluding to what was good about the previous game with no substance.", time = 20 })
                DelayedCalls:Add("hint_sequence_FH", 6.5, function()
                    FH.sequences[id][key].seq7(id, key)
                end)
            end,
            seq7 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "It looks like you have a lot of cool mechanics but none of them work together.", time = 20 })
                DelayedCalls:Add("hint_sequence_FH", 6.5, function()
                    FH.sequences[id][key].seq8(id, key)
                end)
            end,
            seq8 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "At least that's what I think.", time = 20 })
                DelayedCalls:Add("hint_sequence_FH", 4, function()
                    FH.sequences[id][key].seq9(id, key)
                end)
            end,
            seq9 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "But I'm no game designer, I'm just a disembodied voice in your head.", time = 20 })
                DelayedCalls:Add("hint_sequence_FH", 5, function()
                    FH.sequences[id][key].seq10(id, key)
                end)
            end,
            seq10 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Maybe the ideas they had were really well thought out but it wasn't implemented right.", time = 20 })
                DelayedCalls:Add("hint_sequence_FH", 7.5, function()
                    FH.sequences[id][key].seq11(id, key)
                end)
            end,
            seq11 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Maybe it all just got lost in translation and we didn't get what we should have.", time = 20 })
                DelayedCalls:Add("hint_sequence_FH", 7, function()
                    FH.sequences[id][key].seq12(id, key)
                end)
            end,
            seq12 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "I've heard they're now handing Payday to other developers.", time = 20 })
                DelayedCalls:Add("hint_sequence_FH", 6, function()
                    FH.sequences[id][key].seq13(id, key)
                end)
            end,
            seq13 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Like that \"Aces High\" game.", time = 20 })
                DelayedCalls:Add("hint_sequence_FH", 5, function()
                    FH.sequences[id][key].seq14(id, key)
                end)
            end,
            seq14 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Though that is just a VR spin-off. I guess they'll still handle any major releases themselves.", time = 20 })
                DelayedCalls:Add("hint_sequence_FH", 9, function()
                    FH.sequences[id][key].seq15(id, key)
                end)
            end,
            seq15 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "But imagine a world where we get another major game, made by the truly passionate about the franchise.", time = 20 })
                DelayedCalls:Add("hint_sequence_FH", 10, function()
                    FH.sequences[id][key].seq16(id, key)
                end)
            end,
            seq16 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Now that would be a very interesting world to live in.", time = 20 })
                DelayedCalls:Add("hint_sequence_FH", 5, function()
                    FH.sequences[id][key].seq17(id, key)
                end)
            end,
            seq17 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "They have handed over Payday 2 to a studio of fans and that has been nothing but great for the game.", time = 20 })
                DelayedCalls:Add("hint_sequence_FH", 9, function()
                    FH.sequences[id][key].seq18(id, key)
                end)
            end,
            seq18 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "A Payday 4 made by people who are deeply passionate about the series would surely come out good.", time = 20 })
                DelayedCalls:Add("hint_sequence_FH", 8, function()
                    FH.sequences[id][key].seq19(id, key)
                end)
            end,
            seq19 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Letting other studios handle the games while they're just a curator could be great.", time = 20 })
                DelayedCalls:Add("hint_sequence_FH", 7, function()
                    FH.sequences[id][key].seq20(id, key)
                end)
            end,
            seq20 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Actually I think that could be great for many franchises.", time = 20 })
                DelayedCalls:Add("hint_sequence_FH", 6, function()
                    FH.sequences[id][key].seq21(id, key)
                end)
            end,
            seq21 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Though at that point I think it's worth discussing if anyone should be able to hoard IP rights.", time = 20 })
                DelayedCalls:Add("hint_sequence_FH", 8, function()
                    FH.sequences[id][key].seq22(id, key)
                end)
            end,
            seq22 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Imagine a world where anyone can make media of your franchise and sell it.", time = 20 })
                DelayedCalls:Add("hint_sequence_FH", 7, function()
                    FH.sequences[id][key].seq23(id, key)
                end)
            end,
            seq23 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "You might actually compete with people that know where to take it better than you.", time = 20 })
                DelayedCalls:Add("hint_sequence_FH", 8, function()
                    FH.sequences[id][key].seq24(id, key)
                end)
            end,
            seq24 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "You would only be able to stay in business if you're truly what makes it special.", time = 20 })
                DelayedCalls:Add("hint_sequence_FH", 8, function()
                    FH.sequences[id][key].seq25(id, key)
                end)
            end,
            seq25 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "I think that's fair. Fan projects are rarely better than official ones.", time = 20 })
                DelayedCalls:Add("hint_sequence_FH", 6, function()
                    FH.sequences[id][key].seq26(id, key)
                end)
            end,
            seq26 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Though of course not always. A big exception I can think of is FNAF.", time = 20 })
                DelayedCalls:Add("hint_sequence_FH", 6, function()
                    FH.sequences[id][key].seq27(id, key)
                end)
            end,
            seq27 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "There's some amazing stuff out there made by fans. Have you heard of Frickbear's 3?", time = 20 })
                DelayedCalls:Add("hint_sequence_FH", 7, function()
                    FH.sequences[id][key].seq28(id, key)
                end)
            end,
            seq28 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Silly name, I know, but I assure you it's the cream of the crop.", time = 20 })
                DelayedCalls:Add("hint_sequence_FH", 6, function()
                    FH.sequences[id][key].seq29(id, key)
                end)
            end,
            seq29 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "It's nice of FNAF's creator to encourage fan creations as much as he does.", time = 20 })
                DelayedCalls:Add("hint_sequence_FH", 6, function()
                    FH.sequences[id][key].seq30(id, key)
                end)
            end,
            seq30 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Oh I'm sorry, I have gone far off-topic now.", time = 20 })
                DelayedCalls:Add("hint_sequence_FH", 4, function()
                    FH.sequences[id][key].seq31(id, key)
                end)
            end,
            seq31 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "I guess I'm not supposed to be ranting like this to begin with.", time = 20 })
                DelayedCalls:Add("hint_sequence_FH", 5, function()
                    FH.sequences[id][key].seq32(id, key)
                end)
            end,
            seq32 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "I don't know what got into me.", time = 20 })
                DelayedCalls:Add("hint_sequence_FH", 4, function()
                    FH.sequences[id][key].seq33(id, key)
                end)
            end,
            seq33 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "I'll go back to doing my job like normal.", time = 20 })
                DelayedCalls:Add("hint_sequence_FH", 4, function()
                    FH.sequences[id][key].seq34(id, key)
                end)
            end,
            seq34 = function(id, key)
                Global.FH.show_hint_stored(managers.hud, { text = "Hope I didn't miss informing you of anything important in that time." })
                DelayedCalls:Add("hint_sequence_FH", 5, function()
                    end_sequence()
                end)
            end,
        }
    },
}
