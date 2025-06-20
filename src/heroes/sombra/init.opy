
#!mainFile "../../main.opy"

playervar Sombra_invisible
playervar Sombra_invis_damage
playervar Sombra_hud
playervar Sombra_targeting_hud
playervar Sombra_virus_target
playervar Sombra_healing_ring
playervar Sombra_virus_confirmed
playervar Sombra_hack_effect
playervar Sombra_hack_icon
playervar stealth_timer
playervar stealth_pvar

#!include "heroes/sombra/hack.opy"
#!include "heroes/sombra/virus.opy"
#!include "heroes/sombra/heal.opy"
#!include "heroes/sombra/translocator.opy"
#!include "heroes/sombra/stealth.opy"
#!include "heroes/sombra/opportunist.opy"
#!include "heroes/sombra/emp.opy"

def initSombra():
    @Name "[sombra/init.opy]: initSombra()"
    
    eventPlayer.ult_charge_pvar[1] = 2800
    eventPlayer._base_damage_scalar = 0.875
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer.Sombra_invisible = false
    createInWorldText(eventPlayer, "{0} {1}".format(len([player for player in getLivingPlayers(eventPlayer.getTeam()) if distance(eventPlayer, player) <= 15 and isInLoS(eventPlayer, player, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) == true and player.getHero() != Hero.SOMBRA]), iconString(Icon.PLUS)), updateEveryFrame(eventPlayer.getEyePosition() + (100 * (0 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + (-0.3 * (directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 * eventPlayer.getFacingDirection()))), 1.8)
    eventPlayer.Sombra_hud = getLastCreatedText()
    eventPlayer.hero_initialized = true


rule "[sombra/init.opy]: Increase Sombra melee damage":
    @Event playerDealtDamage
    @Hero sombra
    @Condition eventAbility == Button.MELEE
    
    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar - eventDamage) / eventPlayer._base_damage_scalar)


rule "[sombra/init.opy]: Clean up Sombra":
    @Event eachPlayer
    @Condition eventPlayer.hero_setup != Hero.SOMBRA
    
    eventPlayer.Sombra_virus_target = null
    destroyInWorldText(eventPlayer.Sombra_targeting_hud)
    destroyEffect(eventPlayer.Sombra_healing_ring)
    destroyInWorldText(eventPlayer.Sombra_hud)
    destroyHudText(eventPlayer.Explaination_Hud[3])
