#!mainFile "../../main.opy"

rule "[illari/solar_rifle.opy]: Correct Solar Rifle damage":
    @Event playerDealtDamage
    @Hero illari
    @Condition eventAbility == Button.PRIMARY_FIRE

    if eventWasCriticalHit:
        damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar * 1.143 - eventDamage) / eventPlayer._base_damage_scalar)
    else:
        damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar - eventDamage) / eventPlayer._base_damage_scalar)


rule "[illari/solar_rifle.opy]: Correct Solar Rifle healing":
    @Event eachPlayer
    @Hero illari
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true

    eventPlayer.setHealingDealt(100)
    waitUntil(not eventPlayer.isHoldingButton(Button.SECONDARY_FIRE), Math.INFINITY)
    eventPlayer.setHealingDealt(75)
