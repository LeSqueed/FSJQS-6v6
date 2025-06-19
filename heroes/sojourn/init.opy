#!include "heroes/sojourn/primary.opy"
#!include "heroes/sojourn/orb.opy"
#!include "heroes/sojourn/ultimate.opy"

def initSojourn():
    @Name "[sojourn/init.opy]: initSojourn()"
    
    #eventPlayer.custom_hp_pvar[0] = 0
    #eventPlayer.custom_hp_pvar[1] = 0
    #eventPlayer.custom_hp_pvar[2] = 0
    #applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2100
    eventPlayer.macro_pvar[0] = 0.834
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.hero_initialized = true