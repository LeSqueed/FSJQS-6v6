#!include "heroes/doomfist/meteor_strike.opy"
#!include "heroes/doomfist/punch.opy"
#!include "heroes/doomfist/powerblock.opy"

def initDoomfist():
    @Name "[doomfist/init.opy]: initDoomfist()"
    @Disabled
    
    eventPlayer.custom_hp_pvar[0] = 450
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1750
    removeTankPassive()
    eventPlayer.macro_pvar[0] = 0.8
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.max_health_scaler = 0.625
    eventPlayer.hero_initialized = true

rule "[doomfist/init.opy]: Correct Seismic Slam damage":
    @Event playerDealtDamage
    @Hero doomfist
    @Condition eventAbility == Button.ABILITY_1
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] * 0.8 - eventDamage) / eventPlayer.macro_pvar[0])

rule "[doomfist/init.opy]: Correct Hand Cannon damage":
    @Event playerDealtDamage
    @Hero doomfist
    @Condition eventAbility == Button.PRIMARY_FIRE
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] * 0.91 - eventDamage) / eventPlayer.macro_pvar[0])
