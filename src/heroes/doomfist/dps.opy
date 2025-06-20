def initDoomfistDPS():
    @Name "[doomfist/dps.opy]: initDoomfistDPS()"
    
    eventPlayer.custom_hp_pvar[0] = 15
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1750
    removeTankPassive()
    eventPlayer.startScalingSize(0.92)
    eventPlayer._base_damage_scalar = 0.82
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer.max_health_scaler = 0.625
    eventPlayer.hero_initialized = true


rule "[doomfist/dps.opy]: doom cap health at 400":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.getHealth() > 400
    
    eventPlayer.setHealth(400)


rule "[doomfist/dps.opy]: Increase headshot damage taken":
    @Event playerTookDamage
    @Hero doomfist
    @Condition eventWasCriticalHit == true
    
    damage(eventPlayer, attacker, eventDamage * 0.25)
