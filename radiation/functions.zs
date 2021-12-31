#priority 500

# PRIORITY_ORDER: tables.zs -> functions.zs
# REQUIRE:
# - Techguns

import crafttweaker.data.IData;
import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;
import crafttweaker.potions.IPotion;
import crafttweaker.potions.IPotionEffect;
import scripts.radiation.tables.radioactiveItems;
import scripts.radiation.tables.radProtectionArmor;


# Radiation data holder
# After load, keeps player radiation data in form <player.name : radiation_level>
static gRadiationData as double[string] = {
    "dummy" : 0.0
};


# LoggedIn and LoggedOut player event functions
function radiationPlayerLoggedInEvent(player as IPlayer) {
    loadRadFromPlayerNBT(player);
}

function radiationPlayerLoggedOutEvent(player as IPlayer) {
    saveRadToPlayerNBT(player);
}


# Player onTick radiation event function
function playerRadiationEvent(player as IPlayer) {
    var inventorySize = player.inventorySize as int;
    var dose as int = 0;

    for key in radioactiveItems.keys {
        for j in 0 to inventorySize as int {
            if !(isNull(player.getInventoryStack(j))) {
                if ((player.getInventoryStack(j).definition.id).matches(key.definition.id)) {
                    if (radioactiveItems[key] > dose) {
                        # TODO: Change rad.item and dose values to double
                        dose = radioactiveItems[key] as int;
                    }
                }
            }
        }
    }

    if (dose > 0) {
        //addRadiationEffect(dose, player); //OBSOLETE -> NEED REWORK
        addRadLevel(player, dose as double);
    }

    if (getRadLevel(player) > 0.0) {
        setRadiationDebufs(player);
        radDiminishing(player);
    }
}


# RadLevel handling
function getRadLevel(player as IPlayer) as double{
    return gRadiationData[player.name] as double;
}

function setRadLevel(player as IPlayer, value as double) {
    gRadiationData[player.name] = value;
}

function addRadLevel(player as IPlayer, increment as double) {
    val new as double = gRadiationData[player.name] + increment;
    gRadiationData[player.name] = new;
    if (gRadiationData[player.name] < 0.0) {
        gRadiationData[player.name] = 0.0;
    }
}


# Load/Save radiation_level.
# Use players NTB to make data persistent
function loadRadFromPlayerNBT(player as IPlayer) {
    val loaded_data = player.getNBT().ForgeData.radiation_level as IData;
    if (isNull(loaded_data)) {
        gRadiationData[player.name] = 0.0;
    } else {
        gRadiationData[player.name] = loaded_data.asDouble();
    }
}

function saveRadToPlayerNBT(player as IPlayer) {
    val data_to_save = {radiation_level: gRadiationData[player.name] as double} as IData;
    player.setNBT(data_to_save);
}


# Diminishing function. Radiation level is slowly reduced over time naturally
# Process speed can be increased while anti-rad meds are in effect
# Natural regeneration and meds should work even while player is exposed to active radiation source
# DEFAULT VALUE: -0.1
function radDiminishing(player as IPlayer) {
    var diminish_value as double = -0.1;

    # Techguns Rad resistance buff
    for p in player.activePotionEffects {
        if (p.effectName.matches("techguns.radregeneration")) {
            diminish_value -= p.amplifier + 1;
        }
    }
    addRadLevel(player, diminish_value);
}


# TODO:
# Block radiation



# TODO: Move into separate action during counting dose size (not as a part of addRadiationEffect)
# Retrieving effective protection value of players equiped armor
function getEffectiveRadProtection(player as IPlayer) as int{    
    var final_prot as double = 0.0;
    var buff_prot as int = 0;
    
    # Armor protection
    for key in radProtectionArmor.keys {
        if !(isNull(player.getInventoryStack(36))) {
            if (player.getInventoryStack(36).definition.id).matches(key.definition.id) {
                final_prot += radProtectionArmor[key];
            }
        }
        if !(isNull(player.getInventoryStack(37))) {
            if (player.getInventoryStack(37).definition.id).matches(key.definition.id) {
                final_prot += radProtectionArmor[key];
            }
        }
        if !(isNull(player.getInventoryStack(38))) {
            if (player.getInventoryStack(38).definition.id).matches(key.definition.id) {
                final_prot += radProtectionArmor[key];
            }
        }
        if !(isNull(player.getInventoryStack(39))) {
            if (player.getInventoryStack(39).definition.id).matches(key.definition.id) {
                final_prot += radProtectionArmor[key];
            }
        }
    }
    
    # Techguns Rad resistance buff
    for p in player.activePotionEffects {
        if (p.effectName.matches("techguns.radresistance")) {
            buff_prot += p.amplifier + 1;
        }
    }
    return (final_prot as IData).asInt() + buff_prot;
}


# default_duration should be around 300 -> seems like the value is in ticks, 300 is cca. 15 secs (20tcs/sec)
# intensity is number in range 1-4
function addRadiationEffect(intensity as int, player as IPlayer) {
    
    var default_duration as int = 300;
    var protection as int = getEffectiveRadProtection(player);
    
    if (protection < intensity) {
        # dose can reach 1-4 (never 0 or negative)
        var dose = intensity - protection;
        var amp = 0;
        var resistance = 0;
        var dur = 99999;
        
        if (player.activePotionEffects.length == 0) {
            player.addPotionEffect(<potion:techguns:radiation>.makePotionEffect(default_duration, dose - 1));
        }
        else {
            for p in player.activePotionEffects {
                if (p.effectName.matches("techguns.radiation")) {
                    amp = p.amplifier + dose;
                    dur = p.duration;
                }
            }
            if (dur <= 2) {
                if (amp < 3) {
                    player.removePotionEffect(<potion:techguns:radiation>);
                    player.addPotionEffect(<potion:techguns:radiation>.makePotionEffect(default_duration, amp));    
                } else {
                    player.removePotionEffect(<potion:techguns:radiation>);
                    player.addPotionEffect(<potion:techguns:radiation>.makePotionEffect(default_duration, 3));
                }
            }
        }
    }
}


# Add debufs based on radiation level
# TODO: Check if it's possible to use event to send message. This solution fires message every tick.
#       Set potion effect to persist at least a few second. Similar problem -> effect is fired to fast, poison don't have enough time to tick.
function setRadiationDebufs(player as IPlayer) {
    if (gRadiationData[player.name] > 0) {
        player.removePotionEffect(<potion:techguns:radiation>);
        player.addPotionEffect(<potion:techguns:radiation>.makePotionEffect(60, 0));
        player.sendStatusMessage("You are slightly irradiated.");
    }
    if (gRadiationData[player.name] >= 300) {
        player.removePotionEffect(<potion:techguns:radiation>);
        player.addPotionEffect(<potion:techguns:radiation>.makePotionEffect(60, 1));
        player.addPotionEffect(<potion:minecraft:slowness>.makePotionEffect(60, 0));
        player.addPotionEffect(<potion:minecraft:weakness>.makePotionEffect(60, 0));
        player.sendStatusMessage("Your radiation level is to high!");
    }
    if (gRadiationData[player.name] >= 700) {
        player.removePotionEffect(<potion:techguns:radiation>);
        player.addPotionEffect(<potion:techguns:radiation>.makePotionEffect(60, 2));
        player.addPotionEffect(<potion:minecraft:blindness>.makePotionEffect(60, 0));
        player.sendStatusMessage("Your radiation level reached dangerous values.");
    }
    if (gRadiationData[player.name] >= 1200) {
        player.removePotionEffect(<potion:techguns:radiation>);
        player.addPotionEffect(<potion:techguns:radiation>.makePotionEffect(60, 3));
        player.addPotionEffect(<potion:minecraft:poison>.makePotionEffect(60, 0));
        player.sendStatusMessage("Warning! Lethal radiation level reached!");
    }
}


# Add debufs based on radiation level - old debuf for reference
function old_setRadiationDebufs(player as IPlayer) {
    for p in player.activePotionEffects {
        if (p.effectName.matches("techguns.radiation")) {
            if (p.amplifier >= 0) {
                player.addPotionEffect(<potion:minecraft:slowness>.makePotionEffect(60, 1));
            }
            if (p.amplifier >= 1) {
                player.addPotionEffect(<potion:minecraft:blindness>.makePotionEffect(60, 1));
            }
            if (p.amplifier >= 2) {
                player.addPotionEffect(<potion:minecraft:weakness>.makePotionEffect(60, 1));
            }
            if (p.amplifier >= 3) {
                player.addPotionEffect(<potion:minecraft:poison>.makePotionEffect(60, 1));
            }
        }
    }
}
