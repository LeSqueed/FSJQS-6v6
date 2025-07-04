#!mainFile "../../main.opy"

rule "[hazard/spike_guard.opy]: Increase damage on block to 230":
    @Event playerDealtDamage
    @Hero hazard
    @Condition eventAbility == Button.SECONDARY_FIRE

    damage(victim, attacker, (0.94 * (eventDamage / eventPlayer._base_damage_scalar) - eventDamage) / eventPlayer._base_damage_scalar)


rule "[hazard/spike_guard.opy]: Lifesteal heal 2 per spike":
    @Event playerDealtDamage
    @Hero hazard
    @Condition eventAbility == Button.SECONDARY_FIRE

    heal(eventPlayer, null, 2)