#priority 500

# PRIORITY_ORDER: tables.zs -> functions.zs
# REQUIRE:
# - Techguns

# TODO:
# Block radiation

import crafttweaker.data.IData;
import crafttweaker.formatting.IFormattedText;
import crafttweaker.item.IItemStack;
import crafttweaker.player.IPlayer;
import crafttweaker.potions.IPotion;
import crafttweaker.potions.IPotionEffect;
import crafttweaker.potions.IPotionType;
import crafttweaker.text.IStyle;
import crafttweaker.text.ITextComponent;
import scripts.radiation.tables.potionEffectsByName;
import scripts.radiation.tables.radioactiveItems;
import scripts.radiation.tables.radEffects;
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
    var dose as double = calculateDose(player);
    var protection as double = getEffectiveRadProtection(player);
    dose -= protection;
    var rad_change as double = getRadRegen(player);
    

    // exposure
    if (dose > 0) {
        addRadLevel(player, dose as double);
        rad_change += dose; 
    }

    // regeneneration
    if (getRadLevel(player) > 0.0) {
        setRadiationDebufs(player);
        addRadLevel(player,  getRadRegen(player));
        // rad info message shows only if there is any relevant radiation
        displayRads(player, rad_change as double);
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


# Display players radiation level and change per tick on screen as a statusMessage
function displayRads(player as IPlayer, rad_change as double) {
        var change_prefix as string = '+';
        var change_int as int = rad_change as int;
        var change_decimal as int = ((rad_change - (change_int as double))*10) as int;
        var rad_short as string = "";

        for key in radEffects.keys {
            if (getRadLevel(player) >= key) {
                rad_short = "<" + (radEffects[key].str_repr as IData).asString() + ">";
            }
        }

        if (rad_change < 0) {
            change_prefix = '-';
            change_decimal = -change_decimal;
            change_int = -change_int;
        }

        val rad_display_msg as string = "RAD: " + (getRadLevel(player) as int) as string + " (" + change_prefix + change_int as string + "." + change_decimal as string + "/tck) " + rad_short;
        player.sendStatusMessage(format.green(rad_display_msg));            
}


# Calculation players dose based on items, protection and other factors
function calculateDose(player as IPlayer) as double {
    var inventorySize = player.inventorySize as int;
    var dose as double = 0.0;

    for key in radioactiveItems.keys {
        for j in 0 to inventorySize as int {
            if !(isNull(player.getInventoryStack(j))) {
                if ((player.getInventoryStack(j).definition.id).matches(key.definition.id) & player.getInventoryStack(j).metadata == key.metadata) {
                    val item_rads = radioactiveItems[key].radlevel as IData;
                    if ( item_rads.asDouble() > dose) {
                        dose = item_rads.asDouble();
                    }
                }
            }
        }
    }

    return dose as double;
}


# Regen function. Radiation level is slowly reduced over time naturally
# Regen speed can be increased with anti-rad meds
# Natural regeneration and meds should work even while player is exposed to active radiation source
# DEFAULT VALUE: -0.1
function getRadRegen(player as IPlayer) as double {
    var regen_value as double = -0.1;

    # Techguns Rad resistance buff
    for p in player.activePotionEffects {
        if (p.effectName.matches("techguns.radregeneration")) {
            regen_value -= p.amplifier + 1;
        }
    }
    return regen_value as double;
}


# Retrieving effective protection value of players equiped armor
function getEffectiveRadProtection(player as IPlayer) as double{    
    var final_prot as double = 0.0;
    var buff_prot as int = 0;
    val itemSlots as int[] = [36,37,38,39]; # vanilla armor
    
    # Armor protection
    for slotNum in itemSlots {
        for key in radProtectionArmor.keys {
            if !(isNull(player.getInventoryStack(slotNum))) {
                if (player.getInventoryStack(slotNum).definition.id).matches(key.definition.id) {
                    final_prot += radProtectionArmor[key];
                }
            }
        }
    }
    
    # Techguns Rad resistance buff
    for p in player.activePotionEffects {
        if (p.effectName.matches("techguns.radresistance")) {
            buff_prot += p.amplifier + 1;
        }
    }
    return final_prot + (buff_prot as IData).asDouble();
}


# Add or prolongs potion effect on player. Effect is refired only if previous similar effect is finishing it's duration
# Optional message can be provided to be sent to player
# duration should be around 300 -> seems like the value is in ticks, 300 is cca. 15 secs (20tcs/sec)
function addOrProlongPotionEffect(player as IPlayer, potion as IPotion, duration as int, amplifier as int) {
    var dur as int = 0;
    
    if (player.activePotionEffects.length == 0) {
        player.addPotionEffect(potion.makePotionEffect(duration, amplifier));
    }
    else {
        for p in player.activePotionEffects {
            if (p.effectName.matches(potion.name)) {
                dur = p.duration;
            }
        }
        if (dur <= 2) {
            player.removePotionEffect(potion);
            player.addPotionEffect(potion.makePotionEffect(duration, amplifier));
        }
    }
}


# Add debufs based on radiation level (stacking debufs)
# radiation with messages do not stack
# radiation duration is reduced to minimum to follow radlevel existence (still need some time to have correct ingame effects like sound.)
function setRadiationDebufs(player as IPlayer) {
    //val rad_limits as double[] = radEffects.keys;
    
    # default radiation - always use 4 values from array
    var amp as int = 0;
    for i, value in radEffects.keys {
        if (getRadLevel(player) > value) {
            amp = i;
        }
    }
    addOrProlongPotionEffect(player, <potion:techguns:radiation>, 60, amp);

    # additional effects
    for key, value in radEffects {
        if (getRadLevel(player) > key) {
            for potion in (value.potion_effects as IData).asList() {
                addOrProlongPotionEffect(
                    player,
                    potionEffectsByName[(potion.name as IData).asString()],
                    (potion.duration as IData).asInt(),
                    (potion.amplifier as IData).asInt()
                );
            }
        }
    }
}
