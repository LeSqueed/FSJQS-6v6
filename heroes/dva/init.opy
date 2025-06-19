#!include "heroes/dva/boosters.opy"
#!include "heroes/dva/hp.opy"
#!include "heroes/dva/defense_matrix.opy"

def initDva():
    @Name "[dva/init.opy]: initDva()"
    
    #setCustomHp(
    #ADJ_DVA_HEALTH_DUPLICATE if eventPlayer.isDuplicatingAHero() or SETTING_ECHO_TANK_HP else ADJ_DVA_HEALTH,
    #ADJ_DVA_ARMOR_DUPLICATE if eventPlayer.isDuplicatingAHero() or SETTING_ECHO_TANK_HP else ADJ_DVA_ARMOR,
    #0)
    eventPlayer.ult_charge_pvar[1] = 1540
    removeTankPassive()
    eventPlayer.macro_pvar[0] = 0.91
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
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
    
    heal(victim, null, eventDamage - 0.75 * eventDamage / eventPlayer.macro_pvar[0])


rule "[dva/init.opy]: Increase D.va other forms of damage":
    @Event playerDealtDamage
    @Hero dva
    @Condition eventAbility in [Button.MELEE, Button.ULTIMATE] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[dva/init.opy]: Force reset ult charge when DVa exits Mech":
    @Event eachPlayer
    @Hero dva
    @Condition eventPlayer.isInAlternateForm() == true
    
    if eventPlayer.isUsingUltimate():
        return
    eventPlayer.setUltCharge(0)
