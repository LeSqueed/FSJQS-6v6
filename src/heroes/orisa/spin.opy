rule "[orisa/spin.opy]: Movementspeed increase during Spin":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isUsingAbility2() == true
    
    waitUntil(not eventPlayer.isUsingAbility2(), Math.INFINITY)
    eventPlayer._current_move_speed += 35
    eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)
    wait(1)
    eventPlayer._current_move_speed -= 35
    eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)
