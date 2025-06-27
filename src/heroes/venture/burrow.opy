rule "[venture/burrow.opy]: Burrow speed decrease and dash cooldown 0":
    @Event eachPlayer
    @Hero venture
    @Condition eventPlayer.isUsingAbility1() == true
    
    waitUntil(eventPlayer.isOnGround(), 7)
    wait(0.6, Wait.ABORT_WHEN_FALSE)
    if eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE) != 0 and not eventPlayer.isFiringSecondaryFire():
        eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, 0)
    eventPlayer._current_move_speed -= 70
    eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)
    waitUntil(not eventPlayer.isUsingAbility1(), Math.INFINITY)
    eventPlayer._current_move_speed += 70
    eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)
    if eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE) != 0 and not eventPlayer.isFiringSecondaryFire():
        eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, 0)


rule "[venture/burrow.opy]: Burrow speed increase when dashing":
    @Event eachPlayer
    @Hero venture
    @Condition eventPlayer.isUsingAbility1() == true
    @Condition eventPlayer.isFiringSecondaryFire() == true
    
    eventPlayer._current_move_speed += 110
    eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)
    waitUntil(not eventPlayer.isFiringSecondaryFire(), Math.INFINITY)
    eventPlayer._current_move_speed -= 110
    eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)


rule "[venture/burrow.opy]: Correct Burrow damage":
    @Event playerDealtDamage
    @Hero venture
    @Condition eventAbility == Button.ABILITY_1
    
    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar * 0.55 - eventDamage) / eventPlayer._base_damage_scalar)


rule "[venture/burrow.opy]: Burrow Knockup":
    @Event playerDealtDamage
    @Hero venture
    @Condition eventAbility == Button.ABILITY_1
    
    victim.applyImpulse(Vector.UP, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)