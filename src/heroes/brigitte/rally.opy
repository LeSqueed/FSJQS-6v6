#!mainFile "../../main.opy"

rule "[brigitte/rally.opy]: begin rally ally tracking":
    @Event eachPlayer
    @Hero brigitte
    @Condition eventPlayer.isUsingUltimate() == true
    @Disabled
    
    getPlayersInRadius(eventPlayer, 8.5, eventPlayer.getTeam(), LosCheck.SURFACES).exclude(eventPlayer).within_rally_radius = true
    wait(0.496)
    if ruleCondition:
        loop()


rule "[brigitte/rally.opy]: remove rally overhealth":
    @Event eachPlayer
    @Condition eventPlayer.within_rally_radius == true
    @Disabled
    
    damage(eventPlayer, null, 15)
    wait(0.496)
    eventPlayer.within_rally_radius = false