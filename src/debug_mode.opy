rule "[debug_mode.opy]: Global init":
    @Condition DEBUG_MODE == true
    
    #By Lotto
    dpsTime = createWorkshopSettingInt("Dev Tools", "Calculate DPS over seconds", 20, 1, 200, 1)
    hudSubtext(getAllPlayers(), "[{0}] -- Start/reset the DPS calculation.".format(inputBindingString(Button.INTERACT)), HudPosition.LEFT, 0, Color.GREEN, HudReeval.VISIBILITY_AND_STRING)
    hudSubtext(getAllPlayers(), "[Crouch] + [Jump] -- Spawn a bot.", HudPosition.LEFT, 1, Color.TURQUOISE, HudReeval.VISIBILITY_AND_STRING)
    hudSubtext(getAllPlayers(), "[Crouch] + [Melee] -- Remove all bots.", HudPosition.LEFT, 2, Color.ORANGE, HudReeval.VISIBILITY_AND_STRING)
    hudSubtext(getAllPlayers(), "Hold [Melee] -- Change Hero.", HudPosition.LEFT, 3, Color.ROSE, HudReeval.VISIBILITY_AND_STRING)
    hudSubtext(getAllPlayers(), " ", HudPosition.LEFT, 4, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)


rule "[debug_mode.opy]: Player init":
    @Event eachPlayer
    @Condition DEBUG_MODE == true
    
    chaseAtRate(eventPlayer.time, 0, 1)
    hudText(eventPlayer, eventPlayer.damage, "Total damage", null, HudPosition.LEFT, 5, Color.YELLOW, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudText(eventPlayer, eventPlayer.damage / (dpsTime - eventPlayer.time), "DPS", null, HudPosition.LEFT, 6, Color.RED, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudText(eventPlayer, eventPlayer.time, "Time", null, HudPosition.LEFT, 7, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudText(eventPlayer, eventPlayer.healing, "Total healing", null, HudPosition.LEFT, 8, Color.YELLOW, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudText(eventPlayer, eventPlayer.healing / (dpsTime - eventPlayer.time), "HPS", null, HudPosition.LEFT, 9, Color.RED, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudHeader(eventPlayer, "{0}".format(eventPlayer.getSpeed()), HudPosition.TOP, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)


rule "[debug_mode.opy]: Player Dealt Damage":
    @Event playerDealtDamage
    @Condition victim != attacker
    @Condition DEBUG_MODE == true
    
    #Inspired by a damage numbers mode by Darwin
    destroyInWorldText(eventPlayer.textID)
    eventPlayer.position = victim.getEyePosition()
    createInWorldText(eventPlayer, eventDamage, eventPlayer.position, 0.85 + eventDamage / 30, Clip.SURFACES, WorldTextReeval.VISIBILITY_POSITION_AND_STRING)
    eventPlayer.textID = getLastCreatedText()
    chaseAtRate(eventPlayer.position, victim.getEyePosition() + Vector.UP, 0.9, ChaseRateReeval.NONE)
    if eventPlayer.time == 0:
        goto lbl_0
    eventPlayer.damage += eventDamage
    lbl_0:


rule "[debug_mode.opy]: Start":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == true
    @Condition DEBUG_MODE == true
    
    eventPlayer.time = dpsTime
    eventPlayer.damage = 0
    eventPlayer.healing = 0


rule "[debug_mode.opy]: Spawn bot":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.CROUCH) == true
    @Condition eventPlayer.isHoldingButton(Button.JUMP) == true
    @Condition DEBUG_MODE == true
    
    createDummy(Hero.ANA, getOppositeTeam(eventPlayer.getTeam()), -1, eventPlayer.getPosition(), eventPlayer.getFacingDirection())
    bot = getLastCreatedEntity()
    wait(0.1)
    bot.setMaxHealth(1000)
    bot.startHealingOverTime(null, Math.INFINITY, 50)


rule "[debug_mode.opy]: Remove all bots":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.CROUCH) == true
    @Condition eventPlayer.isHoldingButton(Button.MELEE) == true
    @Condition DEBUG_MODE == true
    
    destroyAllDummies()
    destroyInWorldText(eventPlayer.textID)


rule "[debug_mode.opy]: Change hero":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.MELEE) == true
    @Condition DEBUG_MODE == true
    
    wait(1, Wait.ABORT_WHEN_FALSE)
    eventPlayer.position = eventPlayer.getPosition()
    eventPlayer.setAllowedHeroes(getAllHeroes().exclude(eventPlayer.getHero()))
    wait(0.1)
    eventPlayer.setAllowedHeroes(getAllHeroes())
    destroyInWorldText(eventPlayer.textID)
    waitUntil(eventPlayer.hasSpawned(), 99999)
    eventPlayer.teleport(eventPlayer.position)


rule "[debug_mode.opy]: Player Dealt Damage":
    @Event playerDealtHealing
    @Condition healee != healer
    @Condition DEBUG_MODE == true
    
    #Inspired by a damage numbers mode by Darwin
    destroyInWorldText(eventPlayer.textID)
    eventPlayer.position = healee.getEyePosition()
    createInWorldText(eventPlayer, eventHealing, eventPlayer.position, 0.85 + eventDamage / 30, Clip.SURFACES, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.YELLOW)
    eventPlayer.textID = getLastCreatedText()
    chaseAtRate(eventPlayer.position, healee.getEyePosition() + Vector.UP, 0.9, ChaseRateReeval.NONE)
    if eventPlayer.time == 0:
        goto lbl_0
    eventPlayer.healing += eventHealing
    lbl_0:


rule "[debug_mode.opy]: Test Roadhog and Sombra new abilities":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.MELEE) == true
    @Condition DEBUG_MODE == true
    
    eventPlayer.Roadhog_vape_confirmed = true
    eventPlayer.Sombra_virus_confirmed = true
    eventPlayer.hazard_bubble_confirmed = true
    eventPlayer.Hanzo_Marked_icon = true
