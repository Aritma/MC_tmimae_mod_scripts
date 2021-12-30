import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.event.PlayerTickEvent;
import crafttweaker.events.IEventManager;
import crafttweaker.player.IPlayer;
import scripts.radiation.functions.playerRadiationEvent;

# Player event
events.onPlayerTick(function (event as PlayerTickEvent) {
	
	if (event.phase == "START") {
		playerRadiationEvent(event.player);
	}
});