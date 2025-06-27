#!mainFile "../../main.opy"

rule "[mercy/momentum.opy]: Passive Momentum Gain":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.MercyMomentum < 100

    while eventPlayer.MercyMomentum < 100:
        eventPlayer.MercyMomentum = min(
            eventPlayer.MercyMomentum + (0.9 if not eventPlayer.isOnGround() else 0.20),
            100
        )
        wait(0.1)

rule "[mercy/momentum.opy]: Healing beam drains momentum":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.isFiringPrimaryFire() == true


    while eventPlayer.isFiringPrimaryFire() == true and eventPlayer.Overloaded == false:
        if not eventPlayer.Overloaded:
            eventPlayer.MercyMomentum = max(
                eventPlayer.MercyMomentum - (1.2 if not eventPlayer.isOnGround() else 0.9),
                0
            )
        wait(0.1)

rule "[mercy/momentum.opy]: Damage boost drains momentum":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.isFiringSecondaryFire() == true

    while eventPlayer.isFiringSecondaryFire() == true and eventPlayer.MercyMomentum > 0:
        eventPlayer.MercyMomentum = max(eventPlayer.MercyMomentum - 1.8, 0)
        wait(0.1)

rule "[mercy/momentum.opy]: Overload when momentum is 0":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.MercyMomentum <= 0

    eventPlayer.Overloaded = true
    wait(5.0)
    eventPlayer.Overloaded = false


rule "[mercy/momentum.opy]: Overloaded penalty":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.Overloaded == true

    eventPlayer.disallowButton(Button.SECONDARY_FIRE)
    eventPlayer.allowButton(Button.PRIMARY_FIRE)
    eventPlayer._current_move_speed *= 0.5
    eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)
    eventPlayer.setDamageDealt(50 * eventPlayer._base_damage_scalar)
    eventPlayer.setHealingDealt(10 * eventPlayer._base_healing_scalar)
    createEffect(getAllPlayers(), Effect.BAD_AURA, Color.PURPLE, eventPlayer.getPosition(), 2.5, EffectReeval.POSITION_AND_RADIUS)
    eventPlayer.MercyOverloadFx = getLastCreatedEntity()
    createEffect(eventPlayer, Effect.BAD_AURA_SOUND, Color.PURPLE, eventPlayer.getPosition(), 1.5, EffectReeval.POSITION_AND_RADIUS)
    eventPlayer.MercyOverloadSfx = getLastCreatedEntity()

    waitUntil(eventPlayer.Overloaded == false, Math.INFINITY)

    eventPlayer.allowButton(Button.SECONDARY_FIRE)
    eventPlayer._current_move_speed *= 2.0
    eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer.setHealingDealt(100 * eventPlayer._base_healing_scalar)
    destroyEffect(eventPlayer.MercyOverloadFx)
    eventPlayer.MercyOverloadFx = null
    destroyEffect(eventPlayer.MercyOverloadSfx)
    eventPlayer.MercyOverloadSfx = null
    