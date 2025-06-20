rule "[roadhog/pigpen.opy]: Cancel Pigpen Animation":
    @Event eachPlayer
    @Hero roadhog
    @Condition eventPlayer.isUsingAbility2() == true
    
    wait(0.08)
    eventPlayer.cancelPrimaryAction()


rule "[roadhog/pigpen.opy]: Target Teammate":
    @Event eachPlayer
    @Hero roadhog
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0
    
    eventPlayer.Roadhog_vape_target = (sorted([player for player in getLivingPlayers(eventPlayer.getTeam()) if angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getEyePosition(), player)) <= 30 and player.hasSpawned() and distance(eventPlayer, player) <= 30 and player != eventPlayer and isInLoS(eventPlayer, player)], lambda i: angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getEyePosition(), i))))[0]
    wait(0.16)
    if ruleCondition:
        loop()


rule "[roadhog/pigpen.opy]: Target Teammate HUD and allow Vape":
    @Event eachPlayer
    @Hero roadhog
    @Condition eventPlayer.Roadhog_vape_target != null
    
    #targeting hud
    createInWorldText(eventPlayer if eventPlayer.Roadhog_vape_target != null and eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0 else null, " \n\n\n\n\n\n     ︿\n〈      〉\n     ﹀ ", eventPlayer.Roadhog_vape_target + vect(0, 0.7, 0), 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, rgb(55, 230, 255, 210))
    eventPlayer._roadhog_vape_target_hud = getLastCreatedText()
    eventPlayer.allowButton(Button.ABILITY_2)


rule "[roadhog/pigpen.opy]: Disallow Vape":
    @Event eachPlayer
    @Hero roadhog
    @Condition eventPlayer.Roadhog_vape_target == null
    
    eventPlayer.disallowButton(Button.ABILITY_2)
    destroyInWorldText(eventPlayer._roadhog_vape_target_hud)


rule "[roadhog/pigpen.opy]: Confirm Target":
    @Event eachPlayer
    @Hero roadhog
    @Condition eventPlayer.isUsingAbility2() == true
    
    eventPlayer.Roadhog_vape_target.Roadhog_vape_confirmed = true


rule "[roadhog/pigpen.opy]: Buff Teammate and play effects":
    @Event eachPlayer
    @Condition eventPlayer.Roadhog_vape_confirmed == true
    
    eventPlayer.Roadhog_vape_confirmed = false
    createEffect(getAllPlayers().exclude(eventPlayer), Effect.CLOUD, Color.YELLOW, eventPlayer, 0.9, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.Roadhog_vape_effect = getLastCreatedEntity()
    getPlayersOnHero(Hero.ROADHOG, eventPlayer.getTeam()).Roadhog_vape_target = null
    eventPlayer.Roadhog_vape_hud_icon = true
    bigMessage(eventPlayer, "VAPED")
    playEffect(getAllPlayers(), DynamicEffect.EXPLOSION_SOUND, Color.WHITE, eventPlayer, 80)
    eventPlayer.startHealingOverTime(getPlayersOnHero(Hero.ROADHOG, eventPlayer.getTeam()), 3, 55)
    eventPlayer._current_damage_received -= 40
    eventPlayer.setDamageReceived(eventPlayer._current_damage_received)
    wait(3)
    eventPlayer._current_damage_received += 40
    eventPlayer.setDamageReceived(eventPlayer._current_damage_received)
    destroyEffect(eventPlayer.Roadhog_vape_effect)
    eventPlayer.Roadhog_vape_hud_icon = null