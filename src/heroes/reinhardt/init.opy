#!mainFile "../../main.opy"

#!include "firestrike.opy"
#!include "pin.opy"
#!include "charge.opy"
#!include "shatter.opy"

def initReinhardt():
    @Name "[reinhardt/init.opy]: initReinhardt()"
    
    eventPlayer.ult_charge_pvar[1] = 1460
    eventPlayer._base_damage_scalar = 0.85
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer.setKnockbackReceived(93.333)
    eventPlayer.stopForcingThrottle()
    eventPlayer.hero_initialized = true