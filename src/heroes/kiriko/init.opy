#!mainFile "../../main.opy"

#!include "swift_step.opy"
#!include "protection_suzu.opy"

def initKiriko():
    @Name "[kiriko/init.opy]: initKiriko()"

    eventPlayer.ult_charge_pvar[1] = 2100
    eventPlayer._base_damage_scalar = 0.867
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer._base_healing_scalar = 0.77
    eventPlayer.setHealingDealt(100 * eventPlayer._base_healing_scalar)
    eventPlayer._current_move_speed += 9.1
    eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 5)
    eventPlayer._max_health_scalar = HeroHealthPercentage.KIRIKO / 100
    eventPlayer.hero_initialized = true
