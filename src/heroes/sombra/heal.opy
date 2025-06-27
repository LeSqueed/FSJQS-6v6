rule "[sombra/heal.opy]: Healing Ring sombra":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.Sombra_invisible == false
    
    createEffect(getPlayers(eventPlayer.getTeam()), Effect.RING, Color.PURPLE, eventPlayer, 15, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.Sombra_healing_ring = getLastCreatedEntity()
    waitUntil(eventPlayer.Sombra_invisible == true or eventPlayer.getHero() != Hero.SOMBRA, Math.INFINITY)
    destroyEffect(eventPlayer.Sombra_healing_ring)


rule "[sombra/heal.opy]: If visible heal 15m 32 - players *5 self for 12 - amount of players x 2":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.Sombra_invisible == false
    @Condition eventPlayer.isAlive() == true
    
    ([player for player in getLivingPlayers(eventPlayer.getTeam()) if distance(eventPlayer, player) <= 15 and isInLoS(eventPlayer, player) == true and player != eventPlayer]).startHealingOverTime(eventPlayer, 1, 32 - ((len([player for player in getLivingPlayers(eventPlayer.getTeam()) if distance(eventPlayer, player) <= 15 and isInLoS(eventPlayer, player, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) == true and player != eventPlayer])) * 5))
    wait(1)
    if ruleCondition:
        loop()
