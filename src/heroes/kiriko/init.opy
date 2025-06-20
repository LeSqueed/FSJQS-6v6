#!mainFile "../../main.opy"

#!include "heroes/kiriko/swift_step.opy"
#!include "heroes/kiriko/protection_suzu.opy"

def initKiriko():
    @Name "[kiriko/init.opy]: initKiriko()"
    
    eventPlayer.ult_charge_pvar[1] = 2100
    eventPlayer._base_damage_scalar = 0.867
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer._base_healing_scalar = 0.77
    eventPlayer.setHealingDealt(100 * eventPlayer._base_healing_scalar)
    eventPlayer.MoveSpeed += 9.1
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 5)
    eventPlayer.hero_initialized = true
    
rule "[kiriko/init.opy]: Correct Kiriko melee damage":
    @Event playerDealtDamage
    @Hero kiriko
    @Condition eventAbility == Button.MELEE
    
    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar - eventDamage) / eventPlayer._base_damage_scalar)
