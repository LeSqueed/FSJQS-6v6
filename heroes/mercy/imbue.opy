rule "[mercy/imbue.opy]: Mercy imbue target icon":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0
    @Condition eventPlayer.ImbueTargetIcon == null
    
    createInWorldText(eventPlayer if ((sorted([player for player in getPlayersInRadius(eventPlayer, 20.5, eventPlayer.getTeam(), LosCheck.SURFACES_AND_ENEMY_BARRIERS) if eventPlayer.isInViewAngle(player.getPosition(), 2.5 + 120 / distance(eventPlayer, player)) and player != eventPlayer and player.isAlive()], lambda i: angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getPosition(), i.getPosition()))))[0]) != null and not eventPlayer.isInAlternateForm() else null, "+", (((sorted([player for player in getPlayersInRadius(eventPlayer, 20.5, eventPlayer.getTeam(), LosCheck.SURFACES_AND_ENEMY_BARRIERS) if eventPlayer.isInViewAngle(player.getPosition(), 2.5 + 120 / distance(eventPlayer, player)) and player != eventPlayer and player.isAlive()], lambda i: angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getPosition(), i.getPosition()))))[0]).getEyePosition()) + vect(0, 1, 0), 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.BLUE if eventPlayer.isFiringSecondaryFire() else Color.YELLOW)
    eventPlayer.ImbueTargetIcon = getLastCreatedText()

rule "[mercy/imbue.opy]: Mercy imbue":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2) == true
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0
    @Condition ((sorted([i for i in getPlayersInRadius(eventPlayer, 20.5, eventPlayer.getTeam(), LosCheck.SURFACES_AND_ENEMY_BARRIERS).exclude(eventPlayer).exclude(getDeadPlayers(eventPlayer.getTeam())) if eventPlayer.isInViewAngle(i.getPosition(), 2.5 + 120 / distance(eventPlayer, i))], lambda i: angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getPosition(), i.getPosition()))))[0] != null or eventPlayer.isInAlternateForm()) == true
    
    #Vanilla rez cd hero setting needs to be changed if cooldown is changed so icon matches
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, 15)
    eventPlayer.setAbility2Enabled(true)
    destroyInWorldText(eventPlayer.ImbueTargetIcon)
    eventPlayer.ImbueTargetIcon = null
    #eventPlayer.ImbueSecondary = true if eventPlayer.isFiringSecondaryFire() else false
    eventPlayer.ImbueSecondary = 1 if eventPlayer.isFiringSecondaryFire() or eventPlayer.isInAlternateForm() else null
    if eventPlayer.isInAlternateForm():
        eventPlayer.ImbueTarget = eventPlayer
        eventPlayer.ImbueSecondary = 2
    else:
        #Set target
        eventPlayer.ImbueTarget = (sorted([player for player in getPlayersInRadius(eventPlayer, 20.5, eventPlayer.getTeam(), LosCheck.SURFACES_AND_ENEMY_BARRIERS) if eventPlayer.isInViewAngle(player.getPosition(), 2.5 + 120 / distance(eventPlayer, player)) and player != eventPlayer and player.isAlive()], lambda i: angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getPosition(), i.getPosition()))))[0]
        bigMessage(eventPlayer.ImbueTarget, "Damage Imbued" if eventPlayer.ImbueSecondary else "Heal Imbued")
    #Duration
    eventPlayer.ImbueDuration = 5
    chaseAtRate(eventPlayer.ImbueDuration, 0, 1)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 80)
    createBeam(getAllPlayers() if eventPlayer.ImbueTarget != null else null, Beam.BAD, eventPlayer, eventPlayer.ImbueTarget, Color.BLUE if eventPlayer.isFiringSecondaryFire() else Color.YELLOW, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.ImbueBeam = getLastCreatedEntity()
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, (Color.TEAM_1 if eventPlayer.getTeam() == Team.1 else Color.TEAM_2) if eventPlayer.ImbueSecondary else Color.YELLOW, eventPlayer.ImbueTarget, 8)
    #Destroy beam and sparkle
    wait(0.2)
    destroyEffect(eventPlayer.ImbueBeam)
    #Wait = cooldown - 0.3 (stops vanilla rez being usable the frame cooldown ends); rez cooldown needs to be changed in hero settings if cooldown is changed so icon matches
    waitUntil(eventPlayer.isDead() or eventPlayer.getAbilityCooldown(Button.ABILITY_2) <= 0.3 or eventPlayer.getHero() != Hero.MERCY, 14.7)
    if eventPlayer.getHero() != Hero.MERCY:
        return
    eventPlayer.setAbility2Enabled(false)

rule "[mercy/imbue.opy]: Mercy imbue AOE":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.ImbueDuration > 0
    @Condition eventPlayer.ImbueTarget != null
    
    #Aura visuals
    createEffect(getPlayers(Team.ALL if eventPlayer.ImbueSecondary else eventPlayer.getTeam()), Effect.RING, (Color.TEAM_1 if eventPlayer.getTeam() == Team.1 else Color.TEAM_2) if eventPlayer.ImbueSecondary else Color.YELLOW, eventPlayer.ImbueTarget, 8 if eventPlayer.ImbueSecondary else 10, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.ImbueAOERing = getLastCreatedEntity()
    if eventPlayer.ImbueSecondary:
        createEffect(getPlayers(eventPlayer.getTeam()), Effect.ENERGY_SOUND, Color.WHITE, eventPlayer.ImbueTarget, 80, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    else:
        createEffect(getPlayers(eventPlayer.getTeam()), Effect.SPARKLES_SOUND, Color.WHITE, eventPlayer.ImbueTarget, 80, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.ImbueAOESound = getLastCreatedEntity()
    #AoE
    while eventPlayer.ImbueTarget.isAlive() and eventPlayer.ImbueDuration > 0:
        #30 dps for 3 seconds
        if eventPlayer.ImbueSecondary:
            if eventPlayer.ImbueSecondary == 2 and not eventPlayer.isInAlternateForm():
                break
            getPlayersInRadius(eventPlayer.ImbueTarget, 8, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES_AND_ENEMY_BARRIERS).startDamageOverTime(eventPlayer, 0.5, 30 / eventPlayer.macro_pvar[0])
        else:
            heal(eventPlayer.ImbueTarget, eventPlayer, 4 / eventPlayer.macro_pvar[1])
            heal(getPlayersInRadius(eventPlayer.ImbueTarget, 10, eventPlayer.getTeam(), LosCheck.SURFACES_AND_ENEMY_BARRIERS).exclude(eventPlayer.ImbueTarget), eventPlayer, 6 / eventPlayer.macro_pvar[1])
        waitUntil(eventPlayer.ImbueTarget.isDead() or eventPlayer.ImbueDuration == 0, 0.5)
    destroyEffect(eventPlayer.ImbueAOERing)
    destroyEffect(eventPlayer.ImbueAOESound)
    stopChasingVariable(eventPlayer.ImbueDuration)
    eventPlayer.ImbueTarget = null
