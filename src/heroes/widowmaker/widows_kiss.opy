rule "[widowmaker/widows_kiss.opy]: Widowmaker scope glint":
    @Event eachPlayer
    @Hero widowmaker
    @Condition eventPlayer.isFiringSecondaryFire() == true
    
    #Without aiming at widow check
    createEffect([player for player in getPlayers(getOppositeTeam(eventPlayer.getTeam())) if distance(eventPlayer, player) >= 3 and eventPlayer.isInViewAngle(player.getEyePosition(), 15)], Effect.GOOD_AURA, Color.WHITE, eventPlayer.getEyePosition(), 0.45, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.WidowScopeGlint_effect = getLastCreatedEntity()
    waitUntil(not eventPlayer.isFiringSecondaryFire(), 100000000)
    destroyEffect(eventPlayer.WidowScopeGlint_effect)


rule "[widowmaker/widows_kiss.opy]: beam":
    @Event eachPlayer
    @Hero widowmaker
    @Condition eventPlayer.isFiringSecondaryFire() == true
    
    wait(0.9, Wait.ABORT_WHEN_FALSE)
    createBeam(getPlayers(getOppositeTeam(eventPlayer.getTeam())), Beam.BAD, eventPlayer.getEyePosition() + worldVector(vect(0, -0.14, 0), eventPlayer, Transform.ROTATION), raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 70, getAllPlayers(), eventPlayer, true).getHitPosition(), Color.RED, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.Widowmaker_beam_effect = getLastCreatedEntity()
    waitUntil(not eventPlayer.isFiringSecondaryFire(), 99999)
    destroyEffect(eventPlayer.Widowmaker_beam_effect)
    eventPlayer.Widowmaker_beam_effect = null


rule "[widowmaker/widows_kiss.opy]: force fire after 5s":
    @Event eachPlayer
    @Hero widowmaker
    @Condition eventPlayer.isFiringSecondaryFire() == true
    @Condition eventPlayer.hasSpawned() == true
    
    eventPlayer.setDamageDealt(87.5)
    eventPlayer.Widow_maxscope_duration = 100
    createProgressBarInWorldText(eventPlayer, eventPlayer.Widow_maxscope_duration, "Focus", updateEveryFrame(eventPlayer.getEyePosition() + (100 * (0.3 * (directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90)) + 3 * eventPlayer.getFacingDirection()))), 0.7)
    eventPlayer.Widow_Focus_HUD = getLastCreatedText()
    chaseAtRate(eventPlayer.Widow_maxscope_duration, 0, 25)
    waitUntil(not eventPlayer.isFiringSecondaryFire() or eventPlayer.isHoldingButton(Button.PRIMARY_FIRE), 4)
    if eventPlayer.isHoldingButton(Button.PRIMARY_FIRE):
        eventPlayer.forceButtonPress(Button.SECONDARY_FIRE)
    elif eventPlayer.isFiringSecondaryFire():
        eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
        eventPlayer.forceButtonPress(Button.SECONDARY_FIRE)
    stopChasingVariable(eventPlayer.Widow_maxscope_duration)
    destroyProgressBarInWorldText(eventPlayer.Widow_Focus_HUD)
    eventPlayer.setSecondaryFireEnabled(false)
    wait(0.34)
    eventPlayer.setSecondaryFireEnabled(true)


rule "[widowmaker/widows_kiss.opy]: unscope / reset":
    @Event eachPlayer
    @Hero widowmaker
    @Condition eventPlayer.isFiringSecondaryFire() == true
    
    waitUntil(not eventPlayer.isFiringSecondaryFire(), 99999)
    stopChasingVariable(eventPlayer.Widow_maxscope_duration)
    destroyProgressBarInWorldText(eventPlayer.Widow_Focus_HUD)
    eventPlayer.Widow_Focus_HUD = null
    eventPlayer.Widow_maxscope_duration = null
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)