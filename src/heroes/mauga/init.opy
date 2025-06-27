#!mainFile "../../main.opy"

playervar mauga_cardiac_target
playervar Mauga_Overdrive_Health
playervar Cardiac_overdrive_active

#!include "cardiac.opy"
#!include "cage.opy"
#!include "overrun.opy"

def initMauga():
    @Name "[mauga/init.opy]: initMauga()"
    
    eventPlayer.custom_hp_pvar[0] = 21
    eventPlayer.custom_hp_pvar[1] = 25
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2650
    removeTankPassive()
    eventPlayer._base_damage_scalar = 0.75
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer.balance_change_check = false
    eventPlayer._max_health_scalar = HeroHealthPercentage.MAUGA / 100
    eventPlayer.hero_initialized = true

rule "[mauga/init.opy]: Increase Mauga melee damage":
    @Event playerDealtDamage
    @Hero mauga
    @Condition eventAbility in [Button.MELEE] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar - eventDamage) / eventPlayer._base_damage_scalar)
