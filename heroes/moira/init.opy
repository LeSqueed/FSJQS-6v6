#!include "heroes/moira/coalescence.opy"

def initMoira():
    @Name "[moira/init.opy]: initMoira()"
    
    #eventPlayer.custom_hp_pvar[0] = 200
    #eventPlayer.custom_hp_pvar[1] = 0
    #eventPlayer.custom_hp_pvar[2] = 0
    #applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2800
    eventPlayer.macro_pvar[0] = 0.923
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.hero_initialized = true

rule "[moira/init.opy]: Increase Moira other forms of damage":
    @Event playerDealtDamage
    @Hero moira
    @Condition eventPlayer.isUsingUltimate() == false
    @Condition eventAbility in [Button.MELEE, Button.ABILITY_2] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])