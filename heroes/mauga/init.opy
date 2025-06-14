#!include "heroes/mauga/cardiac.opy"
#!include "heroes/mauga/cage.opy"

def initMauga():
    @Name "[mauga/init.opy]: initMauga()"
    
    eventPlayer.custom_hp_pvar[0] = 21
    eventPlayer.custom_hp_pvar[1] = 50
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2650
    removeTankPassive()
    eventPlayer.macro_pvar[0] = 0.75
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.balance_change_check = false
    eventPlayer.hero_initialized = true

rule "[mauga/init.opy]: Increase Mauga melee damage":
    @Event playerDealtDamage
    @Hero mauga
    @Condition eventAbility in [Button.MELEE] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])
