#!mainFile "../../main.opy"

playervar WidowScopeGlint_effect
playervar Widowmaker_beam_effect
playervar Widow_maxscope_duration

#!include "widows_kiss.opy"
#!include "grapple.opy"

def initWidowmaker():
    @Name "[widowmaker/init.opy]: initWidowmaker()"
    
    eventPlayer.ult_charge_pvar[1] = 1540
    eventPlayer._max_health_scalar = HeroHealthPercentage.WIDOWMAKER / 100
    eventPlayer.hero_initialized = true


rule "[widowmaker/init.opy]: Reduce Scoped Shot damage":
    @Event eachPlayer
    @Hero widowmaker
    @Condition eventPlayer.isFiringSecondaryFire() == true
    @Disabled
    
    eventPlayer.setDamageDealt(87.5)
    waitUntil(not eventPlayer.isFiringSecondaryFire(), Math.INFINITY)
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)