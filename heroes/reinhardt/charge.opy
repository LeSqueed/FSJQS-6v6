rule "[reinhardt/charge.opy]: Correct Charge damage":
    @Event playerDealtDamage
    @Hero reinhardt
    @Condition eventAbility == Button.ABILITY_1
    
    #Checks for pin vs boop damage (+ 1 because apparently 50.0 > 50 == true for whatever reason)
    if eventDamage > 51:
        damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])
    else:
        damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])
