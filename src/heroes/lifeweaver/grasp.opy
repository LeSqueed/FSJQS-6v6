rule "[lifeweaver/grasp.opy] Set grasp cooldown to 10s when target is above 75%hp":
    @Event eachPlayer
    @Hero lifeweaver
    @Condition eventPlayer.isUsingAbility2() == true
    
    if (((sorted([player for player in getLivingPlayers(eventPlayer.getTeam()) if angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getEyePosition(), player)) <= 50 and player.hasSpawned() and distance(eventPlayer, player) <= 30 and player != eventPlayer and isInLoS(eventPlayer, player)], lambda i: angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getEyePosition(), i))))[0]).getHealth()) >= ((((sorted([player for player in getLivingPlayers(eventPlayer.getTeam()) if angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getEyePosition(), player)) <= 50 and player.hasSpawned() and distance(eventPlayer, player) <= 30 and player != eventPlayer and isInLoS(eventPlayer, player)], lambda i: angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getEyePosition(), i))))[0]).getMaxHealth()) * 0.75):
        waitUntil(not eventPlayer.isUsingAbility2(), 99999)
        eventPlayer.setAbilityCooldown(Button.ABILITY_2, 10)
