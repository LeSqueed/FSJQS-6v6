def initFreja():
    @Name "[freja/init.opy]: initFreja()"
    
    #eventPlayer.custom_hp_pvar[0] = 200
    #eventPlayer.custom_hp_pvar[1] = 0
    #eventPlayer.custom_hp_pvar[2] = 0
    #applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1750
    eventPlayer.macro_pvar[0] = 0.667
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.startScalingSize(0.96)
    eventPlayer.hero_initialized = true


rule "[freja/init.opy]: Correct Freja other forms of damage":
    @Event playerDealtDamage
    @Hero freja
    @Condition eventAbility == Button.MELEE
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[freja/init.opy]: Correct Freja secondary impact damage":
    @Event playerDealtDamage
    @Hero freja
    @Condition eventAbility == Button.SECONDARY_FIRE
    @Condition eventDamage < 59
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[freja/init.opy]: Correct Freja ultimate impact damage":
    @Event playerDealtDamage
    @Hero freja
    @Condition eventAbility == Button.ULTIMATE
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])
    wait(1.3)