rule "[mercy/valkyrie]: Unlimited momentum and rez during valkyrie":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.isUsingUltimate() == true
    
    eventPlayer.Mercy_Rez_charges = 1
    while eventPlayer.isUsingUltimate() == true:
        eventPlayer.MercyMomentum = 100
        wait(0.1)
    waitUntil(not eventPlayer.isUsingUltimate(), 16)
    eventPlayer.Mercy_Rez_charges = null
