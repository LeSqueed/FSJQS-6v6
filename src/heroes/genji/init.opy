#!mainFile "../../main.opy"

#!include "dragonblade.opy"

def initGenji():
    @Name "[genji/init.opy]: initGenji()"

    eventPlayer.ult_charge_pvar[1] = 1150
    eventPlayer._max_health_scalar = HeroHealthPercentage.GENJI / 100
    eventPlayer.hero_initialized = true

rule "[genji/init.opy]: Reduce Deflect duration":
    @Event eachPlayer
    @Hero genji
    @Condition eventPlayer.isUsingAbility2() == true

    wait(1.5)
    eventPlayer.forceButtonPress(Button.ABILITY_2)

