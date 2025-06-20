rule "[sombra/opportunist.opy] Remove 20% damage increase":
    @Event playerDealtDamage
    @Hero sombra
    @Condition victim.hasStatus(Status.HACKED) == true
    
    heal(victim, null, eventDamage / 6)
