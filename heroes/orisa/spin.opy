rule "[orisa/spin.opy]: Movementspeed increase during Spin":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isUsingAbility2() == true
    
    waitUntil(not eventPlayer.isUsingAbility2(), 99999)
    eventPlayer.MoveSpeed += 35
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    wait(1)
    eventPlayer.MoveSpeed -= 35
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
