#!include "heroes/junkrat/mayhem.opy"
#!include "heroes/junkrat/trap.opy"

def initJunkrat():
    @Name "[junkrat/init.opy]: initJunkrat()"
    
    #eventPlayer.addHealthPool(Health.ARMOR, 1, true, true)
    #eventPlayer.addHealthPool(Health.SHIELDS, 1, true, true)
    #eventPlayer.removeAllHealthPools()
    ##eventPlayer.addHealthPool(Health.NORMAL, 199, true, true)
    #heal(eventPlayer, null, 1)
    resetStats()
    resetStatuses()
    enableAllAbilities()
    eventPlayer.ult_charge_pvar[1] = 1925
    eventPlayer.macro_pvar[0] = 0.875
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    #check mayhem.opy
    eventPlayer.disallowButton(Button.ULTIMATE)
    eventPlayer.hero_initialized = true
