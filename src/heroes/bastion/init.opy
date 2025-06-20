#!mainFile "../../main.opy"

playervar Bastion_healing_id
playervar sentry_healing_id

#!include "reconfigure.opy"

def initBastion():
    @Name "[bastion/init.opy]: initBastion()"
    
    eventPlayer.custom_hp_pvar[0] = 50
    eventPlayer.custom_hp_pvar[1] = 5
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2300
    eventPlayer.startScalingSize(0.96)
    eventPlayer.hero_initialized = true

rule "[bastion/init.opy]: Reduce grenade self-damage":
    @Event playerDealtDamage
    @Hero bastion
    @Condition attacker == victim
    
    heal(victim, null, eventDamage - eventDamage * 0.5)


rule "[bastion/init.opy]: Clean up Bastion":
    @Event eachPlayer
    @Condition eventPlayer.hero_setup != Hero.BASTION
    
    stopHealingOverTime(eventPlayer.Bastion_healing_id)
    stopHealingOverTime(eventPlayer.sentry_healing_id)
