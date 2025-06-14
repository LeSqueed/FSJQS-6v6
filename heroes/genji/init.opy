#!include "heroes/genji/dragonblade.opy"

def initGenji():
    @Name "[genji/init.opy]: initGenji()"
    
    #eventPlayer.custom_hp_pvar[0] = 200
    #eventPlayer.custom_hp_pvar[1] = 0
    #eventPlayer.custom_hp_pvar[2] = 0
    #applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1150
    eventPlayer.hero_initialized = true

rule "[genji/init.opy]: Reduce Deflect duration":
    @Event eachPlayer
    @Hero genji
    @Condition eventPlayer.isUsingAbility2() == true
    
    wait(1.5)
    eventPlayer.forceButtonPress(Button.ABILITY_2)

