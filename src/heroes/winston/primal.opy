rule "[winston/primal.opy]: Remove bonus Primal Rage health":
    @Event eachPlayer
    @Hero winston
    @Condition eventPlayer.isUsingUltimate() == true
    
    clearCustomHp()
    eventPlayer.addHealthPool(Health.ARMOR, 15, true, false)
    waitUntil(not eventPlayer.isUsingUltimate(), Math.INFINITY)
    clearCustomHp()
    applyCustomHp()


rule "[winston/primal.opy]: Reduce Primal Rage damage":
    @Event eachPlayer
    @Hero winston
    @Condition eventPlayer.isUsingUltimate() == true
    
    eventPlayer.setDamageDealt(80)
    waitUntil(not eventPlayer.isUsingUltimate(), Math.INFINITY)
    #revert damage back after Primal Rage concludes
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)


rule "[winston/primal.opy]: Correct Jump Pack damage during Primal Rage":
    @Event playerDealtDamage
    @Hero winston
    @Condition eventPlayer.isUsingUltimate() == true
    @Condition eventAbility == Button.ABILITY_1
    
    damage(victim, attacker, (eventDamage / 0.8 - eventDamage) / 0.8)