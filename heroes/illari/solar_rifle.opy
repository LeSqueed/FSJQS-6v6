rule "[illari/solar_rifle.opy]: Correct Solar Rifle damage":
    @Event playerDealtDamage
    @Hero illari
    @Condition eventAbility == Button.PRIMARY_FIRE
    
    if eventWasCriticalHit:
        damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] * 1.143 - eventDamage) / eventPlayer.macro_pvar[0])
    else:
        damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[illari/solar_rifle.opy]: Correct Solar Rifle healing":
    @Event eachPlayer
    @Hero illari
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true
    
    eventPlayer.setHealingDealt(100)
    waitUntil(not eventPlayer.isHoldingButton(Button.SECONDARY_FIRE), 999999986991104)
    eventPlayer.setHealingDealt(75)
