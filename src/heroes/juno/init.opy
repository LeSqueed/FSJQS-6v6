#!mainFile "../../main.opy"

playervar orbital_ray_x
playervar orbital_ray_z
playervar orbital_ray_final_x
playervar orbital_ray_final_z

#!include "orbital_ray.opy"

def initJuno():
    @Name "[juno/init.opy]: initJuno()"
    
    eventPlayer.custom_hp_pvar[0] = 87
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2850
    eventPlayer._base_damage_scalar = 0.867
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer._base_healing_scalar = 0.833
    eventPlayer.setHealingDealt(100 * eventPlayer._base_healing_scalar)
    eventPlayer._current_move_speed += 9.1
    eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)
    eventPlayer.setAmmo(0, 120)
    eventPlayer.setMaxAmmo(0, 120)
    eventPlayer.hero_initialized = true


rule "[juno/init.opy]: Correct Pulsar Torpedo healing and damage":
    @Event eachPlayer
    @Hero juno
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true
    @Condition eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE) < 0.1
    @Condition eventPlayer.isMeleeing() == false
    @Condition eventPlayer.isReloading() == false
    
    eventPlayer.setHealingDealt(58.824)
    eventPlayer.setDamageDealt(58.824)
    waitUntil(eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE) > 0, 4)
    eventPlayer.setHealingDealt(100 * eventPlayer._base_healing_scalar)
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)

rule "[juno/init.opy]: Correct Juno Melee damage":
    @Event playerDealtDamage
    @Hero juno
    @Condition eventAbility == Button.MELEE
    
    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar - eventDamage) / eventPlayer._base_damage_scalar)


rule "[juno/init.opy]: Correct Pulsar Torpedo healing over time":
    @Event playerDealtHealing
    @Hero juno
    @Condition eventHealing > 69
    
    healee.startDamageOverTime(null, 2.4, 10)
