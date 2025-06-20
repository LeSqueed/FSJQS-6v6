rule "[wreckingball/shields.opy]: Remove Adaptive Shields overhealth transfer":
    @Event eachPlayer
    @Hero wreckingBall
    @Condition eventPlayer.isUsingAbility2() == true
    
    eventPlayer.disallowButton(Button.ABILITY_2)
    eventPlayer.setAbility2Enabled(false)
    waitUntil(not eventPlayer.isUsingAbility2(), 999999986991104)
    enableAllAbilities()
    eventPlayer.allowButton(Button.ABILITY_2)


rule "[wreckingball/shields.opy]: Increase Adaptive Shield base overhealth gain":
    @Event eachPlayer
    @Hero wreckingBall
    @Condition eventPlayer.isUsingAbility2() == true
    
    eventPlayer.addHealthPool(Health.NORMAL, 100, false)
    eventPlayer.adaptive_overhealth_id = getLastCreatedHealthPool()
    waitUntil(not eventPlayer.isUsingAbility2(), 999999986991104)
    removeHealthPool(eventPlayer.adaptive_overhealth_id)
    eventPlayer.adaptive_overhealth_id = null
