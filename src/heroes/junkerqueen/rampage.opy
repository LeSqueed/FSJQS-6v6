rule "[junkerqueen/rampage.opy]: Reduce Rampage damage":
    @Event eachPlayer
    @Hero junkerQueen
    @Condition eventPlayer.isUsingUltimate() == true
    
    eventPlayer.setDamageDealt(83.333)
    waitUntil(not eventPlayer.isUsingUltimate(), 999999986991104)
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)

