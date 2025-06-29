#!mainFile "../../main.opy"

rule "[juno/init.opy]: Correct Pulsar Torpedo damage":
    @Event playerDealtDamage
    @Hero juno
    @Condition eventAbility == Button.ABILITY_2
    
    damage(victim, attacker, (0.882 * (eventDamage / eventPlayer._base_damage_scalar) - eventDamage) / eventPlayer._base_damage_scalar)

rule "[juno/init.opy]: Correct Pulsar Torpedo healing over time":
    @Event playerDealtHealing
    @Hero juno
    @Condition eventHealing > 69
    
    healee.startDamageOverTime(null, 1.65, 10)
