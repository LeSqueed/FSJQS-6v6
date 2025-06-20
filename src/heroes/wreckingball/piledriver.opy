rule "[wreckingball/piledriver.opy]: Increase Piledriver / Quadcannon damage":
    @Event playerDealtDamage
    @Hero wreckingBall
    @Condition eventAbility in [Button.PRIMARY_FIRE, Button.CROUCH] == true
    
    damage(victim, attacker, (0.8 * (eventDamage / eventPlayer._base_damage_scalar) - eventDamage) / eventPlayer._base_damage_scalar)