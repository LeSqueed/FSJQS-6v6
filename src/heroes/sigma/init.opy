#!mainFile "../../main.opy"

playervar hp_exiting_grasp

#!include "kinetic_grasp.opy"

def initSigma():
    @Name "[sigma/init.opy]: initSigma()"
    
    eventPlayer.custom_hp_pvar[0] = 3.6
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 14.325
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2275
    removeTankPassive()
    eventPlayer._base_damage_scalar = 0.75
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer.balance_change_check = 0
    eventPlayer.hero_initialized = true


rule "[sigma/init.opy]: Reduce Accretion stun duration":
    @Event playerDealtDamage
    @Hero sigma
    @Condition victim.hasStatus(Status.KNOCKED_DOWN) == true
    
    wait(0.5)
    victim.clearStatusEffect(Status.KNOCKED_DOWN)


rule "[sigma/init.opy]: Increase Sigma other forms of damage":
    @Event playerDealtDamage
    @Hero sigma
    @Condition eventAbility in [Button.MELEE, Button.PRIMARY_FIRE] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar - eventDamage) / eventPlayer._base_damage_scalar)


rule "[sigma/init.opy]: Increase Gravitic Flux damage":
    @Event eachPlayer
    @Hero sigma
    @Condition eventPlayer.isUsingUltimate() == true
    
    eventPlayer.setDamageDealt(100)
    waitUntil(eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) or not eventPlayer.isUsingUltimate(), 10)
    wait(1.7)
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
