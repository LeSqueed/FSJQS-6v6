#!mainFile "../../main.opy"

rule "[sombra/heal.opy]: Healing Ring sombra":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.Sombra_invisible == false

    createEffect(getPlayers(eventPlayer.getTeam()), Effect.RING, Color.PURPLE, eventPlayer, 15, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.Sombra_healing_ring = getLastCreatedEntity()
    waitUntil(eventPlayer.Sombra_invisible == true or eventPlayer.getHero() != Hero.SOMBRA, Math.INFINITY)
    destroyEffect(eventPlayer.Sombra_healing_ring)


rule "[sombra/heal.opy]: Self Heal sombra":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.Sombra_invisible == false
    @Condition eventPlayer.isAlive() == true

    eventPlayer.startHealingOverTime(null, 1, 12 - ((len([player for player in getLivingPlayers(eventPlayer.getTeam()) if distance(eventPlayer, player) <= 15 and isInLoS(eventPlayer, player, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) and player != eventPlayer])) * 5))
    wait(1)
    if ruleCondition:
        loop()
