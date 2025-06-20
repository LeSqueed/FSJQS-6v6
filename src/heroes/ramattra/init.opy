#!mainFile "../../main.opy"

playervar Nemesis_armor

#!include "heroes/ramattra/nemesis_form.opy"

def initRamattra():
    @Name "[ramattra/init.opy]: initRamattra()"
    
    eventPlayer.custom_hp_pvar[0] = 166
    eventPlayer.custom_hp_pvar[1] = 12
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2016
    removeTankPassive()
    eventPlayer.max_health_scaler = 0.632
    eventPlayer.hero_initialized = true