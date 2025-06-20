rule "[echo/copy.opy] Echo new ultimate":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE) == true
    @Condition eventPlayer.hero_setup == Hero.ECHO
    
    if eventPlayer.isAlive() == true and eventPlayer.getUltCharge() == 100:
        getPlayers(eventPlayer.getTeam()).Echo_Copy = true
        eventPlayer.startForcingHero(((sorted([player for player in getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())) if angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getEyePosition(), player)) <= 19 and player.hasSpawned() and distance(eventPlayer, player) <= 40 and player != getPlayersOnHero(Hero.ECHO, Team.ALL) and isInLoS(eventPlayer, player)], lambda i: angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getEyePosition(), i))))[0]).getHero())
        if eventPlayer.getHero() != Hero.ECHO:
            eventPlayer.setStatusEffect(null, Status.FROZEN, 1)
            eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 1)
            wait(1.1)
            eventPlayer.setUltCharge(92)
            EchoCopy()
            waitUntil(not eventPlayer.isAlive(), 16)
            destroyProgressBarInWorldText(eventPlayer._echo_copy_seconds_text)
            stopChasingVariable(eventPlayer.EchoUltSeconds)
            eventPlayer.startForcingHero(Hero.ECHO)
            eventPlayer.stopForcingCurrentHero()
            getPlayers(eventPlayer.getTeam()).Echo_Copy = false
            eventPlayer.hero_initialized = false
            eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 1)