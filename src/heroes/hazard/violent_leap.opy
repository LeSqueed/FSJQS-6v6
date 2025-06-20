rule "[hazard/violent_leap.opy] Increase damage violant leap to 70":
    @Event playerDealtDamage
    @Hero hazard
    @Condition eventAbility == Button.ABILITY_1
    
    damage(victim, attacker, (0.813 * (eventDamage / eventPlayer._base_damage_scalar) - eventDamage) / eventPlayer._base_damage_scalar)
