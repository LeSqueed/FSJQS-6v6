#!mainFile "../../main.opy"

def initZenyatta():
    @Name "[zenyatta/init.opy]: initZenyatta()"
    
    eventPlayer.custom_hp_pvar[0] = 0
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 33.45
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2100
    eventPlayer._base_healing_scalar = 0.96
    eventPlayer.setDamageDealt(100* eventPlayer._base_healing_scalar)
    eventPlayer.setAmmo(0, 20)
    eventPlayer.setMaxAmmo(0, 20)
    eventPlayer.setKnockbackDealt(4)
    eventPlayer._max_health_scalar = HeroHealthPercentage.ZENYATTA / 100
    eventPlayer.hero_initialized = true