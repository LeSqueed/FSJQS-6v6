#!mainFile "../../main.opy"

#!include "heroes/moira/coalescence.opy"

def initMoira():
    @Name "[moira/init.opy]: initMoira()"
    
    eventPlayer.ult_charge_pvar[1] = 2800
    eventPlayer._base_damage_scalar = 0.923
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer.hero_initialized = true

rule "[moira/init.opy]: Increase Moira other forms of damage":
    @Event playerDealtDamage
    @Hero moira
    @Condition eventPlayer.isUsingUltimate() == false
    @Condition eventAbility in [Button.MELEE, Button.ABILITY_2] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar - eventDamage) / eventPlayer._base_damage_scalar)