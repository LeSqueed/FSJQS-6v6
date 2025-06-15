rule "[doomfist/hand_cannon.opy]: Correct Hand Cannon damage":
    @Event playerDealtDamage
    @Hero doomfist
    @Condition eventAbility == Button.PRIMARY_FIRE
    
    damage(victim, eventPlayer, (eventDamage / eventPlayer.macro_pvar[0] * 0.91 - eventDamage) / eventPlayer.macro_pvar[0])
