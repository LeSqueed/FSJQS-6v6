#!mainFile "../../main.opy"

playervar WidowScopeGlint_effect
playervar Widowmaker_beam_effect
playervar Widow_maxscope_duration
playervar Widow_Focus_HUD

#!include "heroes/widowmaker/widows_kiss.opy"
#!include "heroes/widowmaker/grapple.opy"

def initWidowmaker():
    @Name "[widowmaker/init.opy]: initWidowmaker()"
    
    eventPlayer.ult_charge_pvar[1] = 1540
    eventPlayer.hero_initialized = true


rule "[widowmaker/init.opy]: Reduce Scoped Shot damage":
    @Event eachPlayer
    @Hero widowmaker
    @Condition eventPlayer.isFiringSecondaryFire() == true
    @Disabled
    
    eventPlayer.setDamageDealt(87.5)
    waitUntil(not eventPlayer.isFiringSecondaryFire(), 999999986991104)
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)