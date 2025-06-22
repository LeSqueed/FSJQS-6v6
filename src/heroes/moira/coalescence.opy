rule "[moira/coalescence.opy]: Prevent fading during Coalescence":
    @Event eachPlayer
    @Hero moira
    @Condition eventPlayer.isUsingUltimate() == true
    
    eventPlayer.setDamageDealt(82.353)
    waitUntil(not eventPlayer.isUsingUltimate(), Math.INFINITY)
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
