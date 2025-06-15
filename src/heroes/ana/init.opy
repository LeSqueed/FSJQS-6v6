#!mainFile "../../../main.opy"

#!include "sleep.opy"
#!include "nade.opy"

playervar macro_pvar
playervar Ana_Sleepdart_Target

def initAna():
    @Name "[ana/init.opy]: initAna()"
    
    eventPlayer.ult_charge_pvar[1] = 2300
    eventPlayer.macro_pvar[0] = 0.667
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.macro_pvar[1] = 0.933
    eventPlayer.setHealingDealt(100 * eventPlayer.macro_pvar[1])
    eventPlayer.hero_initialized = true

rule "[ana/init.opy]: Correct Sleep Dart and Ana Melee damage":
    @Event playerDealtDamage
    @Hero ana
    @Condition eventAbility in [Button.ABILITY_1, Button.MELEE] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[ana/init.opy]: Correct Primary Fire damage":
    @Event playerDealtDamage
    @Hero ana
    @Condition eventAbility == Button.PRIMARY_FIRE
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] * 0.933 - eventDamage) / eventPlayer.macro_pvar[0])
