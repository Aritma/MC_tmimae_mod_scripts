import crafttweaker.events.IEventManager;
import crafttweaker.event.PlayerTickEvent;
import crafttweaker.player.IPlayer;
import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.data.IData;
import scripts.radiation.functions.playerRadiationEvent;

# Player event
events.onPlayerTick(function (event as PlayerTickEvent) {
	
	if (event.phase == "START") {
		playerRadiationEvent(event.player);
	}
});