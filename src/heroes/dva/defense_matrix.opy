rule "[dva/defense_matrix.opy]: Increase Defense Matrix cooldown":
    @Event eachPlayer
    @Hero dva
    @Condition eventPlayer.isFiringSecondaryFire() == true
    
    waitUntil(not eventPlayer.isFiringSecondaryFire(), Math.INFINITY)
    eventPlayer.setSecondaryFireEnabled(false)
    wait(1.5)
    eventPlayer.setSecondaryFireEnabled(true)
