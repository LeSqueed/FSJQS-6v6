#!mainFile "../../main.opy"

playervar Echo_Copy
playervar EchoUltSeconds

#!include "copy.opy"
#!include "ultimate.opy"

def initEcho():
    @Name "[echo/init.opy]: initEcho()"

    eventPlayer.custom_hp_pvar[0] = 125.05
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1880
    eventPlayer._base_damage_scalar = 0.833
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer.startScalingSize(0.94)
    eventPlayer.disallowButton(Button.ULTIMATE)
    eventPlayer._current_move_speed = 100
    eventPlayer.setMoveSpeed(100)
    eventPlayer._max_health_scalar = HeroHealthPercentage.ECHO / 100
    eventPlayer.hero_initialized = true


rule "[echo/init.opy]: Correct Echo Tri-Shot damage":
    @Event playerDealtDamage
    @Hero echo
    @Condition eventPlayer.isDuplicatingAHero() == false
    @Condition eventAbility == Button.PRIMARY_FIRE

    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar * 0.971 - eventDamage) / eventPlayer._base_damage_scalar)


rule "[echo/init.opy]: Correct Echo other forms of damage":
    @Event playerDealtDamage
    @Hero echo
    @Condition eventAbility in [Button.MELEE, Button.ABILITY_2] == true

    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar - eventDamage) / eventPlayer._base_damage_scalar)


rule "[echo/init.opy]: Clean up Echo":
    @Event eachPlayer
    @Condition eventPlayer.hero_setup != Hero.ECHO

    destroyProgressBarInWorldText(eventPlayer._echo_copy_seconds_text)
    stopChasingVariable(eventPlayer.EchoUltSeconds)
    getPlayers(eventPlayer.getTeam()).Echo_Copy = false
    eventPlayer._echo_copy_seconds_text = null
    eventPlayer.EchoUltSeconds = null
