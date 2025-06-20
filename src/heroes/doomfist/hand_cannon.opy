rule "[doomfist/hand_cannon.opy]: Correct Hand Cannon damage":
    @Event playerDealtDamage
    @Hero doomfist
    @Condition eventAbility == Button.PRIMARY_FIRE
    
    damage(victim, eventPlayer, (eventDamage / eventPlayer._base_damage_scalar * 0.91 - eventDamage) / eventPlayer._base_damage_scalar)
