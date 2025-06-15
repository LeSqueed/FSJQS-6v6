#!mainFile "../../../main.opy"

#!include "deadeye.opy"
#!include "fanthehammer.opy"
#!include "flashbang.opy"

playervar custom_hp_pvar
playervar macro_pvar

def initMccree():
    @Name "[cassidy/init.opy]: initMccree()"
    
    eventPlayer.custom_hp_pvar[0] = 1
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1680
    eventPlayer.macro_pvar[0] = 0.667
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.hero_initialized = true
    
rule "[cassidy/init.opy]: Correct Cassidy melee damage and gun damage":
    @Event playerDealtDamage
    @Hero cassidy
    @Condition eventAbility in [Button.MELEE, Button.PRIMARY_FIRE] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])
