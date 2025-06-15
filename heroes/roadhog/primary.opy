rule "[roadhog/primary.opy]: true damage":
    @Event playerDealtDamage
    @Hero roadhog
    @Condition Button.PRIMARY_FIRE == eventAbility
    
    damage(victim, eventPlayer, 10 / eventPlayer.macro_pvar[0])
    wait(0.625)