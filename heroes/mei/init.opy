#!include "heroes/mei/endothermic.opy"
#!include "heroes/mei/wall.opy"
#!include "heroes/mei/cryo_freeze.opy"

def initMei():
    @Name "[mei/init.opy]: initMei()"
    
    eventPlayer.custom_hp_pvar[0] = 10
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1610
    eventPlayer.macro_pvar[0] = 0.882
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.max_health_scaler = 0.8
    eventPlayer.hero_initialized = true


def initMei():
    @Name "[mei/init.opy]: Initialize Mei TANK"
    @Disabled
    
    eventPlayer.custom_hp_pvar[0] = 70
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2800
    eventPlayer.macro_pvar[0] = 0.66
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.startScalingSize(1.15)
    eventPlayer.hero_initialized = true
    eventPlayer.max_health_scaler = 1.1


rule "[mei/init.opy]: Reduce Headshot damage taken Mei":
    @Event playerTookDamage
    @Hero mei
    @Condition eventWasCriticalHit == true
    
    heal(eventPlayer, null, eventDamage * 0.3)

rule "[mei/init.opy]: Increase Mei other forms of damage":
    @Event playerDealtDamage
    @Hero mei
    @Condition eventAbility in [Button.PRIMARY_FIRE, Button.MELEE] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])

