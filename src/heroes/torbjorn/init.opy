#!mainFile "../../main.opy"

playervar overload_overhealth

#!include "turret.opy"

def initTorbjorn():
    @Name "[torbjorn/init.opy]: initTorbjorn()"
    
    eventPlayer.custom_hp_pvar[0] = 0
    eventPlayer.custom_hp_pvar[1] = 16.725
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2142
    eventPlayer.setAmmo(0, 18)
    eventPlayer.setMaxAmmo(0, 18)
    eventPlayer.overhealth_check = false
    eventPlayer._max_health_scalar = HeroHealthPercentage.TORBJORN / 100
    eventPlayer.hero_initialized = true


rule "[torbjorn/init.opy]: Increase Rivet Gun alternate fire ammo cost":
    @Event eachPlayer
    @Hero torbjorn
    @Condition eventPlayer.isFiringSecondaryFire() == true
    
    eventPlayer.setAmmo(0, eventPlayer.getAmmo() - 1)


rule "[torbjorn/init.opy]: Increase Overload overhealth":
    @Event eachPlayer
    @Hero torbjorn
    @Condition eventPlayer.isUsingAbility2() == true
    
    eventPlayer.addHealthPool(Health.NORMAL, 22.3, false)
    eventPlayer.overload_overhealth = getLastCreatedHealthPool()
    waitUntil(not eventPlayer.isUsingAbility2(), Math.INFINITY)
    removeHealthPool(eventPlayer.overload_overhealth)

