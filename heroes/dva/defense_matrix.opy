rule "[dva/defense_matrix.opy]: Increase Defense Matrix cooldown":
    @Event eachPlayer
    @Hero dva
    @Condition eventPlayer.isFiringSecondaryFire() == true
    
    #Defense Matrix still goes on cooldown visually even when the ability is disabled, so a faux cooldown was not implemented
    waitUntil(not eventPlayer.isFiringSecondaryFire(), 999999986991104)
    eventPlayer.setSecondaryFireEnabled(false)
    wait(1.5)
    eventPlayer.setSecondaryFireEnabled(true)
