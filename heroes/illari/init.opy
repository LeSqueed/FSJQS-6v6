#!include "heroes/illari/solar_rifle.opy"

def initIllari():
    @Name "[illari/init.opy]: initIllari()"
    
    #eventPlayer.custom_hp_pvar[0] = 0
    #eventPlayer.custom_hp_pvar[1] = 0
    #eventPlayer.custom_hp_pvar[2] = 0
    #applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2450
    eventPlayer.macro_pvar[0] = 0.75
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.macro_pvar[1] = 0.75
    eventPlayer.setHealingDealt(100 * eventPlayer.macro_pvar[1])
    eventPlayer.max_health_scaler = 0.8
    eventPlayer.hero_initialized = true

rule "[illari/init.opy]: Correct Outburst and melee damage":
    @Event playerDealtDamage
    @Hero illari
    @Condition eventAbility in [Button.MELEE, Button.ABILITY_1] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[illari/init.opy]: Correct Pylon self healing":
    @Event playerDealtHealing
    @Hero illari
    @Condition healee == healer
    
    heal(healer, null, eventHealing)