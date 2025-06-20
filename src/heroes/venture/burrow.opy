rule "[venture/burrow.opy]: Burrow speed decrease and dash cooldown 0":
    @Event eachPlayer
    @Hero venture
    @Condition eventPlayer.isUsingAbility1() == true
    
    waitUntil(eventPlayer.isOnGround(), 7)
    wait(0.6, Wait.ABORT_WHEN_FALSE)
    if eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE) != 0 and not eventPlayer.isFiringSecondaryFire():
        eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, 0)
    eventPlayer.MoveSpeed -= 70
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    waitUntil(not eventPlayer.isUsingAbility1(), 99999)
    eventPlayer.MoveSpeed += 70
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    if eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE) != 0 and not eventPlayer.isFiringSecondaryFire():
        eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, 0)


rule "[venture/burrow.opy]: Burrow speed increase when dashing":
    @Event eachPlayer
    @Hero venture
    @Condition eventPlayer.isUsingAbility1() == true
    @Condition eventPlayer.isFiringSecondaryFire() == true
    
    eventPlayer.MoveSpeed += 110
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    waitUntil(not eventPlayer.isFiringSecondaryFire(), 99999)
    eventPlayer.MoveSpeed -= 110
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)


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