#!mainFile "../../main.opy"

#!include "solar_rifle.opy"

def initIllari():
    @Name "[illari/init.opy]: initIllari()"
    
    eventPlayer.ult_charge_pvar[1] = 2450
    eventPlayer._base_damage_scalar = 0.75
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer._base_healing_scalar = 0.75
    eventPlayer.setHealingDealt(100 * eventPlayer._base_healing_scalar)
    eventPlayer._max_health_scalar = HeroHealthPercentage.ILLARI / 100
    eventPlayer.hero_initialized = true

rule "[illari/init.opy]: Correct Outburst and melee damage":
    @Event playerDealtDamage
    @Hero illari
    @Condition eventAbility in [Button.MELEE, Button.ABILITY_1] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar - eventDamage) / eventPlayer._base_damage_scalar)


rule "[illari/init.opy]: Correct Pylon self healing":
    @Event playerDealtHealing
    @Hero illari
    @Condition healee == healer
    
    heal(healer, null, eventHealing)