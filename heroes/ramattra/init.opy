#!include "heroes/ramattra/nemesis_form.opy"

def initRamattra():
    @Name "[ramattra/init.opy]: initRamattra()"
    
    eventPlayer.custom_hp_pvar[0] = 166
    eventPlayer.custom_hp_pvar[1] = 12
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2016
    removeTankPassive()
    #eventPlayer.macro_pvar[0] = 1
    #eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.max_health_scaler = 0.632
    eventPlayer.hero_initialized = true