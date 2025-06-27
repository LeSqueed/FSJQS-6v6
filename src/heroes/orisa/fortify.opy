rule "[orisa/fortify.opy]: -10% damage reduction and shorter cooldown = 10s":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isUsingAbility1() == true
    
    #I don't know where this value comes from or how to calculate it
    damage(eventPlayer, null, 125.7)
    eventPlayer.Orisa_fortified = true
    eventPlayer._current_move_speed += 10
    eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)
    eventPlayer._current_damage_received += 30
    eventPlayer.setDamageReceived(eventPlayer._current_damage_received)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.ORANGE, eventPlayer, 8)
    createEffect(getAllPlayers(), Effect.RING, Color.ORANGE, eventPlayer, 8, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.Orisa_ring_effect = getLastCreatedEntity()
    waitUntil(not eventPlayer.isUsingAbility1(), Math.INFINITY)
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 10)
    eventPlayer._current_damage_received -= 30
    destroyEffect(eventPlayer.Orisa_ring_effect)
    eventPlayer.setDamageReceived(eventPlayer._current_damage_received)
    eventPlayer._current_move_speed -= 10
    eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)
    eventPlayer.Orisa_fortified = null


rule "[orisa/fortify.opy]: Orisa Fortify others by 20%":
    @Event eachPlayer
    @Condition getPlayersOnHero(Hero.ORISA, eventPlayer.getTeam()).isUsingAbility1() == true
    @Condition distance(eventPlayer, getPlayersOnHero(Hero.ORISA, eventPlayer.getTeam())) < 8
    
    eventPlayer._current_damage_received -= 20
    eventPlayer.setDamageReceived(eventPlayer._current_damage_received)
    waitUntil(distance(eventPlayer, getPlayersOnHero(Hero.ORISA, eventPlayer.getTeam())) > 8 or not getPlayersOnHero(Hero.ORISA, eventPlayer.getTeam()).isUsingAbility1(), Math.INFINITY)
    eventPlayer._current_damage_received += 20
    eventPlayer.setDamageReceived(eventPlayer._current_damage_received)


rule "[orisa/fortify.opy]: Orisa cancel fortify after 3s":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isUsingAbility1() == true
    
    wait(3)
    eventPlayer.forceButtonPress(Button.ABILITY_1)


rule "[orisa/fortify.opy]: Orisa cancel spin after 1s":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isUsingAbility2() == true
    
    eventPlayer.setDamageDealt(100)
    waitUntil(not eventPlayer.isUsingAbility2(), 1)
    eventPlayer.forceButtonPress(Button.ABILITY_2)
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)