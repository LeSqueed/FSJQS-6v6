#!mainFile "../../main.opy"

rule "[doomfist/powerblock.opy]: Reduce Power Block active duration":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.isUsingAbility2() == true
    @Disabled

    wait(1.75)
    eventPlayer.forceButtonPress(Button.ABILITY_2)


rule "[doomfist/powerblock.opy]: Cancel Powerblock animation":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.isUsingAbility2() == true

    wait(0.15)
    eventPlayer.setAbility2Enabled(false)
