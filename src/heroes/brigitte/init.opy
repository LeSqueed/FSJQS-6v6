#!mainFile "../../main.opy"

playervar bash_cooldown
playervar Brig_Rally_Overhealth_amount
playervar within_rally_radius

#!include "bash.opy"
#!include "inspire.opy"
#!include "repair_pack.opy"
#!include "rally.opy"

def initBrigitte():
    @Name "[brigitte/init.opy]: initBrigitte()"
    
    eventPlayer.custom_hp_pvar[0] = 15
    eventPlayer.custom_hp_pvar[1] = 10
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2625
    eventPlayer._base_damage_scalar = 0.778
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer._base_healing_scalar = 0.8
    eventPlayer.setHealingDealt(100 * eventPlayer._base_healing_scalar)
    eventPlayer._max_health_scalar = HeroHealthPercentage.BRIGITTE / 100
    eventPlayer.hero_initialized = true

rule "[brigitte/init.opy]: Correct Whipshot damage":
    @Event playerDealtDamage
    @Hero brigitte
    @Condition eventAbility == Button.ABILITY_1
    
    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar - eventDamage) / eventPlayer._base_damage_scalar)

