#!mainFile "../../main.opy"

def initZenyatta():
    @Name "[zenyatta/init.opy]: initZenyatta()"
    
    eventPlayer.custom_hp_pvar[0] = 0
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 33.45
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2200
    eventPlayer.setAmmo(0, 20)
    eventPlayer.setMaxAmmo(0, 20)
    eventPlayer.setKnockbackDealt(4)
    eventPlayer.hero_initialized = true