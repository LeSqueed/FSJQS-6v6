#!mainFile "../../main.opy"

rule "[mauga/cage.opy]: Reduce Cage Fight duration":
    @Event eachPlayer
    @Hero mauga
    @Condition eventPlayer.isUsingUltimate() == true

    wait(6)
    eventPlayer.forceButtonPress(Button.ULTIMATE)

