#!mainFile "../../main.opy"

playervar HanzoDrawAura
playervar Hanzo_Marked_icon
#!include "stormbow.opy"
#!include "stormarrow.opy"
#!include "mark.opy"

def initHanzo():
    @Name "[hanzo/init.opy]: initHanzo()"

    #eventPlayer.custom_hp_pvar[0] = 200
    #eventPlayer.custom_hp_pvar[1] = 0
    #eventPlayer.custom_hp_pvar[2] = 0
    #applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1680
    eventPlayer._base_damage_scalar = 0.6
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer._max_health_scalar = HeroHealthPercentage.HANZO / 100
    eventPlayer.hero_initialized = true


rule "[hanzo/init.opy]: Correct Hanzo other forms of damage":
    @Event playerDealtDamage
    @Hero hanzo
    @Condition eventAbility in [Button.MELEE, Button.ULTIMATE] == true

    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar - eventDamage) / eventPlayer._base_damage_scalar)

