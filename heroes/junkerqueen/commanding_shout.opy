rule "[junkerqueen/commanding_shout.opy]: Prepare Commanding Shout ally tracking":
    @Event eachPlayer
    @Hero junkerQueen
    @Condition eventPlayer.isUsingAbility1() == true
    
    getPlayersInRadius(eventPlayer, 15.5, eventPlayer.getTeam(), LosCheck.SURFACES).exclude(eventPlayer).within_shout_radius = true