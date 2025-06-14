def initLucio():
    @Name "[lucio/init.opy]: initLucio()"
    
    #eventPlayer.custom_hp_pvar[0] = 200
    #eventPlayer.custom_hp_pvar[1] = 0
    #eventPlayer.custom_hp_pvar[2] = 0
    #applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2940
    eventPlayer.macro_pvar[0] = 0.444
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.startScalingSize(0.96)
    eventPlayer.hero_initialized = true


rule "[lucio/init.opy]: Correct Lucio melee damage":
    @Event playerDealtDamage
    @Hero lucio
    @Condition eventAbility == Button.MELEE
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[lucio/init.opy]: Correct Sonic Amplifier damage":
    @Event playerDealtDamage
    @Hero lucio
    @Condition eventAbility == Button.PRIMARY_FIRE
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] * 0.909 - eventDamage) / eventPlayer.macro_pvar[0])

