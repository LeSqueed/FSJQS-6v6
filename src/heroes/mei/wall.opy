rule "[mei/wall.opy]: Wall cooldown seconds Mei":
    @Event eachPlayer
    @Hero mei
    @Condition eventPlayer.isUsingAbility2() == true
    
    waitUntil(eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) or eventPlayer.isHoldingButton(Button.SECONDARY_FIRE), Math.INFINITY)
    if eventPlayer.isHoldingButton(Button.PRIMARY_FIRE):
        waitUntil(not eventPlayer.isUsingAbility2(), Math.INFINITY)
        eventPlayer.setAbilityCooldown(Button.ABILITY_2, 10)
