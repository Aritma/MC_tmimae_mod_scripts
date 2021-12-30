# REQUIRE:
# - Techguns
# - Scannable
# - EnderIO

# Modification of Scannable recipes to use Techguns materials and Fabricator recipes
# Such change increase difficulty of scan creation
# Key materials for scannable modules are picked from vanilla minecraft items

import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import mods.techguns.Fabricator;


# Remove Scannable item recipes and move them into the fabricator or add new
recipes.removeByMod("scannable");


# TG item definitions
val tg_circuit_board as IItemStack = <techguns:itemshared:65>;
val tg_batery_full as IItemStack = <techguns:itemshared:29>;
val tg_batery_empty as IItemStack = <techguns:itemshared:30>;
val tg_gold_wire as IItemStack = <techguns:itemshared:63>;
val tg_plastic as IItemStack = <techguns:itemshared:55>;


# Scanner recipes with TG materials
recipes.addShaped("ScannableScannerEmpty", <scannable:scanner>,
 [[null,<minecraft:iron_bars>,null],
  [tg_plastic,tg_batery_empty,tg_plastic],
  [tg_gold_wire,tg_circuit_board,tg_gold_wire]]);

recipes.addShaped("ScannableScannerFull", <scannable:scanner>.withTag({energy: 5000}),
 [[null,<minecraft:iron_bars>,null],
  [tg_plastic,tg_batery_full,tg_plastic],
  [tg_gold_wire,tg_circuit_board,tg_gold_wire]]);


# Fabricator scannable module recipes
# Blank module as a base
Fabricator.addRecipe(tg_circuit_board, 1, tg_gold_wire, 1, <minecraft:quartz>, 4, <enderio:item_basic_capacitor:0>, 1, <scannable:module_blank>);

# Specific modules from blank
Fabricator.addRecipe(<scannable:module_blank>, 1, <minecraft:gold_nugget>, 4, <minecraft:redstone>, 4, <minecraft:ender_pearl>, 4, <scannable:module_range>);
Fabricator.addRecipe(<scannable:module_blank>, 1, <minecraft:gold_nugget>, 4, <minecraft:redstone>, 4, <minecraft:spider_eye>, 4, <scannable:module_animal>);
Fabricator.addRecipe(<scannable:module_blank>, 1, <minecraft:gold_nugget>, 4, <minecraft:redstone>, 4, <minecraft:skull>, 1, <scannable:module_monster>);
Fabricator.addRecipe(<scannable:module_blank>, 1, <minecraft:gold_nugget>, 4, <minecraft:redstone>, 4, <minecraft:coal>, 1, <scannable:module_ore_common>);
Fabricator.addRecipe(<scannable:module_blank>, 1, <minecraft:gold_nugget>, 4, <minecraft:redstone>, 4, <minecraft:diamond>, 1, <scannable:module_ore_rare>);
Fabricator.addRecipe(<scannable:module_blank>, 1, <minecraft:gold_nugget>, 4, <minecraft:redstone>, 4, <minecraft:emerald>, 1, <scannable:module_block>);
Fabricator.addRecipe(<scannable:module_blank>, 1, <minecraft:gold_nugget>, 4, <minecraft:redstone>, 4, <minecraft:compass>, 1, <scannable:module_structure>);
Fabricator.addRecipe(<scannable:module_blank>, 1, <minecraft:gold_nugget>, 4, <minecraft:redstone>, 4, <minecraft:iron_bars>, 1, <scannable:module_fluid>);
Fabricator.addRecipe(<scannable:module_blank>, 1, <minecraft:gold_nugget>, 4, <minecraft:redstone>, 4, <minecraft:book>, 1, <scannable:module_entity>);