import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.event.PlayerLoggedInEvent;
import crafttweaker.event.PlayerLoggedOutEvent;
import crafttweaker.event.PlayerRespawnEvent;
import crafttweaker.event.PlayerSetSpawnEvent;
import crafttweaker.event.PlayerTickEvent;
import crafttweaker.events.IEventManager;
import crafttweaker.player.IPlayer;
import scripts.radiation.functions.playerRadiationEvent;
import scripts.radiation.functions.radiationPlayerHalveRadiationEvent;
import scripts.radiation.functions.radiationPlayerLoggedInEvent;
import scripts.radiation.functions.radiationPlayerLoggedOutEvent;
import scripts.radiation.functions.radiationPlayerRemoveRadiationEvent;


val effectOnDeath as bool = true;
val effectOnSleep as bool = true;

# Player events
events.onPlayerLoggedIn(function(event as PlayerLoggedInEvent) {
	radiationPlayerLoggedInEvent(event.player);
});

events.onPlayerLoggedOut(function(event as PlayerLoggedOutEvent) {
	radiationPlayerLoggedOutEvent(event.player);
});

events.onPlayerTick(function(event as PlayerTickEvent) {
	
	if (event.phase == "START") {
		playerRadiationEvent(event.player);
	}
});

events.onPlayerRespawn(function(event as PlayerRespawnEvent) {
	if (!event.endConquered && effectOnDeath) {
		radiationPlayerRemoveRadiationEvent(event.player);
		// radiationPlayerHalveRadiation(event.player);
	}
});

events.onPlayerSetSpawn(function(event as PlayerSetSpawnEvent) {
	if (!event.isForced && effectOnSleep) {
		//radiationPlayerRemoveRadiation(event.player);
		radiationPlayerHalveRadiationEvent(event.player);
	}
});
