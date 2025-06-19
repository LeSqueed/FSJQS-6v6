rule "[wreckingball/grapple.opy]: Force Grappling Hook cooldown":
    @Event eachPlayer
    @Hero wreckingBall
    @Condition eventPlayer.isFiringSecondaryFire() == true
    
    waitUntil(eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE) > 0, 999999986991104)
    if eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE) <= 1:
        eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, 1.92)


rule "[wreckingball/grapple.opy]: Increase Fireball impact damage":
    @Event playerDealtDamage
    @Hero wreckingBall
    @Condition eventAbility == Button.SECONDARY_FIRE
    
    damage(victim, attacker, (0.833 * (eventDamage / eventPlayer.macro_pvar[0]) - eventDamage) / eventPlayer.macro_pvar[0])