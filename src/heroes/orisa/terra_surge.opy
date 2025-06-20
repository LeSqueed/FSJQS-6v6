rule "[orisa/terra_surge.opy]: Reduce Terra Surge base damage and add bonus overhealth":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isUsingUltimate() == true
    
    eventPlayer.addHealthPool(Health.NORMAL, 181, false)
    eventPlayer.terra_overhealth_id = getLastCreatedHealthPool()
    eventPlayer.setDamageDealt(80)
    waitUntil(not eventPlayer.isUsingUltimate(), 999999986991104)
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    removeHealthPool(eventPlayer.terra_overhealth_id)


rule "[orisa/terra_surge.opy]: Increase Terra Surge damage":
    @Event playerDealtDamage
    @Hero orisa
    @Condition eventAbility == Button.ULTIMATE
    #do not include wind-up damage
    @Condition eventDamage >= 50
    
    damage(victim, attacker, 100 - eventDamage)
