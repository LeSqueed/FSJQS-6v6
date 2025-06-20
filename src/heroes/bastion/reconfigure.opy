rule "[bastion/reconfigure.opy]: Reduce assault form damage and movement speed":
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer.isUsingAbility1() == true
    
    eventPlayer.setDamageReceived(112.5)
    eventPlayer._current_move_speed = eventPlayer._current_move_speed - 15
    eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)
    wait(0.95)
    eventPlayer.startHealingOverTime(eventPlayer, 8, 15)
    eventPlayer.sentry_healing_id = getLastHealingOverTimeId()
    waitUntil(not eventPlayer.isUsingAbility1(), 999999986991104)
    eventPlayer.setDamageReceived(100)
    eventPlayer._current_move_speed = eventPlayer._current_move_speed + 15
    eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)
    stopHealingOverTime(eventPlayer.sentry_healing_id)
    eventPlayer.sentry_healing_id = null



rule "[bastion/reconfigure.opy]: Increase movement allowed by self-damage grenade":
    @Event playerDealtDamage
    @Hero bastion
    @Condition eventPlayer.isUsingAbility1() == true
    @Condition attacker == victim
    
    eventPlayer._current_move_speed = eventPlayer._current_move_speed + 25
    eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)
    #Grace period to make sure the player receives this benefit
    wait(0.1)
    waitUntil(eventPlayer.isOnGround(), Math.INFINITY)
    #if not ruleCondition:
    #        return
    eventPlayer._current_move_speed -= 25
    eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)


