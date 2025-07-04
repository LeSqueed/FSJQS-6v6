#!mainFile "../../main.opy"

rule "[mei/cryo_freeze.opy]: OW1 Cryo-Freeze healing set to 80 otherwise for tank mei set to 120":
    @Event eachPlayer
    @Hero mei
    @Condition eventPlayer.isUsingAbility1() == true

    eventPlayer.setHealingReceived(80)
    waitUntil(not eventPlayer.isUsingAbility1(), Math.INFINITY)
    eventPlayer.setHealingReceived(100)
