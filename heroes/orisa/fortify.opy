rule "[orisa/fortify.opy]: -10% damage reduction and shorter cooldown = 10s":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isUsingAbility1() == true
    
    #I don't know where this value comes from or how to calculate it
    damage(eventPlayer, null, 125.7)
    eventPlayer.Orisa_fortified = true
    eventPlayer.MoveSpeed += 10
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    eventPlayer.DamageRecieved += 30
    eventPlayer.setDamageReceived(eventPlayer.DamageRecieved)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.ORANGE, eventPlayer, 8)
    createEffect(getAllPlayers(), Effect.RING, Color.ORANGE, eventPlayer, 8, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.Orisa_ring_effect = getLastCreatedEntity()
    waitUntil(not eventPlayer.isUsingAbility1(), 99999)
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 10)
    eventPlayer.DamageRecieved -= 30
    destroyEffect(eventPlayer.Orisa_ring_effect)
    eventPlayer.setDamageReceived(eventPlayer.DamageRecieved)
    eventPlayer.MoveSpeed -= 10
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    eventPlayer.Orisa_fortified = null


rule "[orisa/fortify.opy]: Orisa Fortify others by 20%":
    @Event eachPlayer
    @Condition getPlayersOnHero(Hero.ORISA, eventPlayer.getTeam()).isUsingAbility1() == true
    @Condition distance(eventPlayer, getPlayersOnHero(Hero.ORISA, eventPlayer.getTeam())) < 8
    
    eventPlayer.DamageRecieved -= 20
    eventPlayer.setDamageReceived(eventPlayer.DamageRecieved)
    waitUntil(distance(eventPlayer, getPlayersOnHero(Hero.ORISA, eventPlayer.getTeam())) > 8 or not getPlayersOnHero(Hero.ORISA, eventPlayer.getTeam()).isUsingAbility1(), 99999)
    eventPlayer.DamageRecieved += 20
    eventPlayer.setDamageReceived(eventPlayer.DamageRecieved)


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
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])