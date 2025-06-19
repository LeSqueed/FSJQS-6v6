rule "[doomfist/seismic_slam.opy]: Correct Seismic Slam damage":
    @Event playerDealtDamage
    @Hero doomfist
    @Condition eventAbility == Button.ABILITY_1
    
    damage(victim, eventPlayer, (eventDamage / eventPlayer.macro_pvar[0] * 0.8 - eventDamage) / eventPlayer.macro_pvar[0])
