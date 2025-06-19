rule "[cassidy/flashbang.opy] Flashbang stun target for 0.4s":
    @Event playerDealtDamage
    @Hero cassidy
    @Condition eventAbility == Button.ABILITY_2
    
    victim.setStatusEffect(eventPlayer, Status.STUNNED, 0.4)
