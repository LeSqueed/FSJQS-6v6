rule "[wreckingball/piledriver.opy]: Increase Piledriver / Quadcannon damage":
    @Event playerDealtDamage
    @Hero wreckingBall
    @Condition eventAbility in [Button.PRIMARY_FIRE, Button.CROUCH] == true
    
    damage(victim, attacker, (0.8 * (eventDamage / eventPlayer.macro_pvar[0]) - eventDamage) / eventPlayer.macro_pvar[0])