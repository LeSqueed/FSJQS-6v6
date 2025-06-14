def initSoldier():
    @Name "[soldier/init.opy]: initSoldier()"
    
    #eventPlayer.custom_hp_pvar[0] = 200
    #eventPlayer.custom_hp_pvar[1] = 0
    #eventPlayer.custom_hp_pvar[2] = 0
    #applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2310
    eventPlayer.macro_pvar[1] = 0.875
    eventPlayer.setHealingDealt(100 * eventPlayer.macro_pvar[1])
    eventPlayer.setAmmo(0, 30)
    eventPlayer.setMaxAmmo(0, 30)
    eventPlayer.hero_initialized = true


rule "[soldier/init.opy]: Increase Heavy Pulse Rifle damage":
    @Event playerDealtDamage
    @Hero soldier
    @Condition eventAbility == Button.PRIMARY_FIRE
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] * 1.053 - eventDamage) / eventPlayer.macro_pvar[0])