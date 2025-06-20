rule "[dva/boosters.opy]: Reduce Boosters damage":
    @Event playerDealtDamage
    @Hero dva
    @Condition eventAbility == Button.ABILITY_1
    
    heal(victim, null, eventDamage - 0.8 * eventDamage / eventPlayer._base_damage_scalar)
