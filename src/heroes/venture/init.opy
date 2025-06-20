#!mainFile "../../main.opy"

playervar clobber_cooldown_accelerator
playervar is_firing_excavator

#!include "heroes/venture/excavator.opy"
#!include "heroes/venture/drill_dash.opy"
#!include "heroes/venture/clobber.opy"
#!include "heroes/venture/burrow.opy"
#!include "heroes/venture/tectonic_shock.opy"

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
    eventPlayer.max_health_scaler = 0.833
    eventPlayer.startScalingSize(1.18)
    eventPlayer.hero_initialized = true


rule "[venture/init.opy]: Reduce Headshot damage taken Venture":
    @Event playerTookDamage
    @Hero venture
    @Condition eventWasCriticalHit == true
    
    heal(eventPlayer, null, eventDamage * 0.3)