#!mainFile "../../main.opy"

def initAna():
    @Name "[heroes/ana/init.opy]: initAna()"
    
    eventPlayer.custom_hp_pvar[0] = 200
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2300
    eventPlayer.macro_pvar[0] = 0.667
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.macro_pvar[1] = 0.933
    eventPlayer.setHealingDealt(100 * eventPlayer.macro_pvar[1])
    eventPlayer.hero_initialized = true

rule "[heroes/ana/init.opy]: Correct Sleep Dart and Ana Melee damage":
    @Event playerDealtDamage
    @Hero ana
    @Condition eventAbility in [Button.ABILITY_1, Button.MELEE] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[heroes/ana/init.opy]: Correct Sleep Dart and Ana Melee damage":
    @Event playerDealtDamage
    @Hero ana
    @Condition eventAbility == Button.PRIMARY_FIRE
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] * 0.933 - eventDamage) / eventPlayer.macro_pvar[0])
    