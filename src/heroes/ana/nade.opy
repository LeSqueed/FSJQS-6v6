rule "[ana/nade.opy]: Increase Biotic Grenade damage":
    @Event playerDealtDamage
    @Hero ana
    @Condition eventAbility == Button.ABILITY_2
    
    damage(victim, attacker, (0.8 * (eventDamage / eventPlayer._base_damage_scalar) - eventDamage) / eventPlayer._base_damage_scalar)


rule "[ana/nade.opy]: Increase Biotic Grenade healing":
    @Event playerDealtHealing
    @Hero ana
    @Condition eventAbility == Button.ABILITY_2
    
    heal(healee, healer, eventHealing * 1.334 / eventPlayer._base_healing_scalar - eventHealing)
