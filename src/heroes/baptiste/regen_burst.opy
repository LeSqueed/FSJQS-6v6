rule "[baptiste/regen_burst.opy]: Correct regenerative burst hps":
    @Event playerDealtHealing
    @Hero baptiste
    @Condition eventAbility == Button.ABILITY_1
    
    if healee == healer:
        heal(healee, healer, eventHealing / eventPlayer._base_healing_scalar * 3.75 - eventHealing)
    else:
        heal(healee, healer, eventHealing / eventPlayer._base_healing_scalar * 2.125 - eventHealing)


rule "[baptiste/regen_burst.opy]: Remove initial burst healing from Regenerative Burst and set cooldown for duplicate":
    @Event eachPlayer
    @Hero baptiste
    @Condition eventPlayer.isUsingAbility1() == true
    
    eventPlayer.setHealingDealt(0)
    waitUntil(not eventPlayer.isUsingAbility1(), Math.INFINITY)
    eventPlayer.setHealingDealt(100 * eventPlayer._base_healing_scalar)
