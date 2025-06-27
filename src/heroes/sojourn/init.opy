#!mainFile "../../main.opy"

#!include "primary.opy"
#!include "orb.opy"
#!include "ultimate.opy"

def initSojourn():
    @Name "[sojourn/init.opy]: initSojourn()"
    
    eventPlayer.ult_charge_pvar[1] = 2100
    eventPlayer._base_damage_scalar = 0.834
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer._max_health_scalar = HeroHealthPercentage.SOJOURN / 100
    eventPlayer.hero_initialized = true