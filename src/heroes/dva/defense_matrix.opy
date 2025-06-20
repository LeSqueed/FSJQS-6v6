rule "[dva/defense_matrix.opy]: Increase Defense Matrix cooldown":
    @Event eachPlayer
    @Hero dva
    @Condition eventPlayer.isFiringSecondaryFire() == true
    
    waitUntil(not eventPlayer.isFiringSecondaryFire(), 999999986991104)
    eventPlayer.setSecondaryFireEnabled(false)
    wait(1.5)
    eventPlayer.setSecondaryFireEnabled(true)
