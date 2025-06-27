#!mainFile "../../main.opy"

def initReaper():
    @Name "[reaper/init.opy]: initReaper()"
    
    eventPlayer.custom_hp_pvar[0] = 0
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1900
    eventPlayer._base_damage_scalar = 0.922
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer._base_healing_scalar = 1.2
    eventPlayer.setHealingDealt(100 * eventPlayer._base_healing_scalar)
    eventPlayer._max_health_scalar = HeroHealthPercentage.REAPER / 100
    eventPlayer.hero_initialized = true


rule "[reaper/init.opy]: Increase Reaper melee damage":
    @Event playerDealtDamage
    @Hero reaper
    @Condition eventAbility == Button.MELEE
    
    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar - eventDamage) / eventPlayer._base_damage_scalar)


rule "[reaper/init.opy]: Reduce Death Blossom damage":
    @Event eachPlayer
    @Hero reaper
    @Condition eventPlayer.isUsingUltimate() == true
    
    eventPlayer.setDamageDealt(91.892)
    waitUntil(not eventPlayer.isUsingUltimate(), Math.INFINITY)
    eventPlayer.setDamageDealt(98.148)
