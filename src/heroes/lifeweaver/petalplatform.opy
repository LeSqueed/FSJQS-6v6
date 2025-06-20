rule "[lifeweaver/petalplatform.opy]: Lose charges and reset cooldown":
    @Event eachPlayer
    @Hero lifeweaver
    @Condition eventPlayer.Lifeweaver_petal_charges != 0
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_1) == true
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0
    
    eventPlayer.Lifeweaver_petal_charges--
    if eventPlayer.Lifeweaver_petal_charges != 0:
        #waitUntil(eventPlayer.isUsingAbility1(), 99999)
        wait(0.25)
        eventPlayer.setAbilityCooldown(Button.ABILITY_1, 0)


rule "[lifeweaver/petalplatform.opy]: recharge petal":
    @Event eachPlayer
    @Hero lifeweaver
    @Condition eventPlayer.Lifeweaver_petal_charges != 2
    
    wait(12, Wait.ABORT_WHEN_FALSE)
    eventPlayer.Lifeweaver_petal_charges++
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 0)
    if ruleCondition:
        loop()