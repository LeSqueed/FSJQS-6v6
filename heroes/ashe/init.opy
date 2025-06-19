#!include "heroes/ashe/dynamite.opy"
#!include "heroes/ashe/viper.opy"

def initAshe():
    @Name "[ashe/init.opy]: initAshe()"
    
    #eventPlayer.custom_hp_pvar[0] = 200
    #eventPlayer.custom_hp_pvar[1] = 0
    #eventPlayer.custom_hp_pvar[2] = 0
    #applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2240
    eventPlayer.macro_pvar[0] = 0.934
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.max_health_scaler = 0.8
    eventPlayer.hero_initialized = true

rule "[ashe/init.opy]: Correct damage numbers":
    @Event playerDealtDamage
    @Hero ashe
    @Condition eventAbility in [Button.ABILITY_1, Button.ABILITY_2, Button.MELEE] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])