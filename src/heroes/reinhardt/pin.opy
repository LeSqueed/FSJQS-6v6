rule "[reinhardt/pin.opy]: Slow Reinhardt after pin":
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer.isUsingAbility1() == true
    
    waitUntil(not eventPlayer.isUsingAbility1(), Math.INFINITY)
    eventPlayer._current_move_speed -= 50
    eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)
    wait(1)
    eventPlayer._current_move_speed += 50
    eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)
