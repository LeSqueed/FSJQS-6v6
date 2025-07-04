#!mainFile "../../main.opy"

rule "[mercy/valkyrie]: Mercy give one rez charge":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.isUsingUltimate() == true

    eventPlayer.Mercy_Rez_charges = 1
    waitUntil(not eventPlayer.isUsingUltimate(), 16)
    eventPlayer.Mercy_Rez_charges = null
