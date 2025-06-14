def initTracer():
    @Name "[tracer/init.opy]: initTracer()"
    
    #eventPlayer.setHealingReceived(0)
    #eventPlayer.addHealthPool(Health.NORMAL, 1, true)
    #eventPlayer.addHealthPool(Health.ARMOR, 1, true)
    #eventPlayer.addHealthPool(Health.SHIELDS, 1, true)
    #eventPlayer.removeAllHealthPools()
    #__end__()
    eventPlayer.ult_charge_pvar[1] = 1250
    eventPlayer.macro_pvar[0] = 0.964
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.startScalingSize(0.96)
    eventPlayer.max_health_scaler = 0.857
    eventPlayer.hero_initialized = true


rule "[tracer/init.opy]: Correct melee and Pulse Bomb damage":
    @Event playerDealtDamage
    @Hero tracer
    @Condition eventAbility in [Button.MELEE, Button.ULTIMATE] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])
