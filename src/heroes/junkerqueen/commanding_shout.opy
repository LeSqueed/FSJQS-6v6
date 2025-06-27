rule "[junkerqueen/commanding_shout.opy]: Prepare Commanding Shout ally tracking":
    @Event eachPlayer
    @Hero junkerQueen
    @Condition eventPlayer.isUsingAbility1() == true
    
    getPlayersInRadius(eventPlayer, 15.5, eventPlayer.getTeam(), LosCheck.SURFACES).exclude(eventPlayer).within_shout_radius = true
    wait(0.1)
    damage(eventPlayer, null, 18)

rule "[junkerqueen/commanding_shout.opy]: increase overhealth for allies":
    @Event eachPlayer
    @Condition eventPlayer.within_shout_radius == true
    
    eventPlayer.addHealthPool(Health.NORMAL, 6.75, false, false)
    eventPlayer.Junkerqueen_overhealth = getLastCreatedHealthPool()
    wait(4)
    removeHealthPool(eventPlayer.Junkerqueen_overhealth)
    eventPlayer.Junkerqueen_overhealth = null
    eventPlayer.within_shout_radius = false
