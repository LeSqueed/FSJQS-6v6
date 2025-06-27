#!mainFile "../../main.opy"

playervar Junkerqueen_overhealth
playervar within_shout_radius

#!include "carnage.opy"
#!include "commanding_shout.opy"
#!include "jagged_blade.opy"
#!include "rampage.opy"

def initJunkerQueen():
    @Name "[junkerqueen/init.opy]: initJunkerQueen()"
    
    eventPlayer.custom_hp_pvar[0] = 157
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2300
    removeTankPassive()
    eventPlayer._base_damage_scalar = 0.875
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer.setHealingDealt(73.563)
    eventPlayer.setKnockbackDealt(64)
    eventPlayer.startScalingSize(0.96)
    eventPlayer.setMaxAmmo(0, 8)
    eventPlayer.setAmmo(0, 8)
    eventPlayer.overhealth_check = false
    eventPlayer.max_health_scaler = 0.714
    eventPlayer.hero_initialized = true

rule "[junkerqueen/init.opy]: Shout indicator":
    @Event eachPlayer
    @Hero junkerQueen
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0
    @Condition isMatchBetweenRounds() == false
    
    createInWorldText(eventPlayer, "{0} {1}".format(len([player for player in getLivingPlayers(eventPlayer.getTeam()) if distance(eventPlayer, player) <= 15 and isInLoS(eventPlayer, player) and player.getHero() != Hero.JUNKER_QUEEN]), abilityIconString(Hero.JUNKER_QUEEN, Button.ABILITY_1)), updateEveryFrame(eventPlayer.getEyePosition() + (100 * (-0.5 * (directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90)) + 3 * eventPlayer.getFacingDirection()))), 2)
    eventPlayer._junker_queen_commanding_shout_text = getLastCreatedText()
    waitUntil(eventPlayer.isUsingAbility1(), Math.INFINITY)
    destroyInWorldText(eventPlayer._junker_queen_commanding_shout_text)
    eventPlayer._junker_queen_commanding_shout_text = null


rule "[junkerqueen/init.opy]: Clean up JQ":
    @Event eachPlayer
    @Condition eventPlayer.hero_setup != Hero.JUNKER_QUEEN
    
    destroyInWorldText(eventPlayer._junker_queen_commanding_shout_text)
