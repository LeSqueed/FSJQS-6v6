rule "[mei/wall.opy]: Wall cooldown seconds Mei":
    @Event eachPlayer
    @Hero mei
    @Condition eventPlayer.isUsingAbility2() == true
    
    waitUntil(eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) or eventPlayer.isHoldingButton(Button.SECONDARY_FIRE), 99999)
    if eventPlayer.isHoldingButton(Button.PRIMARY_FIRE):
        waitUntil(not eventPlayer.isUsingAbility2(), 99999)
        eventPlayer.setAbilityCooldown(Button.ABILITY_2, 10)
