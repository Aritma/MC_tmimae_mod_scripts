// https://github.com/pWn3d1337/Techguns2/tree/master/src/main/java/techguns/plugins/crafttweaker

import mods.techguns.AmmoPress;
	// public static void addMetal1(IIngredient input)
	// public static void addMetal2(IIngredient input)
	// public static void addPowder(IIngredient input)
	// public static void removeMetal1(IIngredient input)
	// public static void removeMetal2(IIngredient input)
	// public static void removePowder(IIngredient input)
import mods.techguns.ArmorStats;
	// public static void setArmorStat(String armorname, String stat, float value)
	// public static void setArmorStat(String armorname, String stat, float powered, float unpowered)
	// public static void setMaterialArmorValue(String material, String damagetype, float amount)
import mods.techguns.BlastFurnace;
	// public static void addRecipe(String input1, int amount1, String input2, int amount2, IItemStack output, int power, int duration)
	// public static void addRecipe(IItemStack input1, String input2, int amount2, IItemStack output, int power, int duration)
	// public static void addRecipe(String input1, int amount1, IItemStack input2, IItemStack output, int power, int duration)
	// public static void addRecipe(IItemStack input1, IItemStack input2, IItemStack output, int power, int duration)
	// public static void removeRecipe(IItemStack output)
import mods.techguns.ChargingStation;
	// public static void addRecipe(IItemStack input, IItemStack output, int RFAmount)
	// public static void addRecipe(String input, IItemStack output, int RFAmount)
	// public static void removeRecipe(IItemStack input)
	// public static void removeRecipe(String input)
import mods.techguns.ChemLab;
	// public static void addRecipe(String input1,int amount1,String input2,int amount2, ILiquidStack fluidIn, boolean allowSwap, IItemStack output, ILiquidStack fluidOut, int rfTick){
	// public static void addRecipe(IItemStack input1,int amount1,String input2,int amount2, ILiquidStack fluidIn, boolean allowSwap, IItemStack output, ILiquidStack fluidOut, int rfTick)
	// public static void addRecipe(String input1,int amount1,IItemStack input2,int amount2, ILiquidStack fluidIn, boolean allowSwap, IItemStack output, ILiquidStack fluidOut, int rfTick)
	// public static void addRecipe(IItemStack input1,int amount1,IItemStack input2,int amount2, ILiquidStack fluidIn, boolean allowSwap, IItemStack output, ILiquidStack fluidOut, int rfTick)
	// public static void removeRecipe(IItemStack output, ILiquidStack fluidOut)
import mods.techguns.Fabricator;
	// public static void removeRecipe(IItemStack output)
	// public static void addRecipe(IItemStack input,int amount,IItemStack wire,int amount_wire, IItemStack powder, int amount_powder, IItemStack plate, int amount_plate, IItemStack output)
	// public static void addRecipe(IItemStack input,int amount,IItemStack wire,int amount_wire, IItemStack powder, int amount_powder, String plate, int amount_plate, IItemStack output)
	// public static void addRecipe(IItemStack input,int amount,IItemStack wire,int amount_wire, String powder, int amount_powder, IItemStack plate, int amount_plate, IItemStack output)
	// public static void addRecipe(IItemStack input,int amount,IItemStack wire,int amount_wire, String powder, int amount_powder, String plate, int amount_plate, IItemStack output)
	// public static void addRecipe(IItemStack input,int amount,String wire,int amount_wire, IItemStack powder, int amount_powder, IItemStack plate, int amount_plate, IItemStack output)
	// public static void addRecipe(IItemStack input,int amount,String wire,int amount_wire, IItemStack powder, int amount_powder, String plate, int amount_plate, IItemStack output)
	// public static void addRecipe(IItemStack input,int amount,String wire,int amount_wire, String powder, int amount_powder, IItemStack plate, int amount_plate, IItemStack output)
	// public static void addRecipe(IItemStack input,int amount,String wire,int amount_wire, String powder, int amount_powder, String plate, int amount_plate, IItemStack output)
	// public static void addRecipe(String input,int amount,IItemStack wire,int amount_wire, IItemStack powder, int amount_powder, IItemStack plate, int amount_plate, IItemStack output)
	// public static void addRecipe(String input,int amount,IItemStack wire,int amount_wire, IItemStack powder, int amount_powder, String plate, int amount_plate, IItemStack output)
	// public static void addRecipe(String input,int amount,IItemStack wire,int amount_wire, String powder, int amount_powder, IItemStack plate, int amount_plate, IItemStack output)
	// public static void addRecipe(String input,int amount,IItemStack wire,int amount_wire, String powder, int amount_powder, String plate, int amount_plate, IItemStack output)
	// public static void addRecipe(String input,int amount,String wire,int amount_wire, IItemStack powder, int amount_powder, IItemStack plate, int amount_plate, IItemStack output)
	// public static void addRecipe(String input,int amount,String wire,int amount_wire, IItemStack powder, int amount_powder, String plate, int amount_plate, IItemStack output)
	// public static void addRecipe(String input,int amount,String wire,int amount_wire, String powder, int amount_powder, IItemStack plate, int amount_plate, IItemStack output)
	// public static void addRecipe(String input,int amount,String wire,int amount_wire, String powder, int amount_powder, String plate, int amount_plate, IItemStack output)
import mods.techguns.Grinder;
	// public static void addRecipe(IItemStack input, IItemStack[] outputs)
	// public static void addRecipe(IItemStack input, IItemStack[] outputs, double[] chances)
	// public static void removeRecipe(IItemStack input)
import mods.techguns.GunStats;
	// public static void setWeaponStat(String weaponname, String fieldname, float value)
    //
    // public enum EnumGunStat {
	// * The damage dealt close range
	// DAMAGE,
	// * the damage dealt at far range
	// DAMAGE_MIN,
	// * distance (in blocks) when damage starts to drop, between START and END damage is linear interpolated between DAMAGE and DAMAGE_MIN
	// DAMAGE_DROP_START,
	// * distance (in blocks) when damage drop ends, targets farther away will take DAMAGE_MIN damage,
	// DAMAGE_DROP_END,
	// * how fast the projectile flies in blocks per tick
	// BULLET_SPEED,
	// * how far the projectile can fly before it gets deleted
	// BULLET_DISTANCE,
	// * Gravity strength of the projectile
	// GRAVITY,
	// * Mining speed, only has an effect on tools
	// MINING_SPEED,
	// * How much shots randomly divert
	// SPREAD;
import mods.techguns.MetalPress;
	// public static void addRecipe(IItemStack input1,IItemStack input2, IItemStack output, boolean allowSwap)
	// public static void addRecipe(String input1,IItemStack input2, IItemStack output, boolean allowSwap)
	// public static void addRecipe(IItemStack input1,String input2, IItemStack output, boolean allowSwap)
	// public static void addRecipe(String input1,String input2, IItemStack output, boolean allowSwap)
	// public static void removeRecipe(IItemStack output)
	// public static void removeRecipe(String input1,String input2, IItemStack output)
	// public static void removeRecipe(IItemStack input1,String input2, IItemStack output)
	// public static void removeRecipe(String input1,IItemStack input2, IItemStack output)
	// public static void removeRecipe(IItemStack input1,IItemStack input2, IItemStack output)
import mods.techguns.OreCluster;
	// public static void addOre(String clustertype, IItemStack ore, int weight)
	// public static void addFluid(String clustertype, ILiquidStack fluid, int weight)
	// public static void removeOre(String clustertype, IItemStack ore)
	// public static void removeFluid(String clustertype, ILiquidStack fluid)
import mods.techguns.ReactionChamber;
	// public static void addRecipe(String key, IItemStack input,ILiquidStack fluid, IItemStack[] outputs, IItemStack beamFocus, int ticks, int requiredCompletion,
			// int preferredIntensity, int intensityMargin, int liquidLevel, int liquidConsumption, float instability, String risk, int RFTick)
	// public static void addRecipe(String key,String input,ILiquidStack fluid, IItemStack[] outputs, IItemStack beamFocus, int ticks, int requiredCompletion,
			// int preferredIntensity, int intensityMargin, int liquidLevel, int liquidConsumption, float instability, String risk, int RFTick)
	// public static void addRecipe(String key,IItemStack input,ILiquidStack fluid, IItemStack output, IItemStack beamFocus, int ticks, int requiredCompletion,
			// int preferredIntensity, int intensityMargin, int liquidLevel, int liquidConsumption, float instability, String risk, int RFTick)
	// public static void addRecipe(String key, String input,ILiquidStack fluid, IItemStack output, IItemStack beamFocus, int ticks, int requiredCompletion,
			// int preferredIntensity, int intensityMargin, int liquidLevel, int liquidConsumption, float instability, String risk, int RFTick)
	// public static void removeRecipe(IItemStack input, ILiquidStack fluid)
	// public static void removeRecipe(String input, ILiquidStack fluid)