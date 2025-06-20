rule "[junkerqueen/commanding_shout.opy]: Prepare Commanding Shout ally tracking":
    @Event eachPlayer
    @Hero junkerQueen
    @Condition eventPlayer.isUsingAbility1() == true
    
    getPlayersInRadius(eventPlayer, 15.5, eventPlayer.getTeam(), LosCheck.SURFACES).exclude(eventPlayer).within_shout_radius = true

rule "[junkerqueen/commanding_shout.opy]: increase overhealth for allies":
    @Event eachPlayer
    @Condition eventPlayer.within_shout_radius == true
    
    eventPlayer.addHealthPool(Health.NORMAL, 9.5, false, false)
    eventPlayer.Junkerqueen_overhealth = getLastCreatedHealthPool()
    wait(2.9)
    eventPlayer._current_move_speed += 30
    eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)
    wait(1.9)
    eventPlayer._current_move_speed -= 30
    eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)
    removeHealthPool(eventPlayer.Junkerqueen_overhealth)
    eventPlayer.Junkerqueen_overhealth = null
    eventPlayer.within_shout_radius = false
