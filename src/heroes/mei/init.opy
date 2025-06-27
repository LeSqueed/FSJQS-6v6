#!mainFile "../../main.opy"

#!include "endothermic.opy"
#!include "wall.opy"
#!include "cryo_freeze.opy"

def initMei():
    @Name "[mei/init.opy]: initMei()"
    
    eventPlayer.custom_hp_pvar[0] = 10
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1610
    eventPlayer._base_damage_scalar = 0.882
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer._max_health_scalar = HeroHealthPercentage.MEI / 100
    eventPlayer.hero_initialized = true


def initMei():
    @Name "[mei/init.opy]: Initialize Mei TANK"
    @Disabled
    
    eventPlayer.custom_hp_pvar[0] = 70
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2800
    eventPlayer._base_damage_scalar = 0.66
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer.startScalingSize(1.15)
    eventPlayer.hero_initialized = true
    eventPlayer._max_health_scalar = 1.1


rule "[mei/init.opy]: Reduce Headshot damage taken Mei":
    @Event playerTookDamage
    @Hero mei
    @Condition eventWasCriticalHit == true
    
    heal(eventPlayer, null, eventDamage * 0.3)

rule "[mei/init.opy]: Increase Mei other forms of damage":
    @Event playerDealtDamage
    @Hero mei
    @Condition eventAbility in [Button.PRIMARY_FIRE, Button.MELEE] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar - eventDamage) / eventPlayer._base_damage_scalar)

