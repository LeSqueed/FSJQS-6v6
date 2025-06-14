#!include "heroes/kiriko/swift_step.opy"

def initKiriko():
    @Name "[kiriko/init.opy]: initKiriko()"
    
    #eventPlayer.custom_hp_pvar[0] = 0
    #eventPlayer.custom_hp_pvar[1] = 0
    #eventPlayer.custom_hp_pvar[2] = 0
    #applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2100
    eventPlayer.macro_pvar[0] = 0.867
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.macro_pvar[1] = 0.77
    eventPlayer.setHealingDealt(100 * eventPlayer.macro_pvar[1])
    eventPlayer.MoveSpeed += 9.1
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 5)
    eventPlayer.hero_initialized = true
    
rule "[kiriko/init.opy]: Correct Kiriko melee damage":
    @Event playerDealtDamage
    @Hero kiriko
    @Condition eventAbility == Button.MELEE
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])
