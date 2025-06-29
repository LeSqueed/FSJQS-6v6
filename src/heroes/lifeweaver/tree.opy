#!mainFile "../../main.opy"

rule "[lifeweaver/tree.opy]: Sombra Hack Ability Lockout tracker for LW":
    @Event eachPlayer
    @Hero lifeweaver
    @Condition eventPlayer.hasStatus(Status.HACKED) == true
    @Disabled
    
    eventPlayer.CannotAction++
    waitUntil(not eventPlayer.hasStatus(Status.HACKED), 1.8)
    eventPlayer.CannotAction--


rule "[lifeweaver/tree.opy]: Trigger Ult Detection":
    @Event eachPlayer
    @Hero lifeweaver
    @Condition (eventPlayer.isHoldingButton(Button.ULTIMATE) and eventPlayer.getUltCharge() == 100 and not eventPlayer.CannotAction) == true
    @Disabled
    
    eventPlayer.LwVariableTracking[3] = true
    waitUntil(eventPlayer.CannotAction or eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) or eventPlayer.isHoldingButton(Button.PRIMARY_FIRE), 99999)
    eventPlayer.LwVariableTracking[3] = false
    if eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) and not eventPlayer.CannotAction:
        eventPlayer.LwVariableTracking[4] = true
        eventPlayer.LwVariableTracking[5] = raycast(raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + (eventPlayer.getFacingDirection() * (distance(eventPlayer, raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 30, null, null, true).getHitPosition()) - 1)), null, null, true).getHitPosition(), eventPlayer.getEyePosition() + (eventPlayer.getFacingDirection() * (distance(eventPlayer, raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + (eventPlayer.getFacingDirection() * (distance(eventPlayer, raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 30, null, null, true).getHitPosition()) - -2)), null, null, true).getHitPosition()) - -2)) + Vector.DOWN * 100, getAllPlayers(), eventPlayer, false).getHitPosition()
        wait(1.5)
        waitUntil(isInLoS(eventPlayer.LwVariableTracking[5], eventPlayer.LwVariableTracking[5] + vect(0, 5, 0)), 15)
        eventPlayer.LwVariableTracking[4] = false


rule "[lifeweaver/tree.opy]: Track healing tree":
    @Event playerReceivedHealing
    @Condition eventAbility == Button.ULTIMATE
    @Condition healer == getPlayersOnHero(Hero.LIFEWEAVER, eventPlayer.getTeam())
    @Disabled
    
    eventPlayer.Lifeweaver_tree_healing = eventHealing
    wait(1.5)
    eventPlayer.Lifeweaver_tree_healing = null


rule "[lifeweaver/tree.opy]: remove tree overhealth":
    @Event eachPlayer
    @Condition distance(getPlayersOnHero(Hero.LIFEWEAVER, eventPlayer.getTeam()).LwVariableTracking[5], eventPlayer) <= 12
    @Condition getPlayersOnHero(Hero.LIFEWEAVER, eventPlayer.getTeam()).LwVariableTracking[4] == true
    @Disabled
    
    wait(0.1)
    eventPlayer.Lifeweaver_tree_overheal = 90 - eventPlayer.Lifeweaver_tree_healing / 2
    eventPlayer.addHealthPool(Health.NORMAL, 90 - eventPlayer.Lifeweaver_tree_overheal * eventPlayer.max_health_scaler, false, false)
    bigMessage(getAllPlayers(), "in tree range")
    wait(1.65)
    removeHealthPool(getLastCreatedHealthPool())
    if ruleCondition:
        loop()


rule "[lifeweaver/tree.opy]: remove tree overhealth":
    @Event eachPlayer
    @Condition distance(getPlayersOnHero(Hero.LIFEWEAVER, eventPlayer.getTeam()).LwVariableTracking[5], eventPlayer) <= 12
    @Condition getPlayersOnHero(Hero.LIFEWEAVER, eventPlayer.getTeam()).LwVariableTracking[4] == true
    @Disabled
    
    eventPlayer.Lifeweaver_tree_overheal = 150 - eventPlayer.Lifeweaver_tree_healing / 2