rule "[lucio/ampitup.opy]: begin ally tracking":
    @Event eachPlayer
    @Hero lucio
    @Condition eventPlayer.isUsingAbility1() == true
    @Condition eventPlayer.isUsingAbility2() == true
    
    getPlayersInRadius(eventPlayer, 12, eventPlayer.getTeam(), LosCheck.SURFACES).exclude(eventPlayer).Within_speed_radius = true
    wait(0.125)
    if ruleCondition:
        loop()


rule "[lucio/ampitup.opy]: decrease speed for allies":
    @Event eachPlayer
    @Condition eventPlayer.Within_speed_radius == true
    
    eventPlayer._current_move_speed -= 6.25
    eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)
    wait(0.125)
    eventPlayer._current_move_speed += 6.25
    eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)
    eventPlayer.Within_speed_radius = false

rule "[lucio/ampitup.opy]: decrease speed for Lucio":
    @Event eachPlayer
    @Hero lucio
    @Condition eventPlayer.isUsingAbility1() == true
    @Condition eventPlayer.isUsingAbility2() == true
    
    eventPlayer._current_move_speed -= 6.25
    eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)
    wait(3)
    eventPlayer._current_move_speed += 6.25
    eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)
