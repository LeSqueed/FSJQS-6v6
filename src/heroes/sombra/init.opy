
#!mainFile "../../main.opy"

playervar Sombra_invisible
playervar Sombra_invis_damage
playervar Sombra_virus_target
playervar Sombra_healing_ring
playervar Sombra_virus_confirmed
playervar Sombra_hack_icon
playervar stealth_timer
playervar stealth_pvar

#!include "hack.opy"
#!include "virus.opy"
#!include "heal.opy"
#!include "translocator.opy"
#!include "stealth.opy"
#!include "opportunist.opy"
#!include "emp.opy"

def initSombra():
    @Name "[sombra/init.opy]: initSombra()"
    
    eventPlayer.custom_hp_pvar[0] = 0
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 100
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2800
    eventPlayer._base_damage_scalar = 0.875
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer.Sombra_invisible = false
    createInWorldText(eventPlayer, "{0} {1}".format(len([player for player in getLivingPlayers(eventPlayer.getTeam()) if distance(eventPlayer, player) <= 15 and isInLoS(eventPlayer, player, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) == true and player.getHero() != Hero.SOMBRA]), iconString(Icon.PLUS)), updateEveryFrame(eventPlayer.getEyePosition() + (100 * (0 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + (-0.3 * (directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 * eventPlayer.getFacingDirection()))), 1.8)
    eventPlayer._sombra_healing_radius_targets_text = getLastCreatedText()
    eventPlayer._max_health_scalar = HeroHealthPercentage.SOMBRA / 100
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
    destroyInWorldText(eventPlayer._sombra_virus_target_hud)
    destroyEffect(eventPlayer.Sombra_healing_ring)
    destroyInWorldText(eventPlayer._sombra_healing_radius_targets_text)
