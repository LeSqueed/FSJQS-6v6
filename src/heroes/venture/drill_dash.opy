#!mainFile "../../main.opy"

rule "[venture/drill_dash.opy]: Correct Drill Dash damage":
    @Event playerDealtDamage
    @Hero venture
    @Condition eventAbility == Button.SECONDARY_FIRE

    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar * 0.444 - eventDamage) / eventPlayer._base_damage_scalar)
