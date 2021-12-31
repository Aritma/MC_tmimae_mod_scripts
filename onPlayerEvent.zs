import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.event.PlayerTickEvent;
import crafttweaker.event.PlayerLoggedInEvent;
import crafttweaker.event.PlayerLoggedOutEvent;
import crafttweaker.events.IEventManager;
import crafttweaker.player.IPlayer;
import scripts.radiation.functions.playerRadiationEvent;
import scripts.radiation.functions.radiationPlayerLoggedInEvent;
import scripts.radiation.functions.radiationPlayerLoggedOutEvent;

# Player events
events.onPlayerLoggedIn(function(event as PlayerLoggedInEvent) {
	radiationPlayerLoggedInEvent(event.player);
});

events.onPlayerLoggedOut(function(event as PlayerLoggedOutEvent) {
	radiationPlayerLoggedOutEvent(event.player);
});

events.onPlayerTick(function (event as PlayerTickEvent) {
	
	if (event.phase == "START") {
		playerRadiationEvent(event.player);
	}
});