#!mainFile "../../main.opy"

rule "[brigitte/rally.opy]: begin rally ally tracking":
    @Event eachPlayer
    @Hero brigitte
    @Condition eventPlayer.isUsingUltimate() == true

    getPlayersInRadius(eventPlayer, 8.5, eventPlayer.getTeam(), LosCheck.SURFACES).exclude(eventPlayer).within_rally_radius = true
    wait(0.496)
    if ruleCondition:
        loop()
    getPlayers(eventPlayer.getTeam()).within_rally_radius = false
    getPlayersOnHero(Hero.BRIGITTE, eventPlayer.getTeam()).Brig_Rally_Overhealth_amount = 0


rule "[brigitte/rally.opy]: Begin tracking ally out of range":
    @Event eachPlayer
    @Hero brigitte
    @Condition eventPlayer.isUsingUltimate() == true

    getPlayersInRadius(eventPlayer, 8.5, eventPlayer.getTeam(), LosCheck.SURFACES).exclude(eventPlayer).within_rally_radius = false
    wait(0.496)
    if ruleCondition:
        loop()


rule "[brigitte/rally.opy]: Correct healing and overhealth":
    @Event eachPlayer
    @Condition eventPlayer.within_rally_radius == true

    damage(eventPlayer, null, 15 * eventPlayer._max_health_scalar)
    if eventPlayer.Brig_Rally_Overhealth_amount < 100:
        eventPlayer.addHealthPool(Health.NORMAL, 10, false, false)
        eventPlayer.Brig_Rally_Overhealth_amount += 10
    wait(0.496)
    if ruleCondition:
        loop()
    eventPlayer.addHealthPool(Health.NORMAL, 15 * eventPlayer._max_health_scalar, false, false)
    eventPlayer.within_rally_radius = false