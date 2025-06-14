rule "[widowmaker/grapple.opy]: Grapple kick":
    @Event eachPlayer
    @Hero widowmaker
    @Condition eventPlayer.isUsingAbility1() == true
    
    wait(0.2)
    waitUntil(not eventPlayer.isUsingAbility1() or eventPlayer.isHoldingButton(Button.ABILITY_1), 6)
    if eventPlayer.isHoldingButton(Button.ABILITY_1):
        eventPlayer.startForcingButton(Button.JUMP)
        wait(0.1)
        eventPlayer.forceButtonPress(Button.MELEE)
        playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.WHITE, eventPlayer, 3)
        playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 50)
        ([player for player in getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())) if distance(eventPlayer, player) <= 3 and isInLoS(eventPlayer, player) and player != eventPlayer]).applyImpulse(vect(0, 10, 0), 5, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
        ([player for player in getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())) if distance(eventPlayer, player) <= 3 and isInLoS(eventPlayer, player) and player != eventPlayer]).applyImpulse(directionTowards(eventPlayer, eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 30), 20, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
        damage([player for player in getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())) if isInLoS(eventPlayer, player) and distance(eventPlayer, player) <= 3], eventPlayer, 25)
    eventPlayer.stopForcingButton(Button.JUMP)