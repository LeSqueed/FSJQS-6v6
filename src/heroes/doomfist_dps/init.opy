#!mainFile "../../main.opy"

playervar punched_victims
playervar wall_impacted_victims
playervar uppercut_victims
playervar is_using_uppercut
playervar doom_uppercut_shields
playervar number_of_victims_uppercut

#!include "../doomfist/meteor_strike.opy"
#!include "../doomfist/punch.opy"
#!include "../doomfist/powerblock.opy"
#!include "../doomfist/uppercut.opy"
#!include "../doomfist/seismic_slam.opy" 
#!include "../doomfist/hand_cannon.opy"

def initDoomfist():
    @Name "[doomfist_dps/init.opy]: initDoomfist()"
    
    eventPlayer.custom_hp_pvar[0] = 15
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1750
    removeTankPassive()
    eventPlayer.startScalingSize(0.92)
    eventPlayer._base_damage_scalar = 0.82
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer._max_health_scalar = HeroHealthPercentage.DOOMFIST / 100
    eventPlayer.hero_initialized = true


rule "[doomfist_dps/init.opy]: doom cap health at 400":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.getHealth() > 400
    
    eventPlayer.setHealth(400)


rule "[doomfist_dps/init.opy]: Increase headshot damage taken":
    @Event playerTookDamage
    @Hero doomfist
    @Condition eventWasCriticalHit == true
    
    damage(eventPlayer, attacker, eventDamage * 0.25)
