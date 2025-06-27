#!mainFile "../../main.opy"

playervar Ana_Sleepdart_Target

#!include "sleep.opy"
#!include "nade.opy"

def initAna():
    @Name "[ana/init.opy]: initAna()"
    
    eventPlayer.ult_charge_pvar[1] = 2300
    eventPlayer._base_damage_scalar = 0.667
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer._base_healing_scalar = 0.933
    eventPlayer.setHealingDealt(100 * eventPlayer._base_healing_scalar)
    eventPlayer._max_health_scalar = HeroHealthPercentage.ANA / 100
    eventPlayer.hero_initialized = true

rule "[ana/init.opy]: Correct Sleep Dart and Ana Melee damage":
    @Event playerDealtDamage
    @Hero ana
    @Condition eventAbility in [Button.ABILITY_1, Button.MELEE] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar - eventDamage) / eventPlayer._base_damage_scalar)


rule "[ana/init.opy]: Correct Primary Fire damage":
    @Event playerDealtDamage
    @Hero ana
    @Condition eventAbility == Button.PRIMARY_FIRE
    
    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar * 0.933 - eventDamage) / eventPlayer._base_damage_scalar)
