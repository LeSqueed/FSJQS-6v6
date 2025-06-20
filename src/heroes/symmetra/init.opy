#!mainFile "../../main.opy"

def initSymmetra():
    @Name "[symmetra/init.opy]: initSymmetra()"
    
    eventPlayer.custom_hp_pvar[0] = 5.25
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 12.5
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1680
    eventPlayer.max_health_scaler = 0.75
    eventPlayer.hero_initialized = true


rule "[symmetra/init.opy]: Correct Photon projector damage":
    @Event playerDealtDamage
    @Hero symmetra
    @Condition eventAbility == Button.SECONDARY_FIRE
    
    damage(victim, attacker, eventDamage * 1.05 - eventDamage)
