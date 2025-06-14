rule "[doomfist/powerblock.opy]: Reduce Power Block active duration":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.isUsingAbility2() == true
    @Disabled
    
    wait(1.75)
    eventPlayer.forceButtonPress(Button.ABILITY_2)

rule "[doomfist/meteorstrike.opy] Doomfist ult remove self healing":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.isUsingUltimate() == true
    
    eventPlayer.setHealingDealt(0)
    waitUntil(not eventPlayer.isUsingUltimate(), 99999)
    eventPlayer.setHealingDealt(100)
