#!include "heroes/hanzo/primary.opy"
#!include "heroes/hanzo/stormarrow.opy"
#!include "heroes/hanzo/mark.opy"

def initHanzo():
    @Name "[hanzo/init.opy]: initHanzo()"
    
    #eventPlayer.custom_hp_pvar[0] = 200
    #eventPlayer.custom_hp_pvar[1] = 0
    #eventPlayer.custom_hp_pvar[2] = 0
    #applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1680
    eventPlayer.macro_pvar[0] = 0.6
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.hero_initialized = true
    
rule "[hanzo/init.opy]: Correct Hanzo other forms of damage":
    @Event playerDealtDamage
    @Hero hanzo
    @Condition eventAbility in [Button.MELEE, Button.ULTIMATE] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])

