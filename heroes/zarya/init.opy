#!include "heroes/zarya/self_bubble.opy"
#!include "heroes/zarya/ally_bubble.opy"

def initZarya():
    @Name "[zarya/init.opy]: initZarya()"
    
    #eventPlayer.custom_hp_pvar[0] = 200
    #eventPlayer.custom_hp_pvar[1] = 0
    #eventPlayer.custom_hp_pvar[2] = 200
    #applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2100
    removeTankPassive()
    eventPlayer.self_bubble_cooldown = 0
    eventPlayer.ally_bubble_cooldown = 0
    eventPlayer.macro_pvar[0] = 0.895
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.max_health_scaler = 1
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
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] * 0.909 - eventDamage) / eventPlayer.macro_pvar[0])


rule "[zarya/init.opy]: Correct Zarya Melee damage":
    @Event playerDealtDamage
    @Hero zarya
    @Condition eventAbility == Button.MELEE
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])