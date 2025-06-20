#!mainFile "../../main.opy"

playervar punched_victims
playervar wall_impacted_victims
playervar uppercut_victims
playervar is_using_uppercut
playervar doom_uppercut_shields
playervar number_of_victims_uppercut

#!include "heroes/doomfist/meteor_strike.opy"
#!include "heroes/doomfist/punch.opy"
#!include "heroes/doomfist/powerblock.opy"
#!include "heroes/doomfist/uppercut.opy"
#!include "heroes/doomfist/seismic_slam.opy" 
#!include "heroes/doomfist/hand_cannon.opy"
#!include "heroes/doomfist/dps.opy"

def initDoomfist():
    @Name "[doomfist/init.opy]: initDoomfist()"
    
    eventPlayer.custom_hp_pvar[0] = 450
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1750
    removeTankPassive()
    eventPlayer._base_damage_scalar = 0.8
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer.max_health_scaler = 0.625
    eventPlayer.punched_victims = []
    eventPlayer.wall_impacted_victims = []
    eventPlayer.uppercut_victims = []
    eventPlayer.is_using_uppercut = false
    eventPlayer.hero_initialized = true

rule "[doomfist/init.opy]: Clean up Doomfist":
    @Event eachPlayer
    @Condition eventPlayer.hero_setup != Hero.DOOMFIST
    
    eventPlayer.punched_victims = null
    eventPlayer.wall_impacted_victims = null
    eventPlayer.uppercut_victims = null
    eventPlayer.is_using_uppercut = null
    eventPlayer.doom_uppercut_shields = null
    eventPlayer.number_of_victims_uppercut = null
