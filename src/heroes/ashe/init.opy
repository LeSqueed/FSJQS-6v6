#!mainFile "../../main.opy"

playervar Ashe_dynamite_hit
playervar Ashe_Dynamite_Healing_ID

#!include "dynamite.opy"
#!include "viper.opy"

def initAshe():
    @Name "[ashe/init.opy]: initAshe()"

    eventPlayer.ult_charge_pvar[1] = 2240
    eventPlayer._base_damage_scalar = 0.934
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer._max_health_scalar = HeroHealthPercentage.ASHE / 100
    eventPlayer.hero_initialized = true


rule "[ashe/init.opy]: Correct damage numbers":
    @Event playerDealtDamage
    @Hero ashe
    @Condition eventAbility in [Button.ABILITY_1, Button.ABILITY_2, Button.MELEE] == true

    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar - eventDamage) / eventPlayer._base_damage_scalar)
