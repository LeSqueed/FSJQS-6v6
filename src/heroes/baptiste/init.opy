#!mainFile "../../main.opy"

playervar baptiste_balance_change_check
playervar Baptiste_hud

#!include "heroes/baptiste/regen_burst.opy"

def initBaptiste():
    @Name "[baptiste/init.opy]: initBaptiste()"
    
    eventPlayer.ult_charge_pvar[1] = 2440
    eventPlayer._base_damage_scalar = 0.96
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer._base_healing_scalar = 0.584
    eventPlayer.setHealingDealt(100 * eventPlayer._base_healing_scalar)
    eventPlayer.baptiste_balance_change_check = true
    eventPlayer.max_health_scaler = 0.8
    eventPlayer.hero_initialized = true


rule "[baptiste/init.opy]: Increase Baptiste melee damage":
    @Event playerDealtDamage
    @Hero baptiste
    @Condition eventAbility in [Button.MELEE] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar - eventDamage) / eventPlayer._base_damage_scalar)


rule "[baptiste/init.opy]: Increase Biotic Launcher healing":
    @Event playerDealtHealing
    @Hero baptiste
    @Condition eventAbility == Button.SECONDARY_FIRE
    @Condition eventHealing < 35
    @Condition eventPlayer.baptiste_balance_change_check != false
    
    eventPlayer.baptiste_balance_change_check = false
    heal(healee, healer, eventHealing / eventPlayer._base_healing_scalar * 1.167 - eventHealing)
    wait(0.15)
    eventPlayer.baptiste_balance_change_check = true


rule "[baptiste/init.opy]: Healing indicator":
    @Event eachPlayer
    @Hero baptiste
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0
    @Condition isMatchBetweenRounds() == false
    
    createInWorldText(eventPlayer, "{0} {1}".format(len([player for player in getLivingPlayers(eventPlayer.getTeam()) if distance(eventPlayer, player) <= 12 and isInLoS(eventPlayer, player, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) and player.getHero() != Hero.BAPTISTE]), abilityIconString(Hero.BAPTISTE, Button.ABILITY_1)), updateEveryFrame(eventPlayer.getEyePosition() + (100 * (-0.35 * (directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90)) + 3 * eventPlayer.getFacingDirection()))), 2)
    eventPlayer.Baptiste_hud = getLastCreatedText()
    waitUntil(eventPlayer.getAbilityCooldown(Button.ABILITY_1) != 0, 99999)
    destroyInWorldText(eventPlayer.Baptiste_hud)

    
rule "[baptiste/init.opy]: Clean up Baptiste":
    @Event eachPlayer
    @Condition eventPlayer.hero_setup != Hero.BAPTISTE
    
    destroyInWorldText(eventPlayer.Baptiste_hud)
