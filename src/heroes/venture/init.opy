#!mainFile "../../main.opy"

playervar clobber_cooldown_accelerator
playervar is_firing_excavator

#!include "excavator.opy"
#!include "drill_dash.opy"
#!include "clobber.opy"
#!include "burrow.opy"
#!include "tectonic_shock.opy"

def initVenture():
    @Name "[venture/init.opy]: initVenture()"

    eventPlayer.custom_hp_pvar[0] = 100
    eventPlayer.custom_hp_pvar[1] = 50
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1550
    eventPlayer._base_damage_scalar = 0.429
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer.setKnockbackDealt(80)
    eventPlayer.setAmmo(0, 6)
    eventPlayer.setMaxAmmo(0, 6)
    eventPlayer._max_health_scalar = HeroHealthPercentage.VENTURE / 100
    eventPlayer.startScalingSize(1.18)
    eventPlayer.hero_initialized = true


rule "[venture/init.opy]: Reduce Headshot damage taken Venture":
    @Event playerTookDamage
    @Hero venture
    @Condition eventWasCriticalHit == true

    heal(eventPlayer, null, eventDamage * 0.3)