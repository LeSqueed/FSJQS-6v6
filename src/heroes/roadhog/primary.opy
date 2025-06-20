rule "[roadhog/primary.opy]: true damage":
    @Event playerDealtDamage
    @Hero roadhog
    @Condition Button.PRIMARY_FIRE == eventAbility
    
    damage(victim, eventPlayer, 10 / eventPlayer._base_damage_scalar)
    wait(0.625)