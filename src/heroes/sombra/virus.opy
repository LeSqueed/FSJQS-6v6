rule "[sombra/virus.opy]: Sombra Virus Cancel":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.isUsingAbility1() == true
    
    wait(0.04)
    eventPlayer.cancelPrimaryAction()


rule "[sombra/virus.opy]: Target Teammate":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0
    
    eventPlayer.Sombra_virus_target = (sorted([player for player in getLivingPlayers(eventPlayer.getTeam()) if angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getEyePosition(), player)) <= 30 and player.hasSpawned() and distance(eventPlayer, player) <= 20 and player != eventPlayer and isInLoS(eventPlayer, player)], lambda i: angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getEyePosition(), i))))[0]
    wait(0.16)
    if ruleCondition:
        loop()


rule "[sombra/virus.opy]: Target Teammate HUD and allow Virus":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.Sombra_virus_target != null
    
    #targeting hud
    createInWorldText(eventPlayer if eventPlayer.Sombra_virus_target != null and eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0 else null, " \n\n\n\n\n\n     ︿\n〈      〉\n     ﹀ ", eventPlayer.Sombra_virus_target + vect(0, 0.7, 0), 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, rgb(55, 230, 255, 210))
    eventPlayer._sombra_virus_target_hud = getLastCreatedText()
    eventPlayer.allowButton(Button.ABILITY_1)


rule "[sombra/virus.opy]: Disallow Virus":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.Sombra_virus_target == null
    
    eventPlayer.disallowButton(Button.ABILITY_1)
    destroyInWorldText(eventPlayer._sombra_virus_target_hud)


rule "[sombra/virus.opy]: Confirm Target":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.isUsingAbility1() == true
    
    eventPlayer.Sombra_virus_target.Sombra_virus_confirmed = true


rule "[sombra/virus.opy]: Buff Teammate and play effects":
    @Event eachPlayer
    @Condition eventPlayer.Sombra_virus_confirmed == true
    
    eventPlayer.Sombra_virus_confirmed = false
    bigMessage(eventPlayer, "HACKED")
    getPlayersOnHero(Hero.SOMBRA, eventPlayer.getTeam()).Sombra_virus_target = null
    createInWorldText(getAllPlayers(), abilityIconString(Hero.SOMBRA, Button.ULTIMATE), eventPlayer + vect(0, 2.5, 0), 2, Clip.SURFACES, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.PURPLE)
    eventPlayer._sombra_ally_hack_icon = getLastCreatedText()
    eventPlayer.Sombra_hack_icon = true
    eventPlayer.startHealingOverTime(getPlayersOnHero(Hero.SOMBRA, eventPlayer.getTeam()), 5, 30)
    playEffect(getAllPlayers(), DynamicEffect.GOOD_PICKUP_EFFECT, Color.PURPLE, eventPlayer, 90)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.PURPLE, eventPlayer + Vector.UP, 4)
    playEffect(getAllPlayers(), DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 80)
    eventPlayer._current_move_speed = eventPlayer._current_move_speed + 30
    eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)
    wait(5)
    eventPlayer._current_move_speed = eventPlayer._current_move_speed - 30
    eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)
    destroyInWorldText(eventPlayer._sombra_ally_hack_icon)
    eventPlayer.Sombra_hack_icon = null