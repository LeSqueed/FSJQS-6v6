#!mainFile "../../main.opy"

rule "[brigitte/rally.opy]: Begin rally ally tracking":
    @Event eachPlayer
    @Hero brigitte
    @Condition eventPlayer.isUsingUltimate() == true
    
    getPlayersInRadius(eventPlayer, 8.5, eventPlayer.getTeam(), LosCheck.SURFACES).exclude(eventPlayer).within_rally_radius = true
    wait(0.496)
    if ruleCondition:
        loop()
    getPlayers(eventPlayer.getTeam()).within_rally_radius = false


rule "[brigitte/rally.opy]: Begin ally tracking if out of range":
    @Event eachPlayer
    @Hero brigitte
    @Condition eventPlayer.isUsingUltimate() == true
    
    getPlayers(eventPlayer.getTeam()).exclude(getPlayersInRadius(eventPlayer, 8.5, eventPlayer.getTeam())).within_rally_radius = false
    wait(0.496)
    if ruleCondition:
        loop()


rule "[brigitte/rally.opy]: Correct healing/overhealth numbers":
    @Event eachPlayer
    @Condition eventPlayer.within_rally_radius == true

    if eventPlayer._total_rally_health < 100:
        eventPlayer.addHealthPool(Health.NORMAL, min(100 - eventPlayer._total_rally_health, 10), false, false)
        eventPlayer._total_rally_health += min(100 - eventPlayer._total_rally_health, 10)
    wait(0.496)
    if ruleCondition:
        loop()
    eventPlayer.addHealthPool(Health.NORMAL, 15 * eventPlayer._max_health_scalar, false, false)
    eventPlayer.within_rally_radius = false


rule "[brigitte/rally.opy]: Remove rally health when out of radius for 30s":
    @Event eachPlayer
    @Condition eventPlayer.within_rally_radius == false
    @Condition eventPlayer._total_rally_health > 0
    
    wait(30)
    while eventPlayer._total_rally_health > 0 and eventPlayer.within_rally_radius == false:
        damage(eventPlayer, null, min(eventPlayer._total_rally_health, 10))
        eventPlayer._total_rally_health = max(eventPlayer._total_rally_health - 10, 0)


rule "[brigitte/rally.opy]: Decrease rally health if taken damage":
    @Event playerTookDamage
    @Condition eventPlayer.within_rally_radius == true
    
    if eventPlayer._total_rally_health < 100:
        eventPlayer._total_rally_health = eventPlayer._total_rally_health - ceil(eventDamage)

        
rule "[brigitte/rally.opy]: remove rally overhealth":
    @Event eachPlayer
    @Condition eventPlayer.within_rally_radius == true
    
    damage(eventPlayer, null, min(eventPlayer._rally_health, 12))