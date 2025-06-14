def initReaper():
    @Name "[reaper/init.opy]: initReaper()"
    
    eventPlayer.custom_hp_pvar[0] = 0
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1900
    eventPlayer.macro_pvar[0] = 0.981
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.macro_pvar[1] = 1.2
    eventPlayer.setHealingDealt(100 * eventPlayer.macro_pvar[1])
    eventPlayer.hero_initialized = true


rule "[reaper/init.opy]: Increase Reaper melee damage":
    @Event playerDealtDamage
    @Hero reaper
    @Condition eventAbility == Button.MELEE
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[reaper/init.opy]: Reduce Death Blossom damage":
    @Event eachPlayer
    @Hero reaper
    @Condition eventPlayer.isUsingUltimate() == true
    
    eventPlayer.setDamageDealt(91.892)
    waitUntil(not eventPlayer.isUsingUltimate(), 999999986991104)
    eventPlayer.setDamageDealt(98.148)
