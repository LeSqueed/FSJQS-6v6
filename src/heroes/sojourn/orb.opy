rule "[sojourn/orb.opy] Increased disruptor shot damage":
    @Event playerDealtDamage
    @Hero sojourn
    @Condition eventAbility == Button.ABILITY_2
    
    damage(victim, eventPlayer, 5.2)