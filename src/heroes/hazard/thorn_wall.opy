#!mainFile "../../main.opy"

rule "[hazard/thorn_wall.opy]: Haz cancel wall":
    @Event eachPlayer
    @Hero hazard
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2) == true
    
    #@Condition eventPlayer.isUsingAbility2() == true
    if eventPlayer.Hazard_Bubble_Allowed == true:
        wait(0.14)
        eventPlayer.cancelPrimaryAction()


rule "[hazard/thorn_wall.opy]: Target Teammate":
    @Event eachPlayer
    @Hero hazard
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0
    
    eventPlayer.hazard_bubble_target = (sorted([player for player in getLivingPlayers(eventPlayer.getTeam()) if angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getEyePosition(), player)) <= 30 and player.hasSpawned() and distance(eventPlayer, player) <= 25 and player != eventPlayer and isInLoS(eventPlayer, player)], lambda i: angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getEyePosition(), i))))[0]
    wait(0.16)
    if ruleCondition:
        loop()


rule "[hazard/thorn_wall.opy]: Target Teammate HUD and allow bubble":
    @Event eachPlayer
    @Hero hazard
    @Condition eventPlayer.hazard_bubble_target != null
    
    #targeting hud
    createInWorldText(eventPlayer if eventPlayer.hazard_bubble_target != null and eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0 else null, " \n\n\n\n\n\n     ︿\n〈      〉\n     ﹀ ", eventPlayer.hazard_bubble_target + vect(0, 0.7, 0), 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, rgb(55, 230, 255, 210))
    eventPlayer._hazard_bubble_target_hud = getLastCreatedText()
    eventPlayer.setAbility2Enabled(true)
    eventPlayer.Hazard_Bubble_Allowed = true


rule "[hazard/thorn_wall.opy]: Disallow bubble":
    @Event eachPlayer
    @Hero hazard
    @Condition eventPlayer.hazard_bubble_target == null
    
    eventPlayer.setAbility2Enabled(false)
    destroyInWorldText(eventPlayer._hazard_bubble_target_hud)
    eventPlayer.Hazard_Bubble_Allowed = false


rule "[hazard/thorn_wall.opy]: Confirm Target":
    @Event eachPlayer
    @Hero hazard
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2) == true
    @Condition eventPlayer.isAlive() == true

    if eventPlayer.Hazard_Bubble_Allowed == true:
        eventPlayer.setAbilityCooldown(Button.ABILITY_2, 10)
        eventPlayer.hazard_bubble_target.hazard_bubble_confirmed = true


rule "[hazard/thorn_wall.opy]: Buff Teammate and play effects":
    @Event eachPlayer
    @Condition eventPlayer.hazard_bubble_confirmed == true
    
    eventPlayer.hazard_bubble_confirmed = false
    createEffect(getAllPlayers(), Effect.BAD_AURA, Color.PURPLE, eventPlayer, 0.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.hazard_bubble_effect = getLastCreatedEntity()
    createEffect([player for player in getAllPlayers() if player != eventPlayer], Effect.SPHERE, Color.PURPLE, eventPlayer, 1.2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.hazard_bubble_effect2 = getLastCreatedEntity()
    getPlayersOnHero(Hero.HAZARD, eventPlayer.getTeam()).hazard_bubble_target = null
    eventPlayer.hazard_bubble_icon = true
    bigMessage(eventPlayer, "{0} Bubbled".format(heroIcon(Hero.HAZARD)))
    playEffect(getAllPlayers(), DynamicEffect.BUFF_IMPACT_SOUND, Color.WHITE, eventPlayer, 80)
    eventPlayer._current_damage_received -= 50
    eventPlayer.setDamageReceived(eventPlayer._current_damage_received)
    waitUntil(not eventPlayer.isAlive() or eventPlayer.hero_initialized == false, 2.25)
    eventPlayer._current_damage_received += 50
    eventPlayer.setDamageReceived(eventPlayer._current_damage_received)
    destroyEffect(eventPlayer.hazard_bubble_effect)
    destroyEffect(eventPlayer.hazard_bubble_effect2)
    eventPlayer.hazard_bubble_icon = null
    eventPlayer.hazard_bubble_effect = null
    eventPlayer.hazard_bubble_effect2 = null


rule "[hazard/thorn_wall.opy]: Return Damage to attacker and heal hazard":
    @Event playerTookDamage
    @Condition eventPlayer.hazard_bubble_icon == true
    
    damage(attacker, getPlayersOnHero(Hero.HAZARD, eventPlayer.getTeam()), eventDamage / 2)
    playEffect(eventPlayer, DynamicEffect.DEBUFF_IMPACT_SOUND, Color.WHITE, eventPlayer, 80)
    playEffect(victim, DynamicEffect.DEBUFF_IMPACT_SOUND, Color.WHITE, victim, 70)
    getPlayersOnHero(Hero.HAZARD, eventPlayer.getTeam()).hazard_overhealth_converted = getPlayersOnHero(Hero.HAZARD, eventPlayer.getTeam()).hazard_overhealth_converted + eventDamage / 4


rule "[hazard/thorn_wall.opy]: Make immune to CC after 0.1s":
    @Event eachPlayer
    @Condition (eventPlayer.hasStatus(Status.STUNNED) or eventPlayer.hasStatus(Status.ROOTED) or eventPlayer.hasStatus(Status.FROZEN) or eventPlayer.hasStatus(Status.ASLEEP) or eventPlayer.hasStatus(Status.KNOCKED_DOWN)) == true
    @Condition eventPlayer.hazard_bubble_icon == true
    
    if eventPlayer.hazard_bubble_icon == true:
        wait(0.1)
        eventPlayer.clearStatusEffect(Status.KNOCKED_DOWN)
        eventPlayer.clearStatusEffect(Status.ASLEEP)
        eventPlayer.clearStatusEffect(Status.FROZEN)
        eventPlayer.clearStatusEffect(Status.ROOTED)
        eventPlayer.clearStatusEffect(Status.STUNNED)


rule "[hazard/thorn_wall.opy]: Wait and give Hazard Overhealth":
    @Event eachPlayer
    @Hero hazard
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) != 0

    wait(2.25)
    eventPlayer.hazard_overhealth_converted = min(eventPlayer.hazard_overhealth_converted, 150)
    eventPlayer.addHealthPool(Health.NORMAL, ceil(eventPlayer.hazard_overhealth_converted), false, false)
    eventPlayer.hazard_overhealth_id = getLastCreatedHealthPool()
    eventPlayer.hazard_overhealth_converted = null
    wait(5)
    removeHealthPool(eventPlayer.hazard_overhealth_id)
    eventPlayer.hazard_overhealth_id = null