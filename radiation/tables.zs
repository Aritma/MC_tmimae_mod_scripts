#priority 600

# PRIORITY_ORDER: tables.zs -> functions.zs
# REQUIRE:
# - Techguns

import crafttweaker.item.IItemStack;
import crafttweaker.potions.IPotion;
import mods.jei.JEI;


# Because of typing java errors all values have to be stored as an integer and as a string
static radioactiveItems as double[IItemStack] = {	
	<minecraft:iron_ingot:0> : 0.2,
	<minecraft:gold_ingot:0> : 1.0,
    <minecraft:rotten_flesh:0> : 1.5,
    <techguns:itemshared:98> : 4.0 //TG enriched uranium
};
 
 
# Item descriptions in format <item> : [tooltip, jei desc.]
static radioactiveItemDescriptions as string[][IItemStack] = {	
	<minecraft:iron_ingot:0> : ["Rad.Intensity: 0.2", "Somehow radioactive iron..."],
	<minecraft:gold_ingot:0> : ["Rad.Intensity: 1.0", "Gold cursed by gods of plutonium."],
    <minecraft:rotten_flesh:0> : ["Rad.Intensity: 3.0", "Piece of very irradiated corpse."],
    <techguns:itemshared:98> : ["Rad.Intensity: 4.0", "Block of a very clean enriched uranium for use in nuclear weapons."] //TG enriched uranium
};


# List of radioation healing items
static radiationHealing as IItemStack[] = [
    <techguns:radaway>
];


# Techguns protection items definitions, because CT cannot read protection values of techguns
static radProtectionArmor as double[IItemStack] = {
    <techguns:steam_helmet> : 0.50,
    <techguns:steam_chestplate> : 0.50,
    <techguns:steam_leggings> : 0.50,
    <techguns:steam_boots> : 0.50,
    <techguns:hazmat_helmet> : 1.00,
    <techguns:hazmat_chestplate> : 1.00,
    <techguns:hazmat_leggings> : 1.00,
    <techguns:hazmat_boots> : 1.00,
    <techguns:t2_commando_helmet> : 0.25,
    <techguns:t2_commando_chestplate> : 0.25,
    <techguns:t2_commando_leggings> : 0.25,
    <techguns:t2_commando_boots> : 0.25,
    <techguns:t2_riot_helmet> : 0.50,
    <techguns:t2_riot_chestplate> : 0.50,
    <techguns:t2_riot_leggings> : 0.50,
    <techguns:t2_riot_boots> : 0.50,
    <techguns:t3_combat_helmet> : 0.25,
    <techguns:t3_combat_chestplate> : 0.25,
    <techguns:t3_combat_leggings> : 0.25,
    <techguns:t3_combat_boots> : 0.25,
    <techguns:t3_power_helmet> : 0.75,
    <techguns:t3_power_chestplate> : 0.75,
    <techguns:t3_power_leggings> : 0.75,
    <techguns:t3_power_boots> : 0.75,
    <techguns:t3_miner_helmet> : 1.00,
    <techguns:t3_miner_chestplate> : 1.00,
    <techguns:t3_miner_leggings> : 1.00,
    <techguns:t3_miner_boots> : 1.00,
    <techguns:t3_exo_helmet> : 0.50,
    <techguns:t3_exo_chestplate> : 0.50,
    <techguns:t3_exo_leggings> : 0.50,
    <techguns:t3_exo_boots> : 0.50,
    <techguns:t4_praetor_helmet> : 1.00,
    <techguns:t4_praetor_chestplate> : 1.00,
    <techguns:t4_praetor_leggings> : 1.00,
    <techguns:t4_praetor_boots> : 1.00,
    <techguns:t4_power_helmet> : 1.25,
    <techguns:t4_power_chestplate> : 1.25,
    <techguns:t4_power_leggings> : 1.25,
    <techguns:t4_power_boots> : 1.25
};


# Add descriptions to items
for key in radioactiveItemDescriptions.keys {
    var rads as string[] = radioactiveItemDescriptions[key];
    JEI.addDescription(key, rads);
    key.addTooltip(format.red(rads[0]));
}


# Adding note to gasmask, that radresist is fake (because there is no way to modify it now)
JEI.addDescription(<techguns:gasmask>, "Unfortunately, this mask doesn't provide any radiation protection, even though the manufacturer declares it in included manual.");
<techguns:gasmask>.addTooltip(format.red("Radiation protection is not working."));


# TODO: Set healing items for radiation effect
# It's not possible to add additional curative items for existing effect.
# Instead we add radregen to items (if not exists)
# Each tick of radregen remove any existing radiation effect
for item in radiationHealing {
    val TODO as string = "TODO"; 
}
