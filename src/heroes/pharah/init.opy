#!mainFile "../../main.opy"

def initPharah():
    @Name "[pharah/init.opy]: initPharah()"
    
    eventPlayer.custom_hp_pvar[0] = 0
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2100
    eventPlayer.hero_initialized = true