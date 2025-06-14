rule "[venture/drill_dash.opy]: Correct Drill Dash damage":
    @Event playerDealtDamage
    @Hero venture
    @Condition eventAbility == Button.SECONDARY_FIRE
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] * 0.444 - eventDamage) / eventPlayer.macro_pvar[0])
