#!mainFile "../../main.opy"

rule "[doomfist/seismic_slam.opy]: Correct Seismic Slam damage":
    @Event playerDealtDamage
    @Hero doomfist
    @Condition eventAbility == Button.ABILITY_1

    damage(victim, eventPlayer, (eventDamage / eventPlayer._base_damage_scalar * 0.8 - eventDamage) / eventPlayer._base_damage_scalar)
