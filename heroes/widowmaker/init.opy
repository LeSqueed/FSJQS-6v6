#!include "heroes/widowmaker/weapon.opy"
#!include "heroes/widowmaker/grapple.opy"

def initWidowmaker():
    @Name "[widowmaker/init.opy]: initWidowmaker()"
    
    #eventPlayer.custom_hp_pvar[0] = 200
    #eventPlayer.custom_hp_pvar[1] = 0
    #eventPlayer.custom_hp_pvar[2] = 0
    #applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1540
    eventPlayer.hero_initialized = true


rule "[widowmaker/init.opy]: Reduce Scoped Shot damage":
    @Event eachPlayer
    @Hero widowmaker
    @Condition eventPlayer.isFiringSecondaryFire() == true
    @Disabled
    
    eventPlayer.setDamageDealt(87.5)
    waitUntil(not eventPlayer.isFiringSecondaryFire(), 999999986991104)
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])