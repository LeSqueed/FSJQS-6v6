#!mainFile "../../main.opy"

playervar Within_speed_radius

#!include "ampitup.opy"

def initLucio():
    @Name "[lucio/init.opy]: initLucio()"
    
    eventPlayer.ult_charge_pvar[1] = 2940
    eventPlayer._base_damage_scalar = 0.444
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer.startScalingSize(0.96)
    eventPlayer.hero_initialized = true


rule "[lucio/init.opy]: Correct Lucio melee damage":
    @Event playerDealtDamage
    @Hero lucio
    @Condition eventAbility == Button.MELEE
    
    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar - eventDamage) / eventPlayer._base_damage_scalar)


rule "[lucio/init.opy]: Correct Sonic Amplifier damage":
    @Event playerDealtDamage
    @Hero lucio
    @Condition eventAbility == Button.PRIMARY_FIRE
    
    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar * 0.909 - eventDamage) / eventPlayer._base_damage_scalar)

