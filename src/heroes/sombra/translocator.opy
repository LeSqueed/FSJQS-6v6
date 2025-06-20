rule "[sombra/translocator.opy]: Sombra Invis Increase move Speed":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.Sombra_invisible == true
    
    eventPlayer._current_move_speed = eventPlayer._current_move_speed + 10
    eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)
    waitUntil(eventPlayer.Sombra_invisible == false, 99999)
    eventPlayer._current_move_speed = eventPlayer._current_move_speed - 10
    eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)


rule "[sombra/translocator.opy] Sombra stealth damage cancel count damage":
    @Event playerTookDamage
    @Hero sombra
    @Condition eventPlayer.stealth_timer > 0
    @Condition eventPlayer.stealth_timer <= 5
    @Disabled
    
    #eventPlayer.Sombra_invis_damage += eventDamage
    #if eventPlayer.Sombra_invis_damage >= 40:
    eventPlayer.setStatusEffect(null, Status.ROOTED, 0.001)
    eventPlayer.stealth_timer = 0
    eventPlayer.Sombra_invisible = false
    #eventPlayer.Sombra_invis_damage = 0
    #else:
    #wait(1, Wait.RESTART_WHEN_TRUE)
    #eventPlayer.Sombra_invis_damage = 0
    #__end__()


rule "[sombra/translocator.opy]: When Translocator is used, begin tracking how long Sombra is in stealth":
    @Event eachPlayer
    @Condition eventPlayer.getHero() == Hero.SOMBRA
    @Condition eventPlayer.isUsingAbility2() == true
    @Disabled
    
    #eventPlayer.Sombra_invis_damage = 0
    eventPlayer.stealth_timer = 5.5
    waitUntil(not eventPlayer.isUsingAbility2(), 999999986991104)
    eventPlayer.Sombra_invisible = true
    chaseAtRate(eventPlayer.stealth_timer, 0, 1, ChaseRateReeval.NONE)
    #Sombra can't break stealth during the cast time of stealth
    wait(0.5, Wait.RESTART_WHEN_TRUE)
    #Wait until Sombra exits Stealth
    waitUntil(any([eventPlayer.hasStatus(Status.ASLEEP), eventPlayer.hasStatus(Status.FROZEN), eventPlayer.hasStatus(Status.HACKED), eventPlayer.hasStatus(Status.KNOCKED_DOWN), eventPlayer.hasStatus(Status.STUNNED), eventPlayer.hasStatus(Status.ROOTED)]) or eventPlayer.Sombra_invisible == false or eventPlayer.isFiringPrimaryFire() or eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) and not eventPlayer.isFiringSecondaryFire() or eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0 and eventPlayer.isHoldingButton(Button.ABILITY_1) or eventPlayer.isHoldingButton(Button.MELEE) or eventPlayer.isMeleeing() or eventPlayer.isUsingUltimate() or eventPlayer.stealth_pvar[1] == 100 and eventPlayer.isHoldingButton(Button.ULTIMATE), 5)
    eventPlayer.Sombra_invisible = false
    stopChasingVariable(eventPlayer.stealth_timer)
    if eventPlayer.stealth_timer <= 0:
        return
    if NEGATIVE_STATUS_PREVENTS_REFUND:
        if any([eventPlayer.hasStatus(Status.ASLEEP), eventPlayer.hasStatus(Status.FROZEN), eventPlayer.hasStatus(Status.HACKED), eventPlayer.hasStatus(Status.KNOCKED_DOWN), eventPlayer.hasStatus(Status.STUNNED), eventPlayer.hasStatus(Status.ROOTED)]):
            return
    waitUntil(eventPlayer.getAbilityCooldown(Button.ABILITY_2) > 0, 1)
    #printLog("Current Translocator Cooldown: {0} | Target Translocator Cooldown: {1}".format(eventPlayer.getAbilityCooldown(Button.ABILITY_2), eventPlayer._stealth_max_cooldown - 5 + (eventPlayer.stealth_timer * (1 - STEALTH_REFUND_FRACTION))))
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, eventPlayer.stealth_pvar[0] - 5 + (eventPlayer.stealth_timer * (1 - STEALTH_REFUND_FRACTION)))


rule "[sombra/translocator.opy]: Sombra stealth refund variables":
    STEALTH_REFUND_FRACTION = createWorkshopSettingInt("Gameplay Settings", "Percent of Stealth Timer Remaining Refunded Towards Translocator Cooldown", 40, 0, 100) / 100
    NEGATIVE_STATUS_PREVENTS_REFUND = createWorkshopSettingBool("Gameplay Settings", "Negative Status Effects Cancelling Stealth Prevents Translocator Cooldown Refund", true, 1)
    MINIMUM_TRANSLOCATOR_COOLDOWN = 4


rule "[sombra/translocator.opy]: When Translocator is used, begin tracking how long Sombra is in stealth":
    @Event eachPlayer
    @Condition eventPlayer.getHero() == Hero.SOMBRA
    @Condition eventPlayer.isUsingAbility2() == true
    
    #eventPlayer.Sombra_invis_damage = 0
    eventPlayer.stealth_timer = 4.82
    waitUntil(not eventPlayer.isUsingAbility2(), 999999986991104)
    eventPlayer.Sombra_invisible = true
    chaseAtRate(eventPlayer.stealth_timer, 0, 1, ChaseRateReeval.NONE)
    #Sombra can't break stealth during the cast time of stealth
    #wait(0.5, Wait.RESTART_WHEN_TRUE)
    #Wait until Sombra exits Stealth
    waitUntil(any([eventPlayer.hasStatus(Status.ASLEEP), eventPlayer.hasStatus(Status.FROZEN), eventPlayer.hasStatus(Status.HACKED), eventPlayer.hasStatus(Status.KNOCKED_DOWN), eventPlayer.hasStatus(Status.STUNNED), eventPlayer.hasStatus(Status.ROOTED)]) or eventPlayer.Sombra_invisible == false or eventPlayer.isFiringPrimaryFire() or eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) and not eventPlayer.isFiringSecondaryFire() or eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0 and eventPlayer.isHoldingButton(Button.ABILITY_1) or eventPlayer.isHoldingButton(Button.MELEE) or eventPlayer.isMeleeing() or eventPlayer.isUsingUltimate() or eventPlayer.stealth_pvar[1] == 100 and eventPlayer.isHoldingButton(Button.ULTIMATE), 4.82)
    eventPlayer.Sombra_invisible = false
    stopChasingVariable(eventPlayer.stealth_timer)
    if eventPlayer.stealth_timer <= 0:
        return
    if NEGATIVE_STATUS_PREVENTS_REFUND:
        if any([eventPlayer.hasStatus(Status.ASLEEP), eventPlayer.hasStatus(Status.FROZEN), eventPlayer.hasStatus(Status.HACKED), eventPlayer.hasStatus(Status.KNOCKED_DOWN), eventPlayer.hasStatus(Status.STUNNED), eventPlayer.hasStatus(Status.ROOTED)]):
            return
    waitUntil(eventPlayer.getAbilityCooldown(Button.ABILITY_2) > 0, 1)
    #printLog("Current Translocator Cooldown: {0} | Target Translocator Cooldown: {1}".format(eventPlayer.getAbilityCooldown(Button.ABILITY_2), eventPlayer._stealth_max_cooldown - 5 + (eventPlayer.stealth_timer * (1 - STEALTH_REFUND_FRACTION))))
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, eventPlayer.stealth_pvar[0] - 5 + (eventPlayer.stealth_timer * (1 - STEALTH_REFUND_FRACTION)))


rule "[sombra/translocator.opy] Sombra stealth self cancel":
    @Event eachPlayer
    @Hero sombra
    @Condition (eventPlayer.stealth_timer <= 5 and eventPlayer.stealth_timer > 0 and eventPlayer.isHoldingButton(Button.ABILITY_2)) == true
    @Condition eventPlayer.Sombra_invisible == true
    
    eventPlayer.setStatusEffect(null, Status.ROOTED, 0.001)
    eventPlayer.Sombra_invisible = false
    #printLog("Current Translocator Cooldown: {0} | Target Translocator Cooldown: {1}".format(eventPlayer.getAbilityCooldown(Button.ABILITY_2), eventPlayer._stealth_max_cooldown - 5 + (eventPlayer.stealth_timer * (1 - STEALTH_REFUND_FRACTION))))
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, eventPlayer.stealth_pvar[0] - 5 + (eventPlayer.stealth_timer * (1 - STEALTH_REFUND_FRACTION)))
    eventPlayer.stealth_timer = 0


rule "[sombra/translocator.opy]: Set max stealth cooldown observed":
    @Event eachPlayer
    @Condition eventPlayer.getHero() == Hero.SOMBRA
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) > eventPlayer.stealth_pvar[0]
    
    eventPlayer.stealth_pvar[0] = round(eventPlayer.getAbilityCooldown(Button.ABILITY_2))