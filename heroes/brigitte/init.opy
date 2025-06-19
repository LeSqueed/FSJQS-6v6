#!include "heroes/brigitte/bash.opy"
#!include "heroes/brigitte/inspire.opy"
#!include "heroes/brigitte/repair_pack.opy"

def initBrigitte():
    @Name "[brigitte/init.opy]: initBrigitte()"
    
    eventPlayer.custom_hp_pvar[0] = 15
    eventPlayer.custom_hp_pvar[1] = 10
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2625
    eventPlayer.macro_pvar[0] = 0.778
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.macro_pvar[1] = 0.8
    eventPlayer.setHealingDealt(100 * eventPlayer.macro_pvar[1])
    eventPlayer.hero_initialized = true

rule "[brigitte/init.opy]: Correct Whipshot damage":
    @Event playerDealtDamage
    @Hero brigitte
    @Condition eventAbility == Button.ABILITY_1
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])
