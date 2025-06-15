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
    
    eventPlayer.MoveSpeed -= 6.25
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    wait(0.125)
    eventPlayer.MoveSpeed += 6.25
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    eventPlayer.Within_speed_radius = false

rule "[lucio/ampitup.opy]: decrease speed for Lucio":
    @Event eachPlayer
    @Hero lucio
    @Condition eventPlayer.isUsingAbility1() == true
    @Condition eventPlayer.isUsingAbility2() == true
    
    eventPlayer.MoveSpeed -= 6.25
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    wait(3)
    eventPlayer.MoveSpeed += 6.25
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
