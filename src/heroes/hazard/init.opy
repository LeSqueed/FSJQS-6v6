#!mainFile "../../main.opy"

playervar hazard_bubble_target
playervar Hazard_Downpour_Target
playervar Hazard_Downpour_effect
playervar Hazard_Bubble_Allowed
playervar hazard_bubble_confirmed
playervar hazard_bubble_effect
playervar hazard_bubble_effect2
playervar hazard_bubble_icon

#!include "spike_guard.opy"
#!include "violent_leap.opy"
#!include "downpour.opy"
#!include "thorn_wall.opy"

def initHazard():
    @Name "[hazard/init.opy]: initHazard()"
    
    eventPlayer.custom_hp_pvar[0] = 116
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2000
    eventPlayer._base_damage_scalar = 0.8
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer.setAbility2Enabled(false)
    eventPlayer.hero_initialized = true


rule "[hazard/init.opy]: Increase Hazard melee, wall, ultimate damage":
    @Event playerDealtDamage
    @Hero hazard
    @Condition eventAbility in [Button.ABILITY_2, Button.ULTIMATE, Button.MELEE] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar - eventDamage) / eventPlayer._base_damage_scalar)

rule "[hazard/init.opy]: Clean up Hazard":
    @Event eachPlayer
    @Condition eventPlayer.hero_setup != Hero.HAZARD
    
    eventPlayer.hazard_bubble_target = null
    destroyInWorldText(eventPlayer._hazard_bubble_target_hud)
    eventPlayer.Hazard_Bubble_Allowed = null