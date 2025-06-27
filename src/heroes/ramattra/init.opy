#!mainFile "../../main.opy"

playervar Nemesis_armor

#!include "nemesis_form.opy"

def initRamattra():
    @Name "[ramattra/init.opy]: initRamattra()"
    
    eventPlayer.custom_hp_pvar[0] = 167
    eventPlayer.custom_hp_pvar[1] = 11.8
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2016
    removeTankPassive()
    eventPlayer._max_health_scalar = HeroHealthPercentage.RAMATTRA / 100
    eventPlayer.hero_initialized = true