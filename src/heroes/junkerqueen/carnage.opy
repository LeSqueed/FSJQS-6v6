rule "[junkerqueen/carnage.opy]: Reduce Carnage damage":
    @Event eachPlayer
    @Hero junkerQueen
    @Condition eventPlayer.isUsingAbility2() == true
    
    eventPlayer.setDamageDealt(85.714)
    waitUntil(not eventPlayer.isUsingAbility2(), 999999986991104)
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
