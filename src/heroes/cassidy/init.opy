#!mainFile "../../main.opy"

#!include "deadeye.opy"
#!include "fanthehammer.opy"
#!include "flashbang.opy"

def initCassidy():
    @Name "[cassidy/init.opy]: initCassidy()"

    eventPlayer.custom_hp_pvar[0] = 2
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1680
    eventPlayer._base_damage_scalar = 0.667
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer._max_health_scalar = HeroHealthPercentage.CASSIDY / 100
    eventPlayer.hero_initialized = true

rule "[cassidy/init.opy]: Correct Cassidy melee damage and gun damage":
    @Event playerDealtDamage
    @Hero cassidy
    @Condition eventAbility in [Button.MELEE, Button.PRIMARY_FIRE] == true

    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar - eventDamage) / eventPlayer._base_damage_scalar)
