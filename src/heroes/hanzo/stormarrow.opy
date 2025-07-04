#!mainFile "../../main.opy"

rule "[hanzo/stormarrow.opy]: Correct Arrow speed Storm arrows (110ms)":
    @Event eachPlayer
    @Hero hanzo
    @Condition eventPlayer.isUsingAbility2() == true

    eventPlayer.setProjectileSpeed(200)
    waitUntil(not eventPlayer.isUsingAbility1(), 6)
    eventPlayer.setProjectileSpeed(100)
