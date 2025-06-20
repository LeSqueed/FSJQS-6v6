#!mainFile "../../main.opy"

def initFreja():
    @Name "[freja/init.opy]: initFreja()"
    
    eventPlayer.ult_charge_pvar[1] = 1750
    eventPlayer._base_damage_scalar = 0.667
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer.startScalingSize(0.96)
    eventPlayer.hero_initialized = true


rule "[freja/init.opy]: Correct Freja other forms of damage":
    @Event playerDealtDamage
    @Hero freja
    @Condition eventAbility == Button.MELEE
    
    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar - eventDamage) / eventPlayer._base_damage_scalar)


rule "[freja/init.opy]: Correct Freja secondary impact damage":
    @Event playerDealtDamage
    @Hero freja
    @Condition eventAbility == Button.SECONDARY_FIRE
    @Condition eventDamage < 59
    
    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar - eventDamage) / eventPlayer._base_damage_scalar)


rule "[freja/init.opy]: Correct Freja ultimate impact damage":
    @Event playerDealtDamage
    @Hero freja
    @Condition eventAbility == Button.ULTIMATE
    
    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar - eventDamage) / eventPlayer._base_damage_scalar)
    wait(1.3)