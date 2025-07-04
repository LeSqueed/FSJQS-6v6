#!mainFile "../../main.opy"

rule "[cassidy/deadeye.opy]: Set damage during deadeye":
    @Event eachPlayer
    @Hero cassidy
    @Condition eventPlayer.isUsingUltimate() == true

    eventPlayer.setDamageDealt(100)
    waitUntil(not eventPlayer.isUsingUltimate(), Math.INFINITY)
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
