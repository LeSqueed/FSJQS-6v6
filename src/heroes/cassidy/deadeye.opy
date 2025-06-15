#!mainFile "../../../main.opy"

rule "[cassidy/deadeye.opy]: Set damage during deadeye":
    @Event eachPlayer
    @Hero cassidy
    @Condition eventPlayer.isUsingUltimate() == true
    
    eventPlayer.setDamageDealt(100)
    waitUntil(not eventPlayer.isUsingUltimate(), 999999986991104)
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
