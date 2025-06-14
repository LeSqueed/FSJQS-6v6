#!include "heroes/reinhardt/firestrike.opy"
#!include "heroes/reinhardt/pin.opy"
#!include "heroes/reinhardt/charge.opy"
#!include "heroes/reinhardt/shatter.opy"

def initReinhardt():
    @Name "[reinhardt/init.opy]: initReinhardt()"
    
    #eventPlayer.custom_hp_pvar[0] = 0
    #eventPlayer.custom_hp_pvar[1] = 0
    #eventPlayer.custom_hp_pvar[2] = 0
    #applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1460
    eventPlayer.macro_pvar[0] = 0.85
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.setKnockbackReceived(93.333)
    eventPlayer.stopForcingThrottle()
    eventPlayer.hero_initialized = true