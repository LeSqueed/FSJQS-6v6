#!include "heroes/hazard/spike_guard.opy"
#!include "heroes/hazard/violent_leap.opy"
#!include "heroes/hazard/downpour.opy"

def initHazard():
    @Name "[hazard/init.opy]: initHazard()"
    
    eventPlayer.custom_hp_pvar[0] = 116
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2000
    eventPlayer.macro_pvar[0] = 0.8
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.setAbility2Enabled(false)
    eventPlayer.hero_initialized = true


rule "[hazard/init.opy]: Increase Hazard melee, wall, ultimate damage":
    @Event playerDealtDamage
    @Hero hazard
    @Condition eventAbility in [Button.ABILITY_2, Button.ULTIMATE, Button.MELEE] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])
