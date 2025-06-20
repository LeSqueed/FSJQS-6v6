#!mainFile "../../main.opy"

#!include "mayhem.opy"
#!include "trap.opy"

def initJunkrat():
    @Name "[junkrat/init.opy]: initJunkrat()"
    
    resetStats()
    resetStatuses()
    enableAllAbilities()
    eventPlayer.ult_charge_pvar[1] = 1925
    eventPlayer._base_damage_scalar = 0.875
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    #check mayhem.opy
    eventPlayer.disallowButton(Button.ULTIMATE)
    eventPlayer.hero_initialized = true
