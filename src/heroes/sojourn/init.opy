#!mainFile "../../main.opy"

#!include "heroes/sojourn/primary.opy"
#!include "heroes/sojourn/orb.opy"
#!include "heroes/sojourn/ultimate.opy"

def initSojourn():
    @Name "[sojourn/init.opy]: initSojourn()"
    
    eventPlayer.ult_charge_pvar[1] = 2100
    eventPlayer._base_damage_scalar = 0.834
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer.hero_initialized = true