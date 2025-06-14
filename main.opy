#!include "lobby/lobby.opy"

#!include "constants/global.opy"
#!include "constants/player.opy"

#Subroutine names
subroutine clearCustomHp 0
subroutine applyCustomHp 1
subroutine resetHero 2
subroutine enableAllAbilities 3
subroutine disableAllAbilities 4
subroutine resetStats 5
subroutine resetStatuses 6
subroutine initHero 7
subroutine resetUltCharge 8
subroutine removeTankPassive 9
subroutine initAna 10
subroutine initAshe 11
subroutine initBaptiste 12
subroutine initBastion 13
subroutine initBrigitte 14
subroutine initDoomfist 15
subroutine initDva 16
subroutine initEcho 17
subroutine initGenji 18
subroutine initHanzo 19
subroutine initIllari 20
subroutine initJunkerQueen 21
subroutine initJunkrat 22
subroutine initJuno 23
subroutine initKiriko 24
subroutine initLucio 25
subroutine initMccree 26
subroutine initMercy 27
subroutine initMoira 28
subroutine initPharah 29
subroutine initRamattra 30
subroutine initReaper 31
subroutine initReinhardt 32
subroutine initRoadhog 33
subroutine initSigma 34
subroutine initSojourn 35
subroutine initSoldier 36
subroutine initTorbjorn 37
subroutine initTracer 38
subroutine initWidowmaker 39
subroutine initWinston 40
subroutine initWreckingBall 41
subroutine showSelfBubbleCD 42
subroutine hideSelfBubbleCD 43
subroutine showAllyBubbleCD 44
subroutine hideAllyBubbleCD 45
subroutine initZarya 46
subroutine initZenyatta 47
subroutine initMauga 48
subroutine initLifeweaver 49
subroutine initOrisa 50
subroutine initVenture 51
subroutine initMei 52
subroutine initSombra 53
subroutine initSymmetra 54
subroutine initHazard 55
subroutine EchoCopy 56
subroutine initFreja 57
subroutine executeUppercut 58

#!include "utilities/hero_init.opy"
#!include "utilities/global.opy"
#!include "utilities/custom_hp.opy"
#!include "utilities/hero_switch.opy"
#!include "utilities/anti_crash.opy"
#!include "utilities/hud.opy"
#!include "utilities/utilities.opy"
#!include "utilities/role_lock.opy"
#!include "passives/healing.opy"
#!include "passives/tank/ult_charge.opy"
#!include "passives/tank/knockback.opy"
#!include "passives/damage/damage_passive.opy"
#!include "passives/damage/healthpack.opy"
#!include "debug_mode.opy"

#!include "heroes/ana/init.opy"
#!include "heroes/ashe/init.opy"
#!include "heroes/baptiste/init.opy"
#!include "heroes/bastion/init.opy"
#!include "heroes/brigitte/init.opy"
#!include "heroes/cassidy/init.opy"
#!include "heroes/doomfist/init.opy"
#!include "heroes/dva/init.opy"
#!include "heroes/echo/init.opy"
#!include "heroes/freja/init.opy"
#!include "heroes/genji/init.opy"
#!include "heroes/hanzo/init.opy"
#!include "heroes/hazard/init.opy"
#!include "heroes/illari/init.opy"
#!include "heroes/junkerqueen/init.opy"
#!include "heroes/junkrat/init.opy"
#!include "heroes/juno/init.opy"
#!include "heroes/kiriko/init.opy"
#!include "heroes/lifeweaver/init.opy"
#!include "heroes/lucio/init.opy"
#!include "heroes/mauga/init.opy"
#!include "heroes/mei/init.opy"
#!include "heroes/mercy/init.opy"
#!include "heroes/moira/init.opy"
#!include "heroes/orisa/init.opy"
#!include "heroes/pharah/init.opy"
#!include "heroes/ramattra/init.opy"
#!include "heroes/reaper/init.opy"
#!include "heroes/reinhardt/init.opy"
#!include "heroes/roadhog/init.opy"
#!include "heroes/sigma/init.opy"
#!include "heroes/sojourn/init.opy"
#!include "heroes/soldier/init.opy"
#!include "heroes/sombra/init.opy"
#!include "heroes/symmetra/init.opy"
#!include "heroes/torbjorn/init.opy"
#!include "heroes/tracer/init.opy"
#!include "heroes/venture/init.opy"
#!include "heroes/widowmaker/init.opy"
#!include "heroes/winston/init.opy"
#!include "heroes/wreckingball/init.opy"
#!include "heroes/zarya/init.opy"
#!include "heroes/zenyatta/init.opy"

rule "Hazard Lifesteal heal 2 per spike":
    @Event playerDealtDamage
    @Hero hazard
    @Condition eventAbility == Button.SECONDARY_FIRE
    
    heal(eventPlayer, null, 2)

rule "Control flow for Uppercut":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.isUsingAbility2() == true
    
    executeUppercut()


def executeUppercut():
    @Name "Execute main logic for Rising Uppercut ability"
    
    #Clear uppercut victims
    eventPlayer.uppercut_victims = []
    #Start of uppercut
    eventPlayer.is_using_uppercut = true
    #Doomfist phases through enemies during uppercut
    eventPlayer.disablePlayerCollision()
    #Doomfist cannot melee during uppercut
    eventPlayer.disallowButton(Button.MELEE)
    #Doomfist cannot shoot during uppercut
    eventPlayer.disallowButton(Button.PRIMARY_FIRE)
    #Doomfist cannot punch during uppercut
    eventPlayer.setSecondaryFireEnabled(false)
    #Uppercut physics
    #Cancel current momentum
    eventPlayer.applyImpulse(eventPlayer.getVelocity(), -1 * eventPlayer.getSpeed(), Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
    #Move laterally in the facing direction
    eventPlayer.applyImpulse(vect(eventPlayer.getFacingDirection().x, 0, eventPlayer.getFacingDirection().z), 5, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
    #Override gravity during uppercut
    eventPlayer.setGravity(0)
    #Deny player from inputting movement commands
    eventPlayer.startForcingThrottle(0, 0, 0, 0, 0, 0)
    eventPlayer.communicate(Comms.GOODBYE)
    wait(0.15)
    eventPlayer.applyImpulse(Vector.UP, 40, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
    wait(0.1)
    eventPlayer.applyImpulse(Vector.DOWN, max(0, eventPlayer.getSpeedInDirection(Vector.UP)), Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
    #End of uppercut
    eventPlayer.is_using_uppercut = false
    wait()
    eventPlayer.applyImpulse(Vector.UP, 2.5, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
    eventPlayer.setGravity(0)
    eventPlayer.enablePlayerCollision()
    eventPlayer.allowButton(Button.MELEE)
    eventPlayer.allowButton(Button.PRIMARY_FIRE)
    eventPlayer.setSecondaryFireEnabled(true)
    wait(0.35)
    eventPlayer.setAbility2Enabled(true)
    eventPlayer.stopForcingThrottle()
    wait(0.15)
    eventPlayer.setGravity(50)
    wait(0.25)
    eventPlayer.setGravity(100)


rule "Detect Uppercut Victims":
    @Event eachPlayer
    @Condition any([i.is_using_uppercut == true for i in [player for player in getPlayersInRadius(eventPlayer, 7, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES) if player.getHero() == Hero.DOOMFIST]]) == true
    @Condition angleBetweenVectors(normalize(vect(((([player for player in getPlayersOnHero(Hero.DOOMFIST, getOppositeTeam(eventPlayer.getTeam())) if player.is_using_uppercut == true])[0]).getFacingDirection()).x, 0, ((([player for player in getPlayersOnHero(Hero.DOOMFIST, getOppositeTeam(eventPlayer.getTeam())) if player.is_using_uppercut == true])[0]).getFacingDirection()).z)), directionTowards(([player for player in getPlayersOnHero(Hero.DOOMFIST, getOppositeTeam(eventPlayer.getTeam())) if player.is_using_uppercut == true])[0], eventPlayer)) <= 90
    @Condition eventPlayer in ((([player for player in getPlayersOnHero(Hero.DOOMFIST, getOppositeTeam(eventPlayer.getTeam())) if player.is_using_uppercut == true])[0]).uppercut_victims) == false
    @Condition eventPlayer.Orisa_fortified == null
    
    (([player for player in getPlayersOnHero(Hero.DOOMFIST, getOppositeTeam(eventPlayer.getTeam())) if player.is_using_uppercut == true])[0]).uppercut_victims.append(eventPlayer)
    damage(eventPlayer, ([player for player in getPlayersOnHero(Hero.DOOMFIST, getOppositeTeam(eventPlayer.getTeam())) if player.is_using_uppercut == true])[0], 60 / getPlayersOnHero(Hero.DOOMFIST, getOppositeTeam(eventPlayer.getTeam())).macro_pvar[0])
    playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.WHITE, eventPlayer, 1)
    playEffect(getAllPlayers(), DynamicEffect.EXPLOSION_SOUND, Color.WHITE, eventPlayer, 80)
    #eventPlayer.applyImpulse(Vector.UP, 13, Relativity.TO_PLAYER)
    #Uppercut physics
    #Cancel current momentum
    eventPlayer.applyImpulse(eventPlayer.getVelocity(), -1 * eventPlayer.getSpeed(), Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
    eventPlayer.applyImpulse(vect(((([player for player in getPlayersOnHero(Hero.DOOMFIST, getOppositeTeam(eventPlayer.getTeam())) if player.is_using_uppercut == true])[0]).getFacingDirection()).x, 0, ((([player for player in getPlayersOnHero(Hero.DOOMFIST, getOppositeTeam(eventPlayer.getTeam())) if player.is_using_uppercut == true])[0]).getFacingDirection()).z), 5, Relativity.TO_WORLD)
    #Override gravity during uppercut
    eventPlayer.setGravity(0)
    wait(0.15)
    eventPlayer.applyImpulse(Vector.UP, 40, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
    wait(0.1)
    eventPlayer.applyImpulse(Vector.DOWN, max(0, eventPlayer.getSpeedInDirection(Vector.UP)), Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
    wait()
    eventPlayer.applyImpulse(Vector.UP, 2.5, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
    eventPlayer.setGravity(0)
    wait(0.35)
    eventPlayer.stopForcingThrottle()
    wait(0.15)
    eventPlayer.setGravity(50)
    wait(0.25)
    eventPlayer.setGravity(100)


rule "Shields for Uppercut":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.is_using_uppercut == true
    
    waitUntil(eventPlayer.is_using_uppercut == false, 99999)
    eventPlayer.number_of_victims_uppercut = len(eventPlayer.uppercut_victims)
    eventPlayer.addHealthPool(Health.NORMAL, eventPlayer.number_of_victims_uppercut * 25, false)
    eventPlayer.doom_uppercut_shields = getLastCreatedHealthPool()


rule "Cancel Powerblock animation":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.isUsingAbility2() == true
    
    wait(0.15)
    eventPlayer.setAbility2Enabled(false)


def initDoomfist():
    @Name "[doomfist/init.opy]: initDoomfistDPS()"
    
    eventPlayer.custom_hp_pvar[0] = 15
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1750
    removeTankPassive()
    eventPlayer.startScalingSize(0.92)
    eventPlayer.macro_pvar[0] = 0.82
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.max_health_scaler = 0.625
    eventPlayer.hero_initialized = true


rule "doom cap health at 400":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.getHealth() > 400
    
    eventPlayer.setHealth(400)


rule "[kiriko/protection_suzu.opy]: correct suzu healing":
    @Event playerDealtHealing
    @Hero kiriko
    @Condition eventAbility == Button.ABILITY_2
    
    heal(healee, eventPlayer, eventHealing / eventPlayer.macro_pvar[1] - eventHealing)


rule "Roadhog true damage":
    @Event playerDealtDamage
    @Hero roadhog
    @Condition Button.PRIMARY_FIRE == eventAbility
    
    damage(victim, eventPlayer, 10 / eventPlayer.macro_pvar[0])
    wait(0.625)


rule "Torbjörn turret damage increase":
    @Event playerDealtDamage
    @Hero torbjorn
    @Condition Button.ABILITY_1 == eventAbility
    
    damage(victim, eventPlayer, 1 / eventPlayer.macro_pvar[0])


rule "player died":
    @Event playerDied
    
    eventPlayer.Hanzo_Marked_icon = null
    destroyInWorldText(eventPlayer.Hanzo_Marked_effect)
    eventPlayer.Hanzo_Marked_effect = null
    if eventPlayer.getHero() == Hero.ORISA:
        eventPlayer.Orisa_heat = 0
        eventPlayer.Orisa_Ammo = 100


rule "Orisa subtract ammo generate heat":
    @Event eachPlayer
    @Hero orisa
    @Condition updateEveryFrame(eventPlayer.isFiringPrimaryFire()) == true
    
    eventPlayer.Orisa_Ammo--
    eventPlayer.Orisa_heat += 4
    wait(0.1)
    if ruleCondition:
        loop()


rule "Orisa ammo refresh":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.Orisa_Ammo <= 0
    
    eventPlayer.setAmmo(0, 0)
    chaseAtRate(eventPlayer.Orisa_Ammo, 100, 33)
    eventPlayer.setPrimaryFireEnabled(false)
    #damage(getPlayersInRadius(eventPlayer + Vector.UP, 6, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES_AND_ENEMY_BARRIERS), eventPlayer, eventPlayer.Orisa_heat / eventPlayer.macro_pvar[0])
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.ORANGE, eventPlayer, 8)
    (getPlayersInRadius(eventPlayer + Vector.UP, 8, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES_AND_ENEMY_BARRIERS)).startDamageOverTime(eventPlayer, 3, eventPlayer.Orisa_heat / 2.5 / eventPlayer.macro_pvar[0])
    getPlayersInRadius(eventPlayer, 8, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES).setStatusEffect(eventPlayer, Status.BURNING, 3)
    wait(1)
    waitUntil(eventPlayer.Orisa_Ammo >= 100, 99999)
    eventPlayer.Orisa_heat = 0
    eventPlayer.setPrimaryFireEnabled(true)
    stopChasingVariable(eventPlayer.Orisa_Ammo)


rule "Orisa reload":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isHoldingButton(Button.RELOAD) == true
    
    eventPlayer.Orisa_Ammo = 0


rule "Orisa lock heat at 100":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.Orisa_heat > 100
    
    eventPlayer.Orisa_heat = 100


rule "Heat animation 100":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.Orisa_heat > 90
    
    eventPlayer.setStatusEffect(null, Status.BURNING, 9999)
    eventPlayer.startDamageOverTime(eventPlayer, 9999, 20)
    eventPlayer.Orisa_Overheating = getLastDamageOverTimeId()
    waitUntil(eventPlayer.Orisa_heat <= 89, 99999)
    eventPlayer.clearStatusEffect(Status.BURNING)
    stopDamageOverTime(eventPlayer.Orisa_Overheating)
    eventPlayer.Orisa_Overheating = null


rule "[lucio/ampitup.opy]: begin ally tracking":
    @Event eachPlayer
    @Hero lucio
    @Condition eventPlayer.isUsingAbility1() == true
    @Condition eventPlayer.isUsingAbility2() == true
    
    getPlayersInRadius(eventPlayer, 12, eventPlayer.getTeam(), LosCheck.SURFACES).exclude(eventPlayer).Within_speed_radius = true
    wait(0.125)
    if ruleCondition:
        loop()


rule "[lucio/ampitup.opy]: decrease speed for allies":
    @Event eachPlayer
    @Condition eventPlayer.Within_speed_radius == true
    
    eventPlayer.MoveSpeed -= 6.25
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    wait(0.125)
    eventPlayer.MoveSpeed += 6.25
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    eventPlayer.Within_speed_radius = false


rule "[junkerqueen/commanding_shout.opy]: increase overhealth for allies":
    @Event eachPlayer
    @Condition eventPlayer.within_shout_radius == true
    
    #eventPlayer.MoveSpeed = eventPlayer.MoveSpeed + 3.8
    #eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    eventPlayer.addHealthPool(Health.NORMAL, 9.5, false, false)
    eventPlayer.Junkerqueen_overhealth = getLastCreatedHealthPool()
    wait(2.9)
    #eventPlayer.setMoveSpeed(100 * eventPlayer.macro_pvar[2] * 1.35)
    eventPlayer.MoveSpeed += 30
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    wait(1.9)
    #eventPlayer.setMoveSpeed(100 * eventPlayer.macro_pvar[2])
    eventPlayer.MoveSpeed -= 30
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    removeHealthPool(eventPlayer.Junkerqueen_overhealth)
    eventPlayer.Junkerqueen_overhealth = null
    eventPlayer.within_shout_radius = false


rule "[lucio/ampitup.opy]: decrease speed for Lucio":
    @Event eachPlayer
    @Hero lucio
    @Condition eventPlayer.isUsingAbility1() == true
    @Condition eventPlayer.isUsingAbility2() == true
    
    eventPlayer.MoveSpeed -= 6.25
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    wait(3)
    eventPlayer.MoveSpeed += 6.25
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)


rule "[doomfist/init.opy]: Increase headshot damage taken":
    @Event playerTookDamage
    @Hero doomfist
    @Condition eventWasCriticalHit == true
    
    damage(eventPlayer, attacker, eventDamage * 0.25)


rule "Orisa burn during fortify":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isUsingAbility1() == true
    @Disabled
    
    (getPlayersInRadius(eventPlayer + Vector.UP, 8, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES_AND_ENEMY_BARRIERS)).startDamageOverTime(eventPlayer, 1, eventPlayer.Orisa_heat / 2.5 / eventPlayer.macro_pvar[0])
    getPlayersInRadius(eventPlayer, 8, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES).setStatusEffect(eventPlayer, Status.BURNING, 1)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.ORANGE, eventPlayer, 8)
    wait(1)
    if ruleCondition:
        loop()


rule "[mercy/ressurect.opy]: Mercy rez":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.isUsingUltimate() == true
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE) == true
    @Condition eventPlayer.isAlive() == true
    @Condition len(getPlayersInRadius(eventPlayer, 5.5, eventPlayer.getTeam(), LosCheck.SURFACES).exclude(getLivingPlayers(Team.ALL))) > 0
    @Condition eventPlayer.Mercy_Rez_charges == 1
    
    eventPlayer.MercyUltTrack = 0
    eventPlayer.setUltCharge(0)
    destroyHudText(eventPlayer.RezHUD)
    eventPlayer.RezHUD = null
    eventPlayer.communicate(Comms.HELLO)
    #Set rez target
    eventPlayer.RezTarget = sorted(getPlayersInRadius(eventPlayer, 5.5, eventPlayer.getTeam(), LosCheck.SURFACES).exclude(getLivingPlayers(eventPlayer.getTeam())), lambda i: angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer, i)))[0]
    #Show rez in killfeed (skews mercy's elims and target's deaths by 1, but whatever)
    eventPlayer.RezTarget.resurrect()
    eventPlayer.RezTarget.setStatusEffect(null, Status.PHASED_OUT, 0.1)
    eventPlayer.RezTarget.setHealth(0.01)
    kill(eventPlayer.RezTarget, eventPlayer)
    wait()
    #Real rez
    eventPlayer.RezTarget.resurrect()
    eventPlayer.RezTarget.setStatusEffect(null, Status.PHASED_OUT, 2.25)
    eventPlayer.RezTarget.setStatusEffect(null, Status.FROZEN, 1.5)
    eventPlayer.RezTarget.setHealth(eventPlayer.RezTarget.getMaxHealth())
    playEffect(getAllPlayers(), DynamicEffect.GOOD_PICKUP_EFFECT, Color.YELLOW, eventPlayer.RezTarget, 5)
    playEffect(getAllPlayers(), DynamicEffect.BUFF_IMPACT_SOUND, Color.WHITE, eventPlayer.RezTarget, 110)
    eventPlayer.RezTarget.setAmmo(0, eventPlayer.RezTarget.getMaxAmmo())
    eventPlayer.RezTarget.setAmmo(1, eventPlayer.RezTarget.getMaxAmmo(1))
    #0.75s recovery
    eventPlayer.disallowButton(Button.PRIMARY_FIRE)
    eventPlayer.disallowButton(Button.SECONDARY_FIRE)
    eventPlayer.disallowButton(Button.MELEE)
    eventPlayer.disallowButton(Button.ABILITY_2)
    #Disable target abilities for 0.75s movement window in invuln
    eventPlayer.RezTarget.disallowButton(Button.ABILITY_1)
    eventPlayer.RezTarget.disallowButton(Button.ABILITY_2)
    eventPlayer.RezTarget.disallowButton(Button.PRIMARY_FIRE)
    eventPlayer.RezTarget.disallowButton(Button.SECONDARY_FIRE)
    eventPlayer.RezTarget.disallowButton(Button.ULTIMATE)
    eventPlayer.RezTarget.disallowButton(Button.MELEE)
    #End recovery
    wait(0.5)
    eventPlayer.allowButton(Button.PRIMARY_FIRE)
    eventPlayer.allowButton(Button.SECONDARY_FIRE)
    eventPlayer.allowButton(Button.MELEE)
    eventPlayer.allowButton(Button.ABILITY_2)
    #End of target invuln, enable abilities
    wait(1.75)
    eventPlayer.RezTarget.allowButton(Button.ABILITY_1)
    eventPlayer.RezTarget.allowButton(Button.ABILITY_2)
    eventPlayer.RezTarget.allowButton(Button.PRIMARY_FIRE)
    eventPlayer.RezTarget.allowButton(Button.SECONDARY_FIRE)
    eventPlayer.RezTarget.allowButton(Button.ULTIMATE)
    eventPlayer.RezTarget.allowButton(Button.MELEE)
    eventPlayer.RezTarget = null
    eventPlayer.Mercy_Rez_charges = null


rule "[mercy/imbue.opy]: Mercy imbue target icon":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0
    @Condition eventPlayer.ImbueTargetIcon == null
    
    createInWorldText(eventPlayer if ((sorted([player for player in getPlayersInRadius(eventPlayer, 20.5, eventPlayer.getTeam(), LosCheck.SURFACES_AND_ENEMY_BARRIERS) if eventPlayer.isInViewAngle(player.getPosition(), 2.5 + 120 / distance(eventPlayer, player)) and player != eventPlayer and player.isAlive()], lambda i: angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getPosition(), i.getPosition()))))[0]) != null and not eventPlayer.isInAlternateForm() else null, "+", (((sorted([player for player in getPlayersInRadius(eventPlayer, 20.5, eventPlayer.getTeam(), LosCheck.SURFACES_AND_ENEMY_BARRIERS) if eventPlayer.isInViewAngle(player.getPosition(), 2.5 + 120 / distance(eventPlayer, player)) and player != eventPlayer and player.isAlive()], lambda i: angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getPosition(), i.getPosition()))))[0]).getEyePosition()) + vect(0, 1, 0), 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.BLUE if eventPlayer.isFiringSecondaryFire() else Color.YELLOW)
    eventPlayer.ImbueTargetIcon = getLastCreatedText()


rule "[mercy/ressurect.opy]: Mercy rez HUD":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.isUsingUltimate() == true
    @Condition eventPlayer.RezHUD == null
    @Condition eventPlayer.isUsingUltimate() == true
    @Condition eventPlayer.Mercy_Rez_charges == 1
    
    hudHeader(eventPlayer if eventPlayer.isAlive() and len(getPlayersInRadius(eventPlayer, 5.5, eventPlayer.getTeam(), LosCheck.SURFACES).exclude(getLivingPlayers(Team.ALL))) > 0 else null, "Resurrect {0}".format(heroIcon(sorted(getPlayersInRadius(eventPlayer, 5.5, eventPlayer.getTeam(), LosCheck.SURFACES).exclude(getLivingPlayers(eventPlayer.getTeam())), lambda i: angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer, i)))[0].getHero())), HudPosition.TOP, 0, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING)
    eventPlayer.RezHUD = getLastCreatedText()


rule "[mercy/imbue.opy]: Mercy imbue":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2) == true
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0
    @Condition ((sorted([i for i in getPlayersInRadius(eventPlayer, 20.5, eventPlayer.getTeam(), LosCheck.SURFACES_AND_ENEMY_BARRIERS).exclude(eventPlayer).exclude(getDeadPlayers(eventPlayer.getTeam())) if eventPlayer.isInViewAngle(i.getPosition(), 2.5 + 120 / distance(eventPlayer, i))], lambda i: angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getPosition(), i.getPosition()))))[0] != null or eventPlayer.isInAlternateForm()) == true
    
    #Vanilla rez cd hero setting needs to be changed if cooldown is changed so icon matches
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, 15)
    eventPlayer.setAbility2Enabled(true)
    destroyInWorldText(eventPlayer.ImbueTargetIcon)
    eventPlayer.ImbueTargetIcon = null
    #eventPlayer.ImbueSecondary = true if eventPlayer.isFiringSecondaryFire() else false
    eventPlayer.ImbueSecondary = 1 if eventPlayer.isFiringSecondaryFire() or eventPlayer.isInAlternateForm() else null
    if eventPlayer.isInAlternateForm():
        eventPlayer.ImbueTarget = eventPlayer
        eventPlayer.ImbueSecondary = 2
    else:
        #Set target
        eventPlayer.ImbueTarget = (sorted([player for player in getPlayersInRadius(eventPlayer, 20.5, eventPlayer.getTeam(), LosCheck.SURFACES_AND_ENEMY_BARRIERS) if eventPlayer.isInViewAngle(player.getPosition(), 2.5 + 120 / distance(eventPlayer, player)) and player != eventPlayer and player.isAlive()], lambda i: angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getPosition(), i.getPosition()))))[0]
        bigMessage(eventPlayer.ImbueTarget, "Damage Imbued" if eventPlayer.ImbueSecondary else "Heal Imbued")
    #Duration
    eventPlayer.ImbueDuration = 5
    chaseAtRate(eventPlayer.ImbueDuration, 0, 1)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 80)
    createBeam(getAllPlayers() if eventPlayer.ImbueTarget != null else null, Beam.BAD, eventPlayer, eventPlayer.ImbueTarget, Color.BLUE if eventPlayer.isFiringSecondaryFire() else Color.YELLOW, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.ImbueBeam = getLastCreatedEntity()
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, (Color.TEAM_1 if eventPlayer.getTeam() == Team.1 else Color.TEAM_2) if eventPlayer.ImbueSecondary else Color.YELLOW, eventPlayer.ImbueTarget, 8)
    #Destroy beam and sparkle
    wait(0.2)
    destroyEffect(eventPlayer.ImbueBeam)
    #Wait = cooldown - 0.3 (stops vanilla rez being usable the frame cooldown ends); rez cooldown needs to be changed in hero settings if cooldown is changed so icon matches
    waitUntil(eventPlayer.isDead() or eventPlayer.getAbilityCooldown(Button.ABILITY_2) <= 0.3 or eventPlayer.getHero() != Hero.MERCY, 14.7)
    if eventPlayer.getHero() != Hero.MERCY:
        return
    eventPlayer.setAbility2Enabled(false)


rule "[lifeweaver/dash.opy]: Silly charge Bug fix 2":
    @Event eachPlayer
    @Hero lifeweaver
    @Condition eventPlayer.Lifeweaver_dash_charges < 0
    
    eventPlayer.Lifeweaver_dash_charges = 0


rule "[hazard/thorn_wall.opy]: Haz cancel wall":
    @Event eachPlayer
    @Hero hazard
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2) == true
    
    #@Condition eventPlayer.isUsingAbility2() == true
    if eventPlayer.Hazard_Bubble_Allowed == true:
        wait(0.14)
        eventPlayer.cancelPrimaryAction()


rule "[hazard/thorn_wall.opy]: Target Teammate":
    @Event eachPlayer
    @Hero hazard
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0
    
    eventPlayer.hazard_bubble_target = (sorted([player for player in getLivingPlayers(eventPlayer.getTeam()) if angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getEyePosition(), player)) <= 30 and player.hasSpawned() and distance(eventPlayer, player) <= 25 and player != eventPlayer and isInLoS(eventPlayer, player)], lambda i: angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getEyePosition(), i))))[0]
    wait(0.16)
    if ruleCondition:
        loop()


rule "[hazard/thorn_wall.opy]: Target Teammate HUD and allow bubble":
    @Event eachPlayer
    @Hero hazard
    @Condition eventPlayer.hazard_bubble_target != null
    
    #targeting hud
    createInWorldText(eventPlayer if eventPlayer.hazard_bubble_target != null and eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0 else null, " \n\n\n\n\n\n     ︿\n〈      〉\n     ﹀ ", eventPlayer.hazard_bubble_target + vect(0, 0.7, 0), 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, rgb(55, 230, 255, 210))
    eventPlayer.hazard_targeting_hud = getLastCreatedText()
    eventPlayer.setAbility2Enabled(true)
    eventPlayer.Hazard_Bubble_Allowed = true


rule "[hazard/thorn_wall.opy]: Disallow bubble":
    @Event eachPlayer
    @Hero hazard
    @Condition eventPlayer.hazard_bubble_target == null
    
    eventPlayer.setAbility2Enabled(false)
    destroyInWorldText(eventPlayer.hazard_targeting_hud)
    eventPlayer.Hazard_Bubble_Allowed = false


rule "[hazard/thorn_wall.opy]: Confirm Target":
    @Event eachPlayer
    @Hero hazard
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2) == true
    
    if eventPlayer.Hazard_Bubble_Allowed == true:
        eventPlayer.setAbilityCooldown(Button.ABILITY_2, 10)
        eventPlayer.hazard_bubble_target.hazard_bubble_confirmed = true


rule "[hazard/thorn_wall.opy]: Buff Teammate and play effects":
    @Event eachPlayer
    @Condition eventPlayer.hazard_bubble_confirmed == true
    
    eventPlayer.hazard_bubble_confirmed = false
    createEffect(getAllPlayers().exclude(eventPlayer), Effect.BAD_AURA, Color.PURPLE, eventPlayer, 0.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.hazard_bubble_effect = getLastCreatedEntity()
    createEffect(getAllPlayers().exclude(eventPlayer), Effect.SPHERE, Color.PURPLE, eventPlayer, 1.2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.hazard_bubble_effect2 = getLastCreatedEntity()
    getPlayersOnHero(Hero.HAZARD, eventPlayer.getTeam()).hazard_bubble_target = null
    eventPlayer.hazard_bubble_icon = true
    bigMessage(eventPlayer, "{0} Bubbled".format(heroIcon(Hero.HAZARD)))
    playEffect(getAllPlayers(), DynamicEffect.BUFF_IMPACT_SOUND, Color.WHITE, eventPlayer, 80)
    eventPlayer.DamageRecieved -= 50
    eventPlayer.setDamageReceived(eventPlayer.DamageRecieved)
    wait(2.25)
    eventPlayer.DamageRecieved += 50
    eventPlayer.setDamageReceived(eventPlayer.DamageRecieved)
    destroyEffect(eventPlayer.hazard_bubble_effect)
    destroyEffect(eventPlayer.hazard_bubble_effect2)
    eventPlayer.hazard_bubble_icon = null
    eventPlayer.hazard_bubble_effect = null
    eventPlayer.hazard_bubble_effect2 = null


rule "[hazard/thorn_wall.opy]: Return Damage to attacker and heal hazard":
    @Event playerTookDamage
    @Condition eventPlayer.hazard_bubble_icon == true
    
    damage(attacker, getPlayersOnHero(Hero.HAZARD, eventPlayer.getTeam()), eventDamage / 2)
    playEffect(eventPlayer, DynamicEffect.DEBUFF_IMPACT_SOUND, Color.WHITE, eventPlayer, 80)
    heal(getPlayersOnHero(Hero.HAZARD, eventPlayer.getTeam()), null, eventDamage / 4)


rule "[hazard/thorn_wall.opy]: Make immune to CC after 0.1s":
    @Event eachPlayer
    @Condition (eventPlayer.hasStatus(Status.STUNNED) or eventPlayer.hasStatus(Status.ROOTED) or eventPlayer.hasStatus(Status.FROZEN) or eventPlayer.hasStatus(Status.ASLEEP) or eventPlayer.hasStatus(Status.KNOCKED_DOWN)) == true
    @Condition eventPlayer.hazard_bubble_icon == true
    
    if eventPlayer.hazard_bubble_icon == true:
        wait(0.1)
        eventPlayer.clearStatusEffect(Status.KNOCKED_DOWN)
        eventPlayer.clearStatusEffect(Status.ASLEEP)
        eventPlayer.clearStatusEffect(Status.FROZEN)
        eventPlayer.clearStatusEffect(Status.ROOTED)
        eventPlayer.clearStatusEffect(Status.STUNNED)


rule "Orisa heat refresh":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isFiringPrimaryFire() == false
    
    wait(1, Wait.ABORT_WHEN_FALSE)
    chaseAtRate(eventPlayer.Orisa_heat, 0, 25)
    waitUntil(eventPlayer.isFiringPrimaryFire(), 99999)
    stopChasingVariable(eventPlayer.Orisa_heat)


rule "[hazard/init.opy]: Clean up Hazard":
    @Event eachPlayer
    @Condition eventPlayer.hero_setup != Hero.HAZARD
    
    eventPlayer.hazard_bubble_target = null
    destroyInWorldText(eventPlayer.hazard_targeting_hud)
    eventPlayer.Hazard_Bubble_Allowed = null


rule "[mercy/imbue.opy]: Mercy imbue AOE":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.ImbueDuration > 0
    @Condition eventPlayer.ImbueTarget != null
    
    #Aura visuals
    createEffect(getPlayers(Team.ALL if eventPlayer.ImbueSecondary else eventPlayer.getTeam()), Effect.RING, (Color.TEAM_1 if eventPlayer.getTeam() == Team.1 else Color.TEAM_2) if eventPlayer.ImbueSecondary else Color.YELLOW, eventPlayer.ImbueTarget, 8 if eventPlayer.ImbueSecondary else 10, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.ImbueAOERing = getLastCreatedEntity()
    if eventPlayer.ImbueSecondary:
        createEffect(getPlayers(eventPlayer.getTeam()), Effect.ENERGY_SOUND, Color.WHITE, eventPlayer.ImbueTarget, 80, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    else:
        createEffect(getPlayers(eventPlayer.getTeam()), Effect.SPARKLES_SOUND, Color.WHITE, eventPlayer.ImbueTarget, 80, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.ImbueAOESound = getLastCreatedEntity()
    #AoE
    while eventPlayer.ImbueTarget.isAlive() and eventPlayer.ImbueDuration > 0:
        #30 dps for 3 seconds
        if eventPlayer.ImbueSecondary:
            if eventPlayer.ImbueSecondary == 2 and not eventPlayer.isInAlternateForm():
                break
            getPlayersInRadius(eventPlayer.ImbueTarget, 8, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES_AND_ENEMY_BARRIERS).startDamageOverTime(eventPlayer, 0.5, 30 / eventPlayer.macro_pvar[0])
        else:
            heal(eventPlayer.ImbueTarget, eventPlayer, 4 / eventPlayer.macro_pvar[1])
            heal(getPlayersInRadius(eventPlayer.ImbueTarget, 10, eventPlayer.getTeam(), LosCheck.SURFACES_AND_ENEMY_BARRIERS).exclude(eventPlayer.ImbueTarget), eventPlayer, 6 / eventPlayer.macro_pvar[1])
        waitUntil(eventPlayer.ImbueTarget.isDead() or eventPlayer.ImbueDuration == 0, 0.5)
    destroyEffect(eventPlayer.ImbueAOERing)
    destroyEffect(eventPlayer.ImbueAOESound)
    stopChasingVariable(eventPlayer.ImbueDuration)
    eventPlayer.ImbueTarget = null


