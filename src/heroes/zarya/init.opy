#!mainFile "../../main.opy"

playervar self_bubble_cooldown
playervar ally_bubble_cooldown

#!include "self_bubble.opy"
#!include "ally_bubble.opy"

def initZarya():
    @Name "[zarya/init.opy]: initZarya()"
    
    eventPlayer.ult_charge_pvar[1] = 2100
    removeTankPassive()
    eventPlayer.self_bubble_cooldown = 0
    eventPlayer.ally_bubble_cooldown = 0
    eventPlayer._base_damage_scalar = 0.895
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer._max_health_scalar = HeroHealthPercentage.ZARYA / 100
    eventPlayer.hero_initialized = true

rule "[zarya/init.opy]: Clean up Zarya":
    @Event eachPlayer
    @Condition eventPlayer.hero_setup != Hero.ZARYA
    
    hideSelfBubbleCD()
    hideAllyBubbleCD()


rule "[zarya/init.opy]: Increase Particle Cannon alternate fire damage":
    @Event playerDealtDamage
    @Hero zarya
    @Condition eventAbility == Button.SECONDARY_FIRE
    
    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar * 0.909 - eventDamage) / eventPlayer._base_damage_scalar)


rule "[zarya/init.opy]: Correct Zarya Melee damage":
    @Event playerDealtDamage
    @Hero zarya
    @Condition eventAbility == Button.MELEE
    
    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar - eventDamage) / eventPlayer._base_damage_scalar)