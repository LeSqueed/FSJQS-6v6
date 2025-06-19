rule "[reinhardt/shatter.opy]: Correct Earthshatter damage":
    @Event playerDealtDamage
    @Hero reinhardt
    @Condition eventAbility == Button.ULTIMATE
    @Condition eventWasCriticalHit == false
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[reinhardt/shatter.opy]: Correct Earthshatter critical damage":
    @Event playerDealtDamage
    @Hero reinhardt
    @Condition eventAbility == Button.ULTIMATE
    @Condition eventWasCriticalHit == true
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])