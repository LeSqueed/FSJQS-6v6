#!mainFile "../../main.opy"

playervar orbital_ray_x
playervar orbital_ray_z
playervar orbital_ray_final_x
playervar orbital_ray_final_z

#!include "orbital_ray.opy"
#!include "pulsar_torpedos.opy"

def initJuno():
    @Name "[juno/init.opy]: initJuno()"

    eventPlayer.custom_hp_pvar[0] = 87.5
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 3000
    eventPlayer._base_damage_scalar = 0.867
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer._base_healing_scalar = 0.833
    eventPlayer.setHealingDealt(100 * eventPlayer._base_healing_scalar)
    eventPlayer._current_move_speed += 9.1
    eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)
    eventPlayer.setAmmo(0, 120)
    eventPlayer.setMaxAmmo(0, 120)
    eventPlayer._max_health_scalar = HeroHealthPercentage.JUNO / 100
    eventPlayer.hero_initialized = true


rule "[juno/init.opy]: Correct Juno Melee damage":
    @Event playerDealtDamage
    @Hero juno
    @Condition eventAbility == Button.MELEE

    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar - eventDamage) / eventPlayer._base_damage_scalar)