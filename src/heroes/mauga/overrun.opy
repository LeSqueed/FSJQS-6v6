#!mainFile "../../main.opy"

rule "[mauga/overrun.opy]: Reduce Mauga stomp damage":
    @Event playerDealtDamage
    @Hero mauga
    @Condition eventAbility == Button.ABILITY_1

    heal(victim, null, eventDamage - 0.667 * eventDamage / eventPlayer._base_damage_scalar)


rule "[mauga/overrun.opy]: Overrun logic":
    @Event eachPlayer
    @Hero mauga
    @Condition eventPlayer.isUsingAbility1() == true

    eventPlayer._current_move_speed -= 10
    eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)
    eventPlayer._current_damage_received += 50
    eventPlayer.setDamageReceived(eventPlayer._current_damage_received)
    wait(0.32)
    waitUntil(not eventPlayer.isUsingAbility1() or eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) or eventPlayer.isHoldingButton(Button.JUMP), 2.6)
    eventPlayer._current_move_speed += 10
    eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)
    eventPlayer._current_damage_received -= 50
    eventPlayer.setDamageReceived(eventPlayer._current_damage_received)


rule "[mauga/overrun.opy]: Doomfist punch track":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.isFiringSecondaryFire() == true

    eventPlayer.DoomPunchTrack = false
    waitUntil(not eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) or not eventPlayer.isFiringSecondaryFire(), 1.6)
    eventPlayer.DoomPunchTrack = true


rule "[mauga/overrun.opy]: Reinhardt charge track":
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer.isUsingAbility1() == true

    eventPlayer.ReinChargeTrack = true
    waitUntil(not eventPlayer.isUsingAbility1(), 5)
    eventPlayer.ReinChargeTrack = false


rule "[mauga/overrun.opy]: Mauga overrun knockdown":
    @Event playerDealtDamage
    @Hero mauga
    @Condition eventAbility == Button.ABILITY_1
    @Condition (victim.getHero() == Hero.REINHARDT and victim.ReinChargeTrack or victim.getHero() == Hero.DOOMFIST and victim.isFiringSecondaryFire() and victim.DoomPunchTrack or victim.getHero() == Hero.BRIGITTE and victim.isFiringSecondaryFire() and victim.isFiringPrimaryFire()) == true
    @Condition abs(angleDifference(eventPlayer.getHorizontalFacingAngle(), victim.getHorizontalFacingAngle() * -1)) <= 90

    eventPlayer.cancelPrimaryAction()
    eventPlayer.setStatusEffect(victim, Status.KNOCKED_DOWN, 1.7)
    victim.setStatusEffect(eventPlayer, Status.KNOCKED_DOWN, 1.7)
    wait(0.09)
    victim.applyImpulse(victim.getVelocity() * -1, 0.001, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
