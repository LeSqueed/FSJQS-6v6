#!mainFile "../../main.opy"

rule "[wreckingball/grapple.opy]: Force Grappling Hook cooldown":
    @Event eachPlayer
    @Hero wreckingBall
    @Condition eventPlayer.isFiringSecondaryFire() == true

    waitUntil(eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE) > 0, Math.INFINITY)
    if eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE) <= 1:
        eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, 1.92)


rule "[wreckingball/grapple.opy]: Increase Fireball impact damage":
    @Event playerDealtDamage
    @Hero wreckingBall
    @Condition eventAbility == Button.SECONDARY_FIRE

    damage(victim, attacker, (0.833 * (eventDamage / eventPlayer._base_damage_scalar) - eventDamage) / eventPlayer._base_damage_scalar)