#!mainFile "../../main.opy"

#!include "primal.opy"

def initWinston():
    @Name "[winston/init.opy]: initWinston()"

    eventPlayer.custom_hp_pvar[0] = 46.175
    eventPlayer.custom_hp_pvar[1] = 15.4
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1650
    removeTankPassive()
    eventPlayer._base_damage_scalar = 0.821
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer._max_health_scalar = HeroHealthPercentage.WINSTON / 100
    eventPlayer.setMaxAmmo(0, 100)
    eventPlayer.setAmmo(0, 100)
    eventPlayer.hero_initialized = true

rule "[winston/init.opy]: Correct Jump Pack, Melee, Primal Rage damage":
    @Event playerDealtDamage
    @Hero winston
    @Condition eventPlayer.isUsingUltimate() == false
    @Condition eventAbility in [Button.ABILITY_1, Button.MELEE, Button.SECONDARY_FIRE] == true

    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar - eventDamage) / eventPlayer._base_damage_scalar)
