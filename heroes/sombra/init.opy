
#!include "heroes/sombra/hack.opy"
#!include "heroes/sombra/virus.opy"
#!include "heroes/sombra/heal.opy"
#!include "heroes/sombra/translocator.opy"
#!include "heroes/sombra/stealth.opy"
#!include "heroes/sombra/opportunist.opy"
#!include "heroes/sombra/emp.opy"

def initSombra():
    @Name "[sombra/init.opy]: initSombra()"
    
    #eventPlayer.custom_hp_pvar[0] = 200
    #eventPlayer.custom_hp_pvar[1] = null
    #eventPlayer.custom_hp_pvar[2] = null
    #applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2800
    eventPlayer.macro_pvar[0] = 0.875
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.Sombra_invisible = false
    createInWorldText(eventPlayer, "{0} {1}".format(len([player for player in getLivingPlayers(eventPlayer.getTeam()) if distance(eventPlayer, player) <= 15 and isInLoS(eventPlayer, player, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) == true and player.getHero() != Hero.SOMBRA]), iconString(Icon.PLUS)), updateEveryFrame(eventPlayer.getEyePosition() + (100 * (0 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + (-0.3 * (directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 * eventPlayer.getFacingDirection()))), 1.8)
    eventPlayer.Sombra_hud = getLastCreatedText()
    eventPlayer.hero_initialized = true


rule "[sombra/init.opy]: Increase Sombra melee damage":
    @Event playerDealtDamage
    @Hero sombra
    @Condition eventAbility == Button.MELEE
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[sombra/init.opy]: Clean up Sombra":
    @Event eachPlayer
    @Condition eventPlayer.hero_setup != Hero.SOMBRA
    
    eventPlayer.Sombra_virus_target = null
    destroyInWorldText(eventPlayer.Sombra_targeting_hud)
    destroyEffect(eventPlayer.Sombra_healing_ring)
    destroyInWorldText(eventPlayer.Sombra_hud)
    destroyHudText(eventPlayer.Explaination_Hud[3])
