rule "[roadhog/breather.opy]: Adjust Breather efficacy":
    @Event eachPlayer
    @Hero roadhog
    @Condition eventPlayer.isFiringSecondaryFire() == true
    
    eventPlayer.setHealingDealt(222.222)
    wait(0.8)
    eventPlayer.setHealingDealt(48.387)
    waitUntil(not eventPlayer.isFiringSecondaryFire(), 999999986991104)
    eventPlayer.setHealingDealt(100)