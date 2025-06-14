rule "[dva/boosters.opy]: Reduce Boosters damage":
    @Event playerDealtDamage
    @Hero dva
    @Condition eventAbility == Button.ABILITY_1
    
    heal(victim, null, eventDamage - 0.8 * eventDamage / eventPlayer.macro_pvar[0])
