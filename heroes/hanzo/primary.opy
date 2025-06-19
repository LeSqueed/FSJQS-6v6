rule "[hanzo/primary.opy]: Hanzo draw aura":
    @Event eachPlayer
    @Hero hanzo
    @Condition eventPlayer.isFiringPrimaryFire() == true
    
    #max draw time
    #wait(0.8, Wait.ABORT_WHEN_FALSE)
    createEffect([player for player in getPlayers(getOppositeTeam(eventPlayer.getTeam())) if distance(eventPlayer, player) >= 1 and eventPlayer.isInViewAngle(player.getEyePosition(), 30) and player.Hanzo_Marked_icon == true], Effect.GOOD_AURA, rgb(239, 47, 60, 125), eventPlayer.getEyePosition(), 0.475, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.HanzoDrawAura = getLastCreatedEntity()
    waitUntil(not eventPlayer.isFiringPrimaryFire(), 100000000)
    destroyEffect(eventPlayer.HanzoDrawAura)