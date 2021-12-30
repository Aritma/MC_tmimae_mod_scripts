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


# Player event. Should be run on onPlayerTick event
# TODO: Rework with getRadiation a setRadiation to better handle increase and diminishing
function playerRadiationEvent(player as IPlayer) {
    var inventorySize = player.inventorySize as int;
    var dose as int = 0;

    for key in radioactiveItems.keys {
        for j in 0 to inventorySize as int {
            if !(isNull(player.getInventoryStack(j))) {
                if ((player.getInventoryStack(j).definition.id).matches(key.definition.id)) {
                    if (radioactiveItems[key] > dose) {
                        dose = radioactiveItems[key] as int;
                    }
                }
            }
        }
    }
    if (dose >= 1) {
        addRadiationEffect(dose, player);
    }
    setRadiationDebufs(player);
    
    # TODO: Add rad effect slow removal if it exists but no dose is received
    #       Change split dose, reduced_dose and intensity variables
}



# TODO:
# Block radiation



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
function setRadiationDebufs(player as IPlayer) {
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
