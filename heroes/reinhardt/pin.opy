rule "[reinhardt/pin.opy]: Slow Reinhardt after pin":
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer.isUsingAbility1() == true
    
    waitUntil(not eventPlayer.isUsingAbility1(), 99999)
    eventPlayer.MoveSpeed -= 50
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    wait(1)
    eventPlayer.MoveSpeed += 50
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
