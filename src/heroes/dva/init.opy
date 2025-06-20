#!mainFile "../../main.opy"

playervar self_destruct_charge

#!include "boosters.opy"
#!include "hp.opy"
#!include "defense_matrix.opy"

def initDva():
    @Name "[dva/init.opy]: initDva()"
    
    eventPlayer.ult_charge_pvar[1] = 1540
    removeTankPassive()
    eventPlayer._base_damage_scalar = 0.91
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer.self_destruct_charge = 0
    eventPlayer.max_health_scaler = 0.857
    waitUntil(not eventPlayer.isInAlternateForm(), 999999986991104)
    eventPlayer.custom_hp_pvar[0] = 169
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.hero_initialized = true

rule "[dva/init.opy]: Reduce Micro Missiles damage":
    @Event playerDealtDamage
    @Hero dva
    @Condition eventAbility == Button.ABILITY_2
    
    heal(victim, null, eventDamage - 0.75 * eventDamage / eventPlayer._base_damage_scalar)


rule "[dva/init.opy]: Increase D.va other forms of damage":
    @Event playerDealtDamage
    @Hero dva
    @Condition eventAbility in [Button.MELEE, Button.ULTIMATE] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar - eventDamage) / eventPlayer._base_damage_scalar)


rule "[dva/init.opy]: Force reset ult charge when DVa exits Mech":
    @Event eachPlayer
    @Hero dva
    @Condition eventPlayer.isInAlternateForm() == true
    
    if eventPlayer.isUsingUltimate():
        return
    eventPlayer.setUltCharge(0)
