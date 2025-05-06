#!include "lobby/lobby.opy"
#!include "constants/adj_constants.opy"
#!include "utilities/hero_switch.opy"
#!include "utilities/hero_reset.opy"

#Global variables

globalvar DEBUG_MODE 1
globalvar enable_regeneration 3
globalvar ANTI_CRASH_ACTIVATE_PERCENT 6
globalvar ANTI_CRASH_HOLD_TIME 7
globalvar ANTI_CRASH_DEACTIVATE_PERCENT 8
globalvar AllTankHeroes 9
globalvar AllDpsHeroes 10
globalvar AllSupportHeroes 11
globalvar AllRoles 12
globalvar NEGATIVE_STATUS_PREVENTS_REFUND 13
globalvar STEALTH_REFUND_FRACTION 14
globalvar MINIMUM_TRANSLOCATOR_COOLDOWN 15
globalvar dpsTime 16
globalvar bot 17


#Player variables

playervar within_shout_radius 0
playervar Status_effect_hud 9
playervar zarya_self_bubble_centre_hud 10
playervar zarya_ally_bubble_centre_hud 11
playervar Ana_Sleepdart_Target 12
playervar HeroCoreActive 13
playervar regen_passive_id 14
playervar self_heal_pvar 15
playervar baptiste_balance_change_check 17
playervar Baptiste_hud 18
playervar sentry_healing_id 19
playervar bash_cooldown 20
playervar punched_victims 21
playervar wall_impacted_victims 22
playervar self_destruct_charge 23
playervar orbital_ray_x 25
playervar orbital_ray_z 26
playervar orbital_ray_final_x 27
playervar orbital_ray_final_z 28
playervar terra_overhealth_id 30
playervar hp_exiting_grasp 32
playervar overload_overhealth 33
playervar primal_pvar 34
playervar adaptive_overhealth_id 35
playervar self_bubble_cd_text 36
playervar self_bubble_cooldown 37
playervar ally_bubble_cd_text 38
playervar ally_bubble_cooldown 39
playervar AllowedHeroes 40
playervar Roadhog_vape_target 41
playervar Roadhog_targeting_hud 42
playervar Roadhog_vape_confirmed 43
playervar Roadhog_vape_effect 44
playervar Roadhog_vape_hud_icon 45
playervar Explaination_Hud 46
playervar JQ_Shout_Hud 47
playervar Cardiac_overdrive_active 48
playervar Hazard_Downpour_effect 49
playervar Mauga_Overdrive_Health 50
playervar Hazard_Downpour_Target 51
playervar Ashe_Dynamite_Healing_ID 52
playervar Status_Effect_Spectator_HUD 53
playervar Lifeweaver_petal_charges 55
playervar Lifeweaver_petal_hud 56
playervar Lifeweaver_dash_charges 57
playervar Lifeweaver_dash_hud 58
playervar Lifeweaver_healing_hud 59
playervar Lifeweaver_healing_cd 60
playervar Lifeweaver_petal_centre_hud 61
playervar Lifeweaver_leap_centre_target 62
playervar Orisa_ring_effect 64
playervar is_firing_excavator 65
playervar clobber_cooldown_accelerator 66
playervar Sombra_invisible 67
playervar Sombra_hud 68
playervar Sombra_virus_target 69
playervar Sombra_targeting_hud 70
playervar Sombra_virus_confirmed 71
playervar Sombra_hack_effect 72
playervar Sombra_hack_icon 73
playervar Sombra_healing_ring 74
playervar stealth_timer 75
playervar Sombra_invis_damage 76
playervar stealth_pvar 77
playervar WidowScopeGlint_effect 78
playervar Bastion_healing_meter 79
playervar BastionHealingSpamProtection 80
playervar Bastion_healing_id 81
playervar Bastion_healing_effect 82
playervar Bastion_healing_sound 83
playervar Bastion_healing_meter_hud 84
playervar HanzoDrawAura 85
playervar damage 86
playervar time 87
playervar textID 88
playervar position 89
playervar Echo_Copy 90
playervar EchoHUD 91
playervar ImbueBeam 92
playervar ImbueTarget 93
playervar ImbueDuration 94
playervar MaugaOverHP 95
playervar ImbueAOERing 97
playervar MaugaShieldBarHUD 98
playervar RezHUD 99
playervar ImbueSparkle 100
playervar ImbueAOESound 101
playervar MercyUltTrack 102
playervar RezTarget 103
playervar ImbueTargetIcon 105
playervar EchoUltSeconds 106
playervar MaugaShieldNumberHUD 107
playervar DoomPunchTrack 108
playervar ReinChargeTrack 109
playervar ImbueSecondary 110


#Subroutine names

subroutine removeTankPassive 9
subroutine showSelfBubbleCD 42
subroutine hideSelfBubbleCD 43
subroutine showAllyBubbleCD 44
subroutine hideAllyBubbleCD 45
subroutine EchoCopy 56


rule "Copyright (c) 2024 Overwatch 1 Emulator & 6v6 Adjustments. See github.com/6v6-Adjustments/6v6-adjustments for license to use this code.":
    disableInspector()


rule "[utilities/global.opy] Initialize player variables":
    @Event eachPlayer
    
    eventPlayer.within_shout_radius = false
    eventPlayer.DamageRecieved = 100
    eventPlayer.MoveSpeed = 100
    eventPlayer.Echo_Copy = false

rule "[utilities/anti_crash.opy]: Activate anti crash":
    @Condition getServerLoad() > ANTI_CRASH_ACTIVATE_PERCENT
    
    wait(ANTI_CRASH_HOLD_TIME, Wait.ABORT_WHEN_FALSE)
    smallMessage(getAllPlayers(), "Crash protection in progress...")
    setSlowMotion(1)
    waitUntil(getServerLoad() < ANTI_CRASH_DEACTIVATE_PERCENT, 999999986991104)
    setSlowMotion(100)


rule "[role_lock.opy]: Global/set all Heroes":
    AllTankHeroes = [Hero.DVA, Hero.DOOMFIST, Hero.JUNKER_QUEEN, Hero.MAUGA, Hero.ORISA, Hero.RAMATTRA, Hero.REINHARDT, Hero.ROADHOG, Hero.SIGMA, Hero.VENTURE, Hero.WINSTON, Hero.WRECKING_BALL, Hero.ZARYA, Hero.HAZARD, Hero.MEI]
    AllDpsHeroes = [Hero.ASHE, Hero.BASTION, Hero.CASSIDY, Hero.ECHO, Hero.GENJI, Hero.HANZO, Hero.JUNKRAT, Hero.PHARAH, Hero.REAPER, Hero.SOJOURN, Hero.SOLDIER, Hero.TORBJORN, Hero.TRACER, Hero.WIDOWMAKER, Hero.SYMMETRA]
    AllSupportHeroes = [Hero.ANA, Hero.BAPTISTE, Hero.BRIGITTE, Hero.ILLARI, Hero.JUNO, Hero.KIRIKO, Hero.LIFEWEAVER, Hero.LUCIO, Hero.MERCY, Hero.MOIRA, Hero.SOMBRA, Hero.ZENYATTA]


rule "[role_lock.opy]: Role Limits":
    AllRoles = [createWorkshopSettingInt("Roles", "Tank Role Cap", 0, 0, 6), createWorkshopSettingInt("Roles", "Damage Role Cap", 0, 0, 6, 1), createWorkshopSettingInt("Roles", "Support Role Cap", 0, 0, 6, 2)]


rule "[role_lock.opy]: Player Init":
    @Event eachPlayer
    
    eventPlayer.AllowedHeroes = getAllHeroes()


rule "[role_lock.opy]: Tank":
    @Event eachPlayer
    @Condition len(([player for player in getPlayers(eventPlayer.getTeam()) if player.getHero() in AllTankHeroes]).exclude(eventPlayer)) >= AllRoles[0]
    @Condition AllRoles[0] > 0
    
    if eventPlayer.Echo_Copy == false:
        eventPlayer.AllowedHeroes.remove(AllTankHeroes)
        eventPlayer.setAllowedHeroes(eventPlayer.AllowedHeroes)
        waitUntil(len(([player for player in getPlayers(eventPlayer.getTeam()) if player.getHero() in AllTankHeroes]).exclude(eventPlayer)) < AllRoles[0], 99999)
        eventPlayer.AllowedHeroes.append(AllTankHeroes)
        eventPlayer.setAllowedHeroes(eventPlayer.AllowedHeroes)


rule "[role_lock.opy]: Damage":
    @Event eachPlayer
    @Condition len(([player for player in getPlayers(eventPlayer.getTeam()) if player.getHero() in AllDpsHeroes]).exclude(eventPlayer)) >= AllRoles[1]
    @Condition AllRoles[1] > 0
    
    if eventPlayer.Echo_Copy == false:
        eventPlayer.AllowedHeroes.remove(AllDpsHeroes)
        eventPlayer.setAllowedHeroes(eventPlayer.AllowedHeroes)
        waitUntil(len(([player for player in getPlayers(eventPlayer.getTeam()) if player.getHero() in AllDpsHeroes]).exclude(eventPlayer)) < AllRoles[1], 99999)
        eventPlayer.AllowedHeroes.append(AllDpsHeroes)
        eventPlayer.setAllowedHeroes(eventPlayer.AllowedHeroes)


rule "[role_lock.opy]: Support":
    @Event eachPlayer
    @Condition len(([player for player in getPlayers(eventPlayer.getTeam()) if player.getHero() in AllSupportHeroes]).exclude(eventPlayer)) >= AllRoles[2]
    @Condition AllRoles[2] > 0
    
    if eventPlayer.Echo_Copy == false:
        eventPlayer.AllowedHeroes.remove(AllSupportHeroes)
        eventPlayer.setAllowedHeroes(eventPlayer.AllowedHeroes)
        waitUntil(len(([player for player in getPlayers(eventPlayer.getTeam()) if player.getHero() in AllSupportHeroes]).exclude(eventPlayer)) < AllRoles[2], 99999)
        eventPlayer.AllowedHeroes.append(AllSupportHeroes)
        eventPlayer.setAllowedHeroes(eventPlayer.AllowedHeroes)


rule "[role_lock.opy]: Skip Assemble Heroes":
    @Condition isAssemblingHeroes() == true
    
    wait(1)
    setMatchTime(1)
    waitUntil(isAssemblingHeroes() == false, 99999)
    setMatchTime(60)


rule "[passives/healing.opy]: Track Health != 100% stop healing then start healing after 5s":
    @Event playerTookDamage
    @Condition enable_regeneration == true
    
    stopHealingOverTime(eventPlayer.regen_passive_id)
    eventPlayer.self_heal_pvar = false
    wait(ADJ_REGEN_TIMER, Wait.RESTART_WHEN_TRUE)
    eventPlayer.self_heal_pvar = true


rule "[passives/healing.opy]: Healing passive amount and ID":
    @Event eachPlayer
    @Condition eventPlayer.self_heal_pvar != false
    @Condition enable_regeneration == true
    
    eventPlayer.startHealingOverTime(null, 16200, ADJ_REGEN_HPS)
    eventPlayer.regen_passive_id = getLastHealingOverTimeId()


rule "[passives/healing.opy]: If health = max health stop healing":
    @Event eachPlayer
    @Condition eventPlayer.getHealth() == eventPlayer.getMaxHealth()
    @Condition enable_regeneration == true
    
    stopHealingOverTime(eventPlayer.regen_passive_id)


def removeTankPassive():
    @Name "[passives/tank/knockback.opy]: removeTankPassive()"
    
    eventPlayer.setKnockbackReceived(130)


rule "[passives/damage/damage_passive.opy]: Remove DPS Passive":
    @Event playerTookDamage
    @Condition attacker.getHero() in getDamageHeroes() == true
    @Condition attacker != victim
    
    if victim.getHero() in getTankHeroes():
        eventPlayer.setHealingReceived(112.5)
    else:
        eventPlayer.setHealingReceived(125)
    wait(0.5)
    wait(2.5, Wait.RESTART_WHEN_TRUE)
    eventPlayer.setHealingReceived(100)


rule "[debug_mode.opy]: Global init":
    @Condition DEBUG_MODE == true
    
    #By Lotto
    dpsTime = createWorkshopSettingInt("Dev Tools", "Calculate DPS over seconds", 20, 1, 200, 1)
    hudSubtext(getAllPlayers(), "[{0}] -- Start/reset the DPS calculation.".format(inputBindingString(Button.INTERACT)), HudPosition.LEFT, 0, Color.GREEN, HudReeval.VISIBILITY_AND_STRING)
    hudSubtext(getAllPlayers(), "[Crouch] + [Jump] -- Spawn a bot.", HudPosition.LEFT, 1, Color.TURQUOISE, HudReeval.VISIBILITY_AND_STRING)
    hudSubtext(getAllPlayers(), "[Crouch] + [Melee] -- Remove all bots.", HudPosition.LEFT, 2, Color.ORANGE, HudReeval.VISIBILITY_AND_STRING)
    hudSubtext(getAllPlayers(), "Hold [Melee] -- Change Hero.", HudPosition.LEFT, 3, Color.ROSE, HudReeval.VISIBILITY_AND_STRING)
    hudSubtext(getAllPlayers(), " ", HudPosition.LEFT, 4, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)


rule "[debug_mode.opy]: Player init":
    @Event eachPlayer
    @Condition DEBUG_MODE == true
    
    chaseAtRate(eventPlayer.time, 0, 1)
    hudText(eventPlayer, eventPlayer.damage, "Total damage", null, HudPosition.LEFT, 5, Color.YELLOW, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudText(eventPlayer, eventPlayer.damage / (dpsTime - eventPlayer.time), "DPS", null, HudPosition.LEFT, 6, Color.RED, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudText(eventPlayer, eventPlayer.time, "Time", null, HudPosition.LEFT, 7, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)


rule "[debug_mode.opy]: Player Dealt Damage":
    @Event playerDealtDamage
    @Condition victim != attacker
    @Condition DEBUG_MODE == true
    
    #Inspired by a damage numbers mode by Darwin
    destroyInWorldText(eventPlayer.textID)
    eventPlayer.position = victim.getEyePosition()
    createInWorldText(eventPlayer, eventDamage, eventPlayer.position, 0.85 + eventDamage / 30, Clip.SURFACES, WorldTextReeval.VISIBILITY_POSITION_AND_STRING)
    eventPlayer.textID = getLastCreatedText()
    chaseAtRate(eventPlayer.position, victim.getEyePosition() + Vector.UP, 0.9, ChaseRateReeval.NONE)
    if eventPlayer.time == 0:
        goto lbl_0
    eventPlayer.damage += eventDamage
    lbl_0:


rule "[debug_mode.opy]: Start":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == true
    @Condition DEBUG_MODE == true
    
    eventPlayer.time = dpsTime
    eventPlayer.damage = 0


rule "[debug_mode.opy]: Spawn bot":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.CROUCH) == true
    @Condition eventPlayer.isHoldingButton(Button.JUMP) == true
    @Condition DEBUG_MODE == true
    
    createDummy(Hero.ANA, getOppositeTeam(eventPlayer.getTeam()), -1, eventPlayer.getPosition(), eventPlayer.getFacingDirection())
    bot = getLastCreatedEntity()
    wait(0.1)
    bot.setMaxHealth(1000)
    bot.startHealingOverTime(null, 16200, 500)


rule "[debug_mode.opy]: Remove all bots":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.CROUCH) == true
    @Condition eventPlayer.isHoldingButton(Button.MELEE) == true
    @Condition DEBUG_MODE == true
    
    destroyAllDummies()
    destroyInWorldText(eventPlayer.textID)


rule "[debug_mode.opy]: Change hero":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.MELEE) == true
    @Condition DEBUG_MODE == true
    
    wait(1, Wait.ABORT_WHEN_FALSE)
    eventPlayer.position = eventPlayer.getPosition()
    eventPlayer.setAllowedHeroes([i for i in getAllHeroes() if eventPlayer.getHero() != i])
    wait(0.1)
    eventPlayer.setAllowedHeroes(getAllHeroes())
    destroyInWorldText(eventPlayer.textID)
    waitUntil(eventPlayer.hasSpawned(), 16200)
    eventPlayer.teleport(eventPlayer.position)


rule "[ana/sleep.opy]: Sleep tanks as long as other heroes":
    @Event playerDealtDamage
    @Hero ana
    @Condition eventAbility == Button.ABILITY_1
    @Condition victim.getHero() in getTankHeroes() == true
    
    waitUntil(victim.hasStatus(Status.ASLEEP) == true, 999999986991104)
    wait(0.2)
    #Sleeping someone on top of sleep doesnt work anymore
    victim.setStatusEffect(attacker, Status.KNOCKED_DOWN, 4.8)
    victim.Ana_Sleepdart_Target = true


rule "[ana/nade.opy]: Increase Biotic Grenade healing":
    @Event playerDealtHealing
    @Hero ana
    @Condition eventAbility == Button.ABILITY_2
    
    heal(healee, healer, eventHealing * 1.334 / eventPlayer.macro_pvar[1] - eventHealing)

def initAshe():
    @Name "[ashe/init.opy]: initAshe()"
    
    eventPlayer.custom_hp_pvar[0] = 200
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2240
    eventPlayer.max_health_scaler = 0.8
    eventPlayer.hero_initialized = true


rule "[ashe/init.opy]: Correct Viper damage":
    @Event playerDealtDamage
    @Hero ashe
    @Condition eventAbility in Button.PRIMARY_FIRE == true
    @Condition eventPlayer.isFiringSecondaryFire() == false
    @Disabled
    
    damage(victim, attacker, eventDamage * 1.143 - eventDamage)


def initBaptiste():
    @Name "[baptiste/init.opy]: initBaptiste()"
    
    eventPlayer.custom_hp_pvar[0] = 200
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2440
    eventPlayer.macro_pvar[0] = 0.96
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.macro_pvar[1] = 0.7
    eventPlayer.setHealingDealt(100 * eventPlayer.macro_pvar[1])
    eventPlayer.baptiste_balance_change_check = true
    eventPlayer.max_health_scaler = 0.8
    eventPlayer.hero_initialized = true


rule "[baptiste/init.opy]: Increase Baptiste melee damage":
    @Event playerDealtDamage
    @Hero baptiste
    @Condition eventAbility in [Button.MELEE] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[baptiste/init.opy]: Increase Biotic Launcher healing":
    @Event playerDealtHealing
    @Hero baptiste
    @Condition eventAbility == Button.SECONDARY_FIRE
    @Condition eventHealing < 35
    @Condition eventPlayer.baptiste_balance_change_check != false
    
    eventPlayer.baptiste_balance_change_check = false
    heal(healee, healer, eventHealing / eventPlayer.macro_pvar[1] * 1.75 - eventHealing)
    wait(0.15)
    eventPlayer.baptiste_balance_change_check = true


rule "[baptiste/init.opy]: Healing indicator":
    @Event eachPlayer
    @Hero baptiste
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0
    @Condition isMatchBetweenRounds() == false
    
    createInWorldText(eventPlayer, "{0} {1}".format(len([player for player in getLivingPlayers(eventPlayer.getTeam()) if distance(eventPlayer, player) <= 12 and isInLoS(eventPlayer, player, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) == true and player.getHero() != Hero.BAPTISTE]), abilityIconString(Hero.BAPTISTE, Button.ABILITY_1)), updateEveryFrame(eventPlayer.getEyePosition() + (100 * (0 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + (-0.35 * (directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 * eventPlayer.getFacingDirection()))), 2)
    eventPlayer.Baptiste_hud = getLastCreatedText()
    waitUntil(eventPlayer.getAbilityCooldown(Button.ABILITY_1) != 0, 99999)
    destroyInWorldText(eventPlayer.Baptiste_hud)


rule "[baptiste/regen_burst.opy]: Correct regenerative burst hps":
    @Event playerDealtHealing
    @Hero baptiste
    @Condition eventAbility == Button.ABILITY_1
    
    #self healing
    if healee == healer:
        heal(healee, healer, eventHealing / eventPlayer.macro_pvar[1] * 3.75 - eventHealing)
        #ally healing
    else:
        heal(healee, healer, eventHealing / eventPlayer.macro_pvar[1] * 2.125 - eventHealing)


rule "[baptiste/regen_burst.opy]: Remove initial burst healing from Regenerative Burst and set cooldown for duplicate":
    @Event eachPlayer
    @Hero baptiste
    @Condition eventPlayer.isUsingAbility1() == true
    
    eventPlayer.setHealingDealt(0)
    waitUntil(not eventPlayer.isUsingAbility1(), 999999986991104)
    eventPlayer.setHealingDealt(100 * eventPlayer.macro_pvar[1])


rule "[baptiste/init.opy]: Clean up Baptiste":
    @Event eachPlayer
    @Condition eventPlayer.hero_setup != Hero.BAPTISTE
    
    destroyInWorldText(eventPlayer.Baptiste_hud)


def initBastion():
    @Name "[bastion/init.opy]: initBastion()"
    
    eventPlayer.custom_hp_pvar[0] = 225
    eventPlayer.custom_hp_pvar[1] = 75
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2300
    eventPlayer.startScalingSize(0.96)
    eventPlayer.hero_initialized = true


rule "[bastion/selfrepair.opy] Heal and drain meter":
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2) == true
    @Condition eventPlayer.hasStatus(Status.KNOCKED_DOWN) != true
    @Condition eventPlayer.hasStatus(Status.ASLEEP) != true
    @Condition eventPlayer.hasStatus(Status.FROZEN) != true
    @Condition eventPlayer.hasStatus(Status.STUNNED) != true
    
    if eventPlayer.Bastion_healing_meter >= 5 and eventPlayer.BastionHealingSpamProtection == false:
        stopChasingVariable(eventPlayer.Bastion_healing_meter)
        chaseAtRate(eventPlayer.Bastion_healing_meter, 0, 25)
        eventPlayer.startHealingOverTime(eventPlayer, 9999, 50)
        eventPlayer.Bastion_healing_id = getLastHealingOverTimeId()
        eventPlayer.disallowButton(Button.PRIMARY_FIRE)
        eventPlayer.disallowButton(Button.SECONDARY_FIRE)
        eventPlayer.disallowButton(Button.ABILITY_1)
        eventPlayer.disallowButton(Button.ULTIMATE)
        #createEffect(getAllPlayers(), Effect.BAD_AURA, Color.YELLOW, eventPlayer + vect(0, 1.5, 0), 0.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        #eventPlayer.Bastion_healing_effect = getLastCreatedEntity()
        #createEffect(getAllPlayers(), Effect.ENERGY_SOUND, Color.WHITE, eventPlayer, 80, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        #eventPlayer.Bastion_healing_sound = getLastCreatedEntity()


rule "[bastion/selfrepair.opy] Stop heal and refill meter":
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2) == false
    
    stopChasingVariable(eventPlayer.Bastion_healing_meter)
    chaseAtRate(eventPlayer.Bastion_healing_meter, 100, 15)
    stopHealingOverTime(eventPlayer.Bastion_healing_id)
    eventPlayer.allowButton(Button.PRIMARY_FIRE)
    eventPlayer.allowButton(Button.SECONDARY_FIRE)
    eventPlayer.allowButton(Button.ABILITY_1)
    eventPlayer.allowButton(Button.ULTIMATE)
    destroyEffect(eventPlayer.Bastion_healing_effect)
    destroyEffect(eventPlayer.Bastion_healing_sound)


rule "[bastion/selfrepair.opy] Disallow Heal if heal meter 0":
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer.Bastion_healing_meter == 0
    
    eventPlayer.startForcingButton(Button.ABILITY_2)
    eventPlayer.stopForcingButton(Button.ABILITY_2)
    eventPlayer.forceButtonPress(Button.ABILITY_2)
    eventPlayer.disallowButton(Button.ABILITY_2)


rule "[bastion/selfrepair.opy] Allow Heal if heal meter >= 25":
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer.Bastion_healing_meter >= 25
    
    eventPlayer.allowButton(Button.ABILITY_2)


rule "[bastion/selfrepair.opy] Create hud":
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer.Bastion_healing_meter != 100
    
    createProgressBarInWorldText(eventPlayer, eventPlayer.Bastion_healing_meter, "({0}) Repair".format(inputBindingString(Button.ABILITY_2)), updateEveryFrame(eventPlayer.getEyePosition() + (100 * (0 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + ((-0.4 - 0.2) * (directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 * eventPlayer.getFacingDirection()))), 0.9, Clip.NONE, Color.YELLOW)
    eventPlayer.Bastion_healing_meter_hud = getLastCreatedText()


rule "[bastion/selfrepair.opy] Destroy hud":
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer.Bastion_healing_meter == 100
    
    destroyProgressBarInWorldText(eventPlayer.Bastion_healing_meter_hud)


rule "[bastion/selfrepair.opy] Bug prevention":
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2) == true
    @Condition eventPlayer.hasStatus(Status.KNOCKED_DOWN) != true
    @Condition eventPlayer.hasStatus(Status.ASLEEP) != true
    @Condition eventPlayer.hasStatus(Status.FROZEN) != true
    @Condition eventPlayer.hasStatus(Status.STUNNED) != true
    
    if eventPlayer.Bastion_healing_meter >= 5:
        waitUntil(not eventPlayer.isHoldingButton(Button.ABILITY_2), 99999)
        eventPlayer.BastionHealingSpamProtection = true
        wait(0.25)
        eventPlayer.BastionHealingSpamProtection = false


rule "[bastion/reconfigure.opy]: Reduce assault form damage and movement speed":
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer.isUsingAbility1() == true
    
    eventPlayer.setDamageReceived(112.5)
    eventPlayer.MoveSpeed = eventPlayer.MoveSpeed - 15
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    wait(0.95)
    eventPlayer.startHealingOverTime(eventPlayer, 8, 15)
    eventPlayer.sentry_healing_id = getLastHealingOverTimeId()
    waitUntil(not eventPlayer.isUsingAbility1(), 999999986991104)
    eventPlayer.setDamageReceived(100)
    eventPlayer.MoveSpeed = eventPlayer.MoveSpeed + 15
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    stopHealingOverTime(eventPlayer.sentry_healing_id)
    eventPlayer.sentry_healing_id = null


rule "[bastion/reconfigure.opy]: Increase movement allowed by self-damage grenade":
    @Event playerDealtDamage
    @Hero bastion
    @Condition eventPlayer.isUsingAbility1() == true
    @Condition attacker == victim
    
    eventPlayer.MoveSpeed = eventPlayer.MoveSpeed + 25
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    #Grace period to make sure the player receives this benefit
    wait(0.1)
    waitUntil(eventPlayer.isOnGround(), 999999986991104)
    #if not ruleCondition:
    #        return
    eventPlayer.MoveSpeed = eventPlayer.MoveSpeed - 25
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)


rule "[bastion/init.opy]: Reduce grenade self-damage":
    @Event playerDealtDamage
    @Hero bastion
    @Condition attacker == victim
    
    heal(victim, null, eventDamage - eventDamage * 0.5)


rule "[bastion/init.opy]: Clean up Bastion":
    @Event eachPlayer
    @Condition eventPlayer.hero_setup != Hero.BASTION
    
    destroyProgressBarInWorldText(eventPlayer.Bastion_healing_meter_hud)
    stopHealingOverTime(eventPlayer.Bastion_healing_id)
    destroyEffect(eventPlayer.Bastion_healing_effect)
    destroyEffect(eventPlayer.Bastion_healing_sound)


def initBrigitte():
    @Name "[brigitte/init.opy]: initBrigitte()"
    
    eventPlayer.custom_hp_pvar[0] = 150
    eventPlayer.custom_hp_pvar[1] = 50
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2625
    eventPlayer.macro_pvar[0] = 0.778
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.macro_pvar[1] = 0.8
    eventPlayer.setHealingDealt(100 * eventPlayer.macro_pvar[1])
    eventPlayer.hero_initialized = true


rule "[brigitte/bash.opy]: Correct Shield Bash damage":
    @Event playerDealtDamage
    @Hero brigitte
    @Condition eventPlayer.isFiringSecondaryFire() == true
    @Condition eventAbility == Button.PRIMARY_FIRE
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[brigitte/bash.opy]: Track Bash cooldown":
    @Event eachPlayer
    @Hero brigitte
    @Condition eventPlayer.isFiringPrimaryFire() == true
    @Condition eventPlayer.isFiringSecondaryFire() == true
    
    eventPlayer.bash_cooldown = 5.3
    chaseAtRate(eventPlayer.bash_cooldown, 0, 1, ChaseRateReeval.NONE)


rule "[brigitte/bash.opy]: Force cooldown for Bash in Rally":
    @Event eachPlayer
    @Hero brigitte
    @Condition eventPlayer.isUsingUltimate() == true
    
    eventPlayer.setAbilityCooldown(Button.PRIMARY_FIRE, eventPlayer.bash_cooldown)


rule "[brigitte/inspire.opy]: Increase Inspire self healing":
    @Event playerDealtHealing
    @Hero brigitte
    @Condition healee == healer
    
    heal(healee, null, eventHealing * 1.25 - eventHealing)


rule "[brigitte/repair_pack.opy]: Increase Repair Pack healing":
    @Event playerDealtHealing
    @Hero brigitte
    @Condition eventAbility == Button.ABILITY_2
    
    heal(healee, healer, eventHealing * 1.25 - eventHealing)


rule "[brigitte/repair_pack.opy]: Extra Repair Pack burst healing":
    @Event playerDealtHealing
    @Hero brigitte
    @Condition eventAbility == Button.ABILITY_2
    @Condition eventHealing >= 19
    
    heal(healee, healer, 5)


rule "[brigitte/init.opy]: Correct Whipshot damage":
    @Event playerDealtDamage
    @Hero brigitte
    @Condition eventAbility == Button.ABILITY_1
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


def initDoomfist():
    @Name "[doomfist/init.opy]: initDoomfist()"
    
    eventPlayer.custom_hp_pvar[0] = 450
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1750
    removeTankPassive()
    eventPlayer.macro_pvar[0] = 0.8
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.max_health_scaler = 0.625
    eventPlayer.hero_initialized = true


rule "[doomfist/meteor_strike.opy]: Correct Meteor Strike and Doomfist melee damage":
    @Event playerDealtDamage
    @Hero doomfist
    @Condition eventAbility in [Button.MELEE, Button.ULTIMATE] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[doomfist/punch.opy]: Initialize rocket punch":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.isFiringSecondaryFire() == true
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true
    
    eventPlayer.macro_pvar[0] = 0.5
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.punched_victims = []
    eventPlayer.wall_impacted_victims = []
    waitUntil(not eventPlayer.isFiringSecondaryFire(), 4)
    wait(0.2)
    eventPlayer.macro_pvar[0] = 0.8
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])


rule "[doomfist/punch.opy]: Find wall impacted victims":
    @Event playerDealtDamage
    @Hero doomfist
    @Condition eventAbility == Button.SECONDARY_FIRE
    @Condition victim in attacker.punched_victims == true
    @Condition victim in attacker.wall_impacted_victims == false
    
    attacker.wall_impacted_victims.append(victim)
    victim.clearStatusEffect(Status.STUNNED)
    #OW1 single punch victim
    if len(attacker.punched_victims) == 1:
        damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])
        #OW2 multi-punch victim
    else:


rule "[doomfist/punch.opy]: Find punched victims":
    @Event playerDealtDamage
    @Hero doomfist
    @Condition eventAbility == Button.SECONDARY_FIRE
    @Condition victim in attacker.punched_victims == false
    
    attacker.punched_victims.append(victim)
    #OW1 single punch victim
    if len(attacker.punched_victims) == 1:
        damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])
        #OW2 multi-punch victim
    else:


rule "[doomfist/init.opy]: Correct Seismic Slam damage":
    @Event playerDealtDamage
    @Hero doomfist
    @Condition eventAbility == Button.ABILITY_1
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] * 0.8 - eventDamage) / eventPlayer.macro_pvar[0])


rule "[doomfist/powerblock.opy]: Reduce Power Block active duration":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.isUsingAbility2() == true
    
    wait(1.75)
    eventPlayer.forceButtonPress(Button.ABILITY_2)


rule "[doomfist/init.opy]: Correct Hand Cannon damage":
    @Event playerDealtDamage
    @Hero doomfist
    @Condition eventAbility == Button.PRIMARY_FIRE
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] * 0.909 - eventDamage) / eventPlayer.macro_pvar[0])


rule "[doomfist/meteorstrike.opy] Doomfist ult remove self healing":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.isUsingUltimate() == true
    
    eventPlayer.setHealingDealt(0)
    waitUntil(not eventPlayer.isUsingUltimate(), 99999)
    eventPlayer.setHealingDealt(100)


def initDva():
    @Name "[dva/init.opy]: initDva()"
    
    #setCustomHp(
    #ADJ_DVA_HEALTH_DUPLICATE if eventPlayer.isDuplicatingAHero() or SETTING_ECHO_TANK_HP else ADJ_DVA_HEALTH,
    #ADJ_DVA_ARMOR_DUPLICATE if eventPlayer.isDuplicatingAHero() or SETTING_ECHO_TANK_HP else ADJ_DVA_ARMOR,
    #0)
    eventPlayer.ult_charge_pvar[1] = 1540
    removeTankPassive()
    eventPlayer.macro_pvar[0] = 0.955
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.self_destruct_charge = 0
    eventPlayer.max_health_scaler = 0.857
    waitUntil(not eventPlayer.isInAlternateForm(), 999999986991104)
    eventPlayer.custom_hp_pvar[0] = 325
    eventPlayer.custom_hp_pvar[1] = 225
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.hero_initialized = true


rule "[dva/boosters.opy]: Reduce Boosters damage":
    @Event playerDealtDamage
    @Hero dva
    @Condition eventAbility == Button.ABILITY_1
    
    heal(victim, null, eventDamage - 0.8 * eventDamage / eventPlayer.macro_pvar[0])


rule "[dva/defense_matrix.opy]: Increase Defense Matrix cooldown":
    @Event eachPlayer
    @Hero dva
    @Condition eventPlayer.isFiringSecondaryFire() == true
    
    #Defense Matrix still goes on cooldown visually even when the ability is disabled, so a faux cooldown was not implemented
    waitUntil(not eventPlayer.isFiringSecondaryFire(), 999999986991104)
    eventPlayer.setSecondaryFireEnabled(false)
    wait(1.5)
    eventPlayer.setSecondaryFireEnabled(true)


rule "[dva/hp.opy]: Correct DVa mech health":
    @Event eachPlayer
    @Condition eventPlayer.hero_setup == Hero.DVA
    @Condition eventPlayer.isInAlternateForm() == false
    @Condition eventPlayer.hero_initialized != false
    
    eventPlayer.custom_hp_pvar[0] = 325
    eventPlayer.custom_hp_pvar[1] = 225
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()


rule "[dva/hp.opy]: Correct DVa pilot health":
    @Event eachPlayer
    @Condition eventPlayer.hero_setup == Hero.DVA
    @Condition eventPlayer.isInAlternateForm() == true
    @Condition eventPlayer.getMaxHealthOfType(Health.NORMAL) != 150
    @Condition eventPlayer.hero_initialized != false
    
    clearCustomHp()


rule "[dva/init.opy]: Reduce Micro Missiles damage":
    @Event playerDealtDamage
    @Hero dva
    @Condition eventAbility == Button.ABILITY_2 == true
    
    #heal(victim, null, eventDamage - eventDamage / eventPlayer.macro_pvar[0])
    heal(eventPlayer, null, 3 * (eventDamage - eventDamage / eventPlayer.macro_pvar[0]))


rule "[dva/init.opy]: Increase D.va other forms of damage":
    @Event playerDealtDamage
    @Hero dva
    @Condition eventAbility in [Button.MELEE, Button.ULTIMATE] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[dva/init.opy]: Force reset ult charge when DVa exits Mech":
    @Event eachPlayer
    @Hero dva
    @Condition eventPlayer.isInAlternateForm() == true
    
    if eventPlayer.isUsingUltimate():
        return
    eventPlayer.setUltCharge(0)


def initEcho():
    @Name "[echo/init.opy]: initEcho()"
    
    eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, 0)
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 0)
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, 0)
    eventPlayer.custom_hp_pvar[0] = 200
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1880
    eventPlayer.macro_pvar[0] = 0.833
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.startScalingSize(0.94)
    eventPlayer.disallowButton(Button.ULTIMATE)
    eventPlayer.hero_initialized = true


rule "[echo/init.opy]: Correct Echo Tri-Shot damage":
    @Event playerDealtDamage
    @Hero echo
    @Condition eventPlayer.isDuplicatingAHero() == false
    @Condition eventAbility == Button.PRIMARY_FIRE
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] * 0.971 - eventDamage) / eventPlayer.macro_pvar[0])


rule "[echo/init.opy]: Correct Echo other forms of damage":
    @Event playerDealtDamage
    @Hero echo
    @Condition eventAbility in [Button.MELEE, Button.ABILITY_2] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


def initGenji():
    @Name "[genji/init.opy]: initGenji()"
    
    eventPlayer.custom_hp_pvar[0] = 200
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1150
    eventPlayer.hero_initialized = true


rule "[genji/dragonblade.opy]: Genji Damage in Ultimate 100":
    @Event playerDealtDamage
    @Hero genji
    @Condition eventPlayer.isUsingUltimate() == true
    @Condition eventAbility == Button.ULTIMATE
    
    heal(victim, null, 10)


rule "[genji/init.opy]: Reduce Deflect duration":
    @Event eachPlayer
    @Hero genji
    @Condition eventPlayer.isUsingAbility2() == true
    
    wait(1.5)
    eventPlayer.forceButtonPress(Button.ABILITY_2)


def initHanzo():
    @Name "[hanzo/init.opy]: initHanzo()"
    
    eventPlayer.custom_hp_pvar[0] = 200
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1680
    eventPlayer.macro_pvar[0] = 0.933
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.hero_initialized = true


rule "[hanzo/weapon.opy]: Hanzo draw aura":
    @Event eachPlayer
    @Hero hanzo
    @Condition eventPlayer.isFiringPrimaryFire() == true
    
    #max draw time
    wait(0.8, Wait.ABORT_WHEN_FALSE)
    createEffect([player for player in getPlayers(getOppositeTeam(eventPlayer.getTeam())) if distance(eventPlayer, player) >= 1 and eventPlayer.isInViewAngle(player.getEyePosition(), 30)], Effect.GOOD_AURA, rgb(239, 47, 60, 125), eventPlayer.getEyePosition(), 0.475, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.HanzoDrawAura = getLastCreatedEntity()
    waitUntil(not eventPlayer.isFiringPrimaryFire(), 100000000)
    destroyEffect(eventPlayer.HanzoDrawAura)


rule "[hanzo/init.opy]: Correct Hanzo other forms of damage":
    @Event playerDealtDamage
    @Hero hanzo
    @Condition eventAbility in [Button.MELEE, Button.PRIMARY_FIRE, Button.ABILITY_1, Button.ULTIMATE] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


def initHazard():
    @Name "[hazard/init.opy]: initHazard()"
    
    eventPlayer.custom_hp_pvar[0] = 300
    eventPlayer.custom_hp_pvar[1] = 150
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2000
    eventPlayer.macro_pvar[0] = 0.8
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.hero_initialized = true


rule "[hazard/init.opy]: Increase Hazard melee, wall, ultimate damage":
    @Event playerDealtDamage
    @Hero hazard
    @Condition eventAbility in [Button.ABILITY_2, Button.ULTIMATE, Button.MELEE] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[hazard/spike_guard.opy] Increase damage on block to 230":
    @Event playerDealtDamage
    @Hero hazard
    @Condition eventAbility == Button.SECONDARY_FIRE
    
    damage(victim, attacker, (0.94 * (eventDamage / eventPlayer.macro_pvar[0]) - eventDamage) / eventPlayer.macro_pvar[0])


rule "[hazard/violent_leap.opy] Increase damage violant leap to 70":
    @Event playerDealtDamage
    @Hero hazard
    @Condition eventAbility == Button.ABILITY_1
    
    damage(victim, attacker, (0.813 * (eventDamage / eventPlayer.macro_pvar[0]) - eventDamage) / eventPlayer.macro_pvar[0])


def initIllari():
    @Name "[illari/init.opy]: initIllari()"
    
    eventPlayer.custom_hp_pvar[0] = 200
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2450
    eventPlayer.macro_pvar[0] = 0.75
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.macro_pvar[1] = 0.75
    eventPlayer.setHealingDealt(100 * eventPlayer.macro_pvar[1])
    eventPlayer.max_health_scaler = 0.8
    eventPlayer.hero_initialized = true


rule "[illari/solar_rifle.opy]: Correct Solar Rifle damage":
    @Event playerDealtDamage
    @Hero illari
    @Condition eventAbility == Button.PRIMARY_FIRE
    
    if eventWasCriticalHit:
        damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] * 1.143 - eventDamage) / eventPlayer.macro_pvar[0])
    else:
        damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[illari/solar_rifle.opy]: Correct Solar Rifle healing":
    @Event eachPlayer
    @Hero illari
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true
    
    eventPlayer.setHealingDealt(100)
    waitUntil(not eventPlayer.isHoldingButton(Button.SECONDARY_FIRE), 999999986991104)
    eventPlayer.setHealingDealt(75)


rule "[illari/init.opy]: Correct Outburst and melee damage":
    @Event playerDealtDamage
    @Hero illari
    @Condition eventAbility in [Button.MELEE, Button.ABILITY_1] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[illari/init.opy]: Correct Pylon self healing":
    @Event playerDealtHealing
    @Hero illari
    @Condition healee == healer
    
    heal(healer, null, eventHealing)


def initJunkerQueen():
    @Name "[junkerqueen/init.opy]: initJunkerQueen()"
    
    eventPlayer.custom_hp_pvar[0] = 425
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2300
    removeTankPassive()
    eventPlayer.macro_pvar[0] = 0.875
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.setHealingDealt(73.563)
    eventPlayer.setKnockbackDealt(64)
    eventPlayer.startScalingSize(0.96)
    eventPlayer.setMaxAmmo(0, 8)
    eventPlayer.setAmmo(0, 8)
    eventPlayer.overhealth_check = false
    eventPlayer.max_health_scaler = 0.714
    eventPlayer.hero_initialized = true


rule "[junkerqueen/carnage.opy]: Reduce Carnage damage":
    @Event eachPlayer
    @Hero junkerQueen
    @Condition eventPlayer.isUsingAbility2() == true
    
    eventPlayer.setDamageDealt(85.714)
    waitUntil(not eventPlayer.isUsingAbility2(), 999999986991104)
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])


rule "[junkerqueen/commanding_shout.opy]: Prepare Commanding Shout ally tracking":
    @Event eachPlayer
    @Hero junkerQueen
    @Condition eventPlayer.isUsingAbility1() == true
    
    getPlayersInRadius(eventPlayer, 15.5, eventPlayer.getTeam(), LosCheck.SURFACES).exclude(eventPlayer).within_shout_radius = true
    eventPlayer.setMoveSpeed(100 * eventPlayer.macro_pvar[2] * 1.038)
    wait(4.9)
    eventPlayer.setMoveSpeed(100 * eventPlayer.macro_pvar[2])


rule "[junkerqueen/commanding_shout.opy]: Reduce Commanding Shout overhealth for allies":
    @Event eachPlayer
    @Condition eventPlayer.within_shout_radius == true
    
    #damage(eventPlayer, null, ((OW2_JUNKERQUEEN_SHOUT_ALLY_OVERHEALTH - ADJ_JUNKERQUEEN_SHOUT_ALLY_OVERHEALTH) + (OW2_JUNKERQUEEN_SHOUT_ALLY_OVERHEALTH * eventPlayer.max_health_scaler - OW2_JUNKERQUEEN_SHOUT_ALLY_OVERHEALTH)))
    #heal(eventPlayer, null, 0.01)
    eventPlayer.setMoveSpeed(100 * eventPlayer.macro_pvar[2] * 1.038)
    wait(2.9)
    eventPlayer.setMoveSpeed(100 * eventPlayer.macro_pvar[2] * 1.35)
    wait(0.9)
    eventPlayer.setMoveSpeed(100 * eventPlayer.macro_pvar[2])
    eventPlayer.within_shout_radius = false


rule "[junkerqueen/jagged_blade.opy]: Correct Jagged Blade impact damage":
    @Event playerDealtDamage
    @Hero junkerQueen
    @Condition eventDamage == 65 * eventPlayer.macro_pvar[0]
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[junkerqueen/jagged_blade.opy]: Increase Jagged Blade pull distance on squishies":
    @Event playerDealtKnockback
    @Hero junkerQueen
    @Condition eventPlayer.isMeleeing() == false
    @Condition victim.getHero() in getTankHeroes() == false
    
    victim.applyImpulse(vect((normalize(eventPlayer.getPosition() - victim.getPosition())).x, 0, (normalize(eventPlayer.getPosition() - victim)).z), 7.5, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)


rule "[junkerqueen/rampage.opy]: Reduce Rampage damage":
    @Event eachPlayer
    @Hero junkerQueen
    @Condition eventPlayer.isUsingUltimate() == true
    
    eventPlayer.setDamageDealt(83.333)
    waitUntil(not eventPlayer.isUsingUltimate(), 999999986991104)
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])


def initJunkrat():
    @Name "[junkrat/init.opy]: initJunkrat()"
    
    #Version or the "resetHealth" subroutine that keeps tire at 100 hp
    eventPlayer.removeAllHealthPools()
    wait()
    #DO NOT REMOVE THIS LINE
    eventPlayer.setMaxHealth(100.001)
    #DO NOT REMOVE THIS LINE
    wait()
    eventPlayer.setMaxHealth(80)
    #eventPlayer.addHealthPool(Health.ARMOR, 1, true, true)
    #eventPlayer.addHealthPool(Health.SHIELDS, 1, true, true)
    #eventPlayer.removeAllHealthPools()
    ##eventPlayer.addHealthPool(Health.NORMAL, 199, true, true)
    #heal(eventPlayer, null, 1)
    resetStats()
    resetStatuses()
    enableAllAbilities()
    eventPlayer.ult_charge_pvar[1] = 1925
    eventPlayer.macro_pvar[0] = 0.875
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    #check mayhem.opy
    eventPlayer.disallowButton(Button.ULTIMATE)
    eventPlayer.hero_initialized = true


rule "[junkrat/mayhem.opy]: Correct Frag Launcher damage":
    @Event playerDealtDamage
    @Hero junkrat
    @Condition eventAbility == Button.PRIMARY_FIRE
    
    #damage(victim, attacker, ((eventDamage/eventPlayer._base_damage_scalar)*(ADJ_JUNKRAT_FRAG_DAMAGE/OW2_JUNKRAT_FRAG_DAMAGE) - eventDamage)/eventPlayer._base_damage_scalar)
    heal(victim, null, (eventDamage / eventPlayer.macro_pvar[0] * 0.8 - eventDamage) * -1)


rule "[junkrat/mayhem.opy]: Correct Junkrat Melee damage":
    @Event playerDealtDamage
    @Hero junkrat
    @Condition eventAbility == Button.MELEE
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[junkrat/mayhem.opy]: Correct Junkrat Trap damage":
    @Event playerDealtDamage
    @Hero junkrat
    @Condition eventAbility == Button.ABILITY_2
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] * 0.9 - eventDamage) / eventPlayer.macro_pvar[0])


rule "[junkrat/mayhem.opy]: Reset damage for Rip-Tire":
    @Event eachPlayer
    @Hero junkrat
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE) == true
    @Condition eventPlayer.isOnGround() == true
    @Condition eventPlayer.getUltCharge() >= 100
    
    eventPlayer.setDamageDealt(100)
    eventPlayer.allowButton(Button.ULTIMATE)
    eventPlayer.forceButtonPress(Button.ULTIMATE)
    eventPlayer.disallowButton(Button.ULTIMATE)
    wait(1)
    #revert damage back after Rip-Tire is deployed
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])


rule "[junkrat/init.opy]: Correct Junkrat invalid health":
    @Event eachPlayer
    @Condition eventPlayer.hero_setup == Hero.JUNKRAT
    @Condition eventPlayer.getMaxHealthOfType(Health.NORMAL) != 200
    @Condition eventPlayer.hero_initialized != false
    
    initJunkrat()


def initJuno():
    @Name "[juno/init.opy]: initJuno()"
    
    eventPlayer.custom_hp_pvar[0] = 125
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 75
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2850
    eventPlayer.macro_pvar[0] = 0.867
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.macro_pvar[1] = 1
    eventPlayer.setHealingDealt(100 * eventPlayer.macro_pvar[1])
    #eventPlayer.disallowButton(Button.ULTIMATE)
    #if eventPlayer.isDummy():
    #eventPlayer.setHealingDealt(percent(ADJ_JUNO_ORBITAL_RAY_HPS/OW2_JUNO_ORBITAL_RAY_HPS))
    #eventPlayer.setHealingDealt(5)
    eventPlayer.setMoveSpeed(109.091)
    eventPlayer.setAmmo(0, 120)
    eventPlayer.setMaxAmmo(0, 120)
    eventPlayer.hero_initialized = true


rule "[juno/init.opy]: Correct Pulsar Torpedo healing and damage":
    @Event eachPlayer
    @Hero juno
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true
    @Condition eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE) < 0.1
    @Condition eventPlayer.isMeleeing() == false
    @Condition eventPlayer.isReloading() == false
    
    eventPlayer.setHealingDealt(58.824)
    eventPlayer.setDamageDealt(58.824)
    waitUntil(eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE) > 0, 4)
    eventPlayer.setHealingDealt(100 * eventPlayer.macro_pvar[1])
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])


rule "[juno/orbital_ray.opy]: Adjust Orbital Ray Healing":
    @Event eachPlayer
    @Hero juno
    @Condition eventPlayer.isUsingUltimate() == true
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.hasStatus(Status.ASLEEP) == false
    @Condition eventPlayer.hasStatus(Status.FROZEN) == false
    @Condition eventPlayer.hasStatus(Status.KNOCKED_DOWN) == false
    @Condition eventPlayer.hasStatus(Status.STUNNED) == false
    
    wait(0.469)
    eventPlayer.orbital_ray_x = (eventPlayer.getPosition() + 1.625 * directionFromAngles(eventPlayer.getHorizontalFacingAngle(), 0)).x
    eventPlayer.orbital_ray_z = (eventPlayer.getPosition() + 1.625 * directionFromAngles(eventPlayer.getHorizontalFacingAngle(), 0)).z
    eventPlayer.orbital_ray_final_x = (eventPlayer.getPosition() + 24.125 * directionFromAngles(eventPlayer.getHorizontalFacingAngle(), 0)).x
    eventPlayer.orbital_ray_final_z = (eventPlayer.getPosition() + 24.125 * directionFromAngles(eventPlayer.getHorizontalFacingAngle(), 0)).z
    chaseOverTime(eventPlayer.orbital_ray_x, eventPlayer.orbital_ray_final_x, 10, ChaseTimeReeval.NONE)
    chaseOverTime(eventPlayer.orbital_ray_z, eventPlayer.orbital_ray_final_z, 10, ChaseTimeReeval.NONE)
    #createBeam(eventPlayer, Beam.GOOD, vect(eventPlayer.orbital_ray_x, 0.0, eventPlayer.orbital_ray_z), vect(eventPlayer.orbital_ray_x, 100.0, eventPlayer.orbital_ray_z), Color.WHITE, EffectReeval.POSITION_AND_RADIUS)
    while eventPlayer.isUsingUltimate():
        ([player for player in getLivingPlayers(eventPlayer.getTeam()) if distance(vect(eventPlayer.orbital_ray_x, 0, eventPlayer.orbital_ray_z), vect(player.getPosition().x, 0, player.getPosition().z)) < 8 and player.getHealth() < player.getMaxHealth() and player.remainingAntiDuration <= 0]).startDamageOverTime(null, 0.098, 65)
        wait(0.098)


rule "[juno/init.opy]: Correct Juno Melee damage":
    @Event playerDealtDamage
    @Hero juno
    @Condition eventAbility == Button.MELEE
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


def initKiriko():
    @Name "[kiriko/init.opy]: initKiriko()"
    
    eventPlayer.custom_hp_pvar[0] = 200
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2400
    eventPlayer.macro_pvar[0] = 0.917
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.macro_pvar[2] = 1.091
    eventPlayer.setMoveSpeed(100 * eventPlayer.macro_pvar[2])
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 5)
    eventPlayer.hero_initialized = true


rule "[kiriko/swift_step.opy]: Force swift step cooldown after spawning":
    @Event playerDied
    @Hero kiriko
    
    waitUntil(eventPlayer.isAlive() and eventPlayer.isInSpawnRoom(), 999999986991104)
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 5)


rule "[kiriko/swift_step.opy]: Heal when using Swift Step":
    @Event eachPlayer
    @Hero kiriko
    @Condition eventPlayer.isUsingAbility1() == true
    
    #grace period to allow SS to cleanse anti-heal effects
    wait(0.1)
    eventPlayer.startHealingOverTime(null, 0.25, 140)


rule "[kiriko/init.opy]: Correct Kiriko melee damage":
    @Event playerDealtDamage
    @Hero kiriko
    @Condition eventAbility == Button.MELEE
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


def initLifeweaver():
    @Name "[lifeweaver/init.opy]: Initialize Lifeweaver"
    
    eventPlayer.custom_hp_pvar[0] = 100
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 100
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2000
    eventPlayer.macro_pvar[0] = 1.25
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.setProjectileSpeed(130)
    createInWorldText(eventPlayer, "{0}".format(ceil(eventPlayer.Lifeweaver_petal_charges)), updateEveryFrame(eventPlayer.getEyePosition() + (100 * (1.92 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + (-2.05 * (directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 * eventPlayer.getFacingDirection()))), 3)
    eventPlayer.Lifeweaver_petal_hud = getLastCreatedText()
    createInWorldText(eventPlayer, "{0}".format(ceil(eventPlayer.Lifeweaver_dash_charges)), updateEveryFrame(eventPlayer.getEyePosition() + (100 * (2.535 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + (-2.05 * (directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 * eventPlayer.getFacingDirection()))), 3)
    eventPlayer.Lifeweaver_dash_hud = getLastCreatedText()
    createInWorldText(eventPlayer, "{0} {1}".format(ceil(eventPlayer.Lifeweaver_petal_charges), abilityIconString(Hero.LIFEWEAVER, Button.ABILITY_1)), updateEveryFrame(eventPlayer.getEyePosition() + (100 * (-0.22 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + (-0.6 * (directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 * eventPlayer.getFacingDirection()))), 1.3)
    eventPlayer.Lifeweaver_petal_centre_hud = getLastCreatedText()
    createInWorldText(eventPlayer, "{0} {1}".format(ceil(eventPlayer.Lifeweaver_dash_charges), abilityIconString(Hero.LIFEWEAVER, Button.JUMP)), updateEveryFrame(eventPlayer.getEyePosition() + (100 * (0.22 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + (-0.6 * (directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 * eventPlayer.getFacingDirection()))), 1.3)
    eventPlayer.Lifeweaver_leap_centre_target = getLastCreatedText()
    eventPlayer.Lifeweaver_petal_charges = 2
    eventPlayer.Lifeweaver_dash_charges = 2
    eventPlayer.hero_initialized = true


rule "[lifeweaver/init.opy]: Reduce Lifeweaver melee damage":
    @Event playerDealtDamage
    @Hero lifeweaver
    @Condition eventAbility == Button.MELEE
    
    heal(victim, null, eventDamage - eventDamage / eventPlayer.macro_pvar[0])


rule "[lifeweaver/init.opy]: Reduce Tree of Life duration":
    @Event eachPlayer
    @Hero lifeweaver
    @Condition eventPlayer.isUsingUltimate() == true
    
    wait(11)
    eventPlayer.forceButtonPress(Button.ULTIMATE)


rule "[lifeweaver/healing.opy]: Correct Healing ammount":
    @Event playerDealtHealing
    @Hero lifeweaver
    @Condition eventAbility != Button.ULTIMATE
    @Condition eventAbility != Button.ABILITY_2
    @Condition eventPlayer != healee
    @Condition eventPlayer.Lifeweaver_healing_cd != true
    
    healee.startHealingOverTime(null, 4, 25)
    healee.Lifeweaver_healing_cd = true


rule "[lifeweaver/petalplatform.opy]: Lose charges and reset cooldown":
    @Event eachPlayer
    @Hero lifeweaver
    @Condition eventPlayer.Lifeweaver_petal_charges != 0
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_1) == true
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0
    
    eventPlayer.Lifeweaver_petal_charges = eventPlayer.Lifeweaver_petal_charges - 1
    if eventPlayer.Lifeweaver_petal_charges != 0:
        #waitUntil(eventPlayer.isUsingAbility1(), 99999)
        wait(0.25)
        eventPlayer.setAbilityCooldown(Button.ABILITY_1, 0)


rule "[lifeweaver/petalplatform.opy]: recharge petal":
    @Event eachPlayer
    @Hero lifeweaver
    @Condition eventPlayer.Lifeweaver_petal_charges != 2
    
    wait(12, Wait.ABORT_WHEN_FALSE)
    eventPlayer.Lifeweaver_petal_charges = eventPlayer.Lifeweaver_petal_charges + 1
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 0)
    if ruleCondition:
        loop()


rule "[lifeweaver/dash.opy]: Lose charges":
    @Event eachPlayer
    @Hero lifeweaver
    @Condition (not eventPlayer.getVerticalSpeed() and not eventPlayer.isOnGround()) == true
    
    wait(0.032, Wait.ABORT_WHEN_FALSE)
    if distance(eventPlayer, eventPlayer + eventPlayer.getVelocity()) >= 8:
        eventPlayer.Lifeweaver_dash_charges = eventPlayer.Lifeweaver_dash_charges - 1
    else:
        if distance(eventPlayer, raycast(eventPlayer, eventPlayer + eventPlayer.getVelocity(), null, null, true).getHitPosition()) <= 5:
            eventPlayer.Lifeweaver_dash_charges = eventPlayer.Lifeweaver_dash_charges - 1


rule "[lifeweaver/dash.opy]: Gain charges":
    @Event eachPlayer
    @Hero lifeweaver
    @Condition eventPlayer.Lifeweaver_dash_charges != 2
    
    wait(6)
    eventPlayer.Lifeweaver_dash_charges = eventPlayer.Lifeweaver_dash_charges + 1
    if ruleCondition:
        loop()


rule "[lifeweaver/dash.opy]: Disable Dash":
    @Event eachPlayer
    @Hero lifeweaver
    @Condition eventPlayer.Lifeweaver_dash_charges == 0
    @Condition eventPlayer.isInAir() == true
    
    eventPlayer.disallowButton(Button.JUMP)
    waitUntil(eventPlayer.isOnGround() == true or eventPlayer.Lifeweaver_dash_charges != 0, 99999)
    eventPlayer.allowButton(Button.JUMP)


rule "[lifeweaver/dash.opy]: Silly charge Bug fix":
    @Event eachPlayer
    @Hero lifeweaver
    @Condition eventPlayer.Lifeweaver_dash_charges > 2
    
    eventPlayer.Lifeweaver_dash_charges = 2


rule "[lifeweaver/grasp.opy] Set grasp cooldown to 10s when target is above 75%hp":
    @Event eachPlayer
    @Hero lifeweaver
    @Condition eventPlayer.isUsingAbility2() == true
    
    if (((sorted([player for player in getLivingPlayers(eventPlayer.getTeam()) if angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getEyePosition(), player)) <= 50 and player.hasSpawned() and distance(eventPlayer, player) <= 30 and player != eventPlayer and isInLoS(eventPlayer, player)], lambda i: angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getEyePosition(), i))))[0]).getHealth()) >= ((((sorted([player for player in getLivingPlayers(eventPlayer.getTeam()) if angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getEyePosition(), player)) <= 50 and player.hasSpawned() and distance(eventPlayer, player) <= 30 and player != eventPlayer and isInLoS(eventPlayer, player)], lambda i: angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getEyePosition(), i))))[0]).getMaxHealth()) * 0.75):
        waitUntil(eventPlayer.isUsingAbility2() == false, 99999)
        eventPlayer.setAbilityCooldown(Button.ABILITY_2, 10)


rule "[lifeweaver/init.opy]: Clean up lifeweaver":
    @Event eachPlayer
    @Condition eventPlayer.hero_setup != Hero.LIFEWEAVER
    
    destroyInWorldText(eventPlayer.Lifeweaver_petal_hud)
    destroyInWorldText(eventPlayer.Lifeweaver_dash_hud)
    destroyInWorldText(eventPlayer.Lifeweaver_healing_hud)
    destroyInWorldText(eventPlayer.Lifeweaver_petal_centre_hud)
    destroyInWorldText(eventPlayer.Lifeweaver_leap_centre_target)


def initLucio():
    @Name "[lucio/init.opy]: initLucio()"
    
    eventPlayer.custom_hp_pvar[0] = 200
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2940
    eventPlayer.macro_pvar[0] = 0.444
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.startScalingSize(0.96)
    eventPlayer.hero_initialized = true


rule "[lucio/init.opy]: Correct Lucio melee damage":
    @Event playerDealtDamage
    @Hero lucio
    @Condition eventAbility == Button.MELEE
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[lucio/init.opy]: Correct Sonic Amplifier damage":
    @Event playerDealtDamage
    @Hero lucio
    @Condition eventAbility == Button.PRIMARY_FIRE
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] * 0.909 - eventDamage) / eventPlayer.macro_pvar[0])


def initMauga():
    @Name "[mauga/init.opy]: initMauga()"
    
    eventPlayer.custom_hp_pvar[0] = 300
    eventPlayer.custom_hp_pvar[1] = 150
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2650
    removeTankPassive()
    eventPlayer.macro_pvar[0] = 0.75
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.balance_change_check = false
    eventPlayer.MaugaOverHP = 200
    createProgressBarInWorldText(eventPlayer, eventPlayer.MaugaOverHP / 2, "", updateEveryFrame(eventPlayer.getEyePosition() + (100 * (0 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + ((0.5 - 0.2) * (directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 * eventPlayer.getFacingDirection()))), 0.7)
    eventPlayer.MaugaShieldBarHUD = getLastCreatedText()
    createInWorldText(eventPlayer, "{0}".format(ceil(eventPlayer.MaugaOverHP)), updateEveryFrame(eventPlayer.getEyePosition() + (100 * (0 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + (0.6 * (directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 * eventPlayer.getFacingDirection()))), 1.6)
    eventPlayer.MaugaShieldNumberHUD = getLastCreatedText()
    wait(1)
    eventPlayer.setAbility1Enabled(true)
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 0)
    eventPlayer.hero_initialized = true


rule "[mauga/cardiac.opy]: Cardiac Use Ability":
    @Event eachPlayer
    @Hero mauga
    @Condition eventPlayer.isUsingAbility2() == true
    
    eventPlayer.addHealthPool(Health.NORMAL, 150, false)
    eventPlayer.Mauga_Overdrive_Health = getLastCreatedHealthPool()
    eventPlayer.DamageRecieved = eventPlayer.DamageRecieved + 40
    eventPlayer.setDamageReceived(eventPlayer.DamageRecieved)
    wait(3)
    removeHealthPool(eventPlayer.Mauga_Overdrive_Health)
    eventPlayer.DamageRecieved = eventPlayer.DamageRecieved - 40
    eventPlayer.setDamageReceived(eventPlayer.DamageRecieved)


rule "[mauga/cardiac.opy]: Mauga Heal Others":
    @Event eachPlayer
    @Condition getPlayersOnHero(Hero.MAUGA, eventPlayer.getTeam()).isUsingAbility2() == true
    @Condition distance(eventPlayer, getPlayersOnHero(Hero.MAUGA, eventPlayer.getTeam())) <= 10.5
    
    eventPlayer.startHealingOverTime(getPlayersOnHero(Hero.MAUGA, eventPlayer.getTeam()), 3, 50)
    eventPlayer.Cardiac_overdrive_active = getLastHealingOverTimeId()
    waitUntil(getPlayersOnHero(Hero.MAUGA, eventPlayer.getTeam()).isUsingAbility2() == false, 3)
    stopHealingOverTime(eventPlayer.Cardiac_overdrive_active)


rule "[mauga/cage.opy]: Reduce Cage Fight duration":
    @Event eachPlayer
    @Hero mauga
    @Condition eventPlayer.isUsingUltimate() == true
    
    wait(6)
    eventPlayer.forceButtonPress(Button.ULTIMATE)


rule "[mauga/init.opy]: Increase Mauga melee damage":
    @Event playerDealtDamage
    @Hero mauga
    @Condition eventAbility in [Button.MELEE] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[mauga/overrun.opy]: Reduce Mauga stomp damage":
    @Event playerDealtDamage
    @Hero mauga
    @Condition eventAbility == Button.ABILITY_1
    
    heal(victim, null, eventDamage - 0.667 * eventDamage / eventPlayer.macro_pvar[0])


rule "[mauga/init.opy]: Clean up Mauga":
    @Event eachPlayer
    @Condition eventPlayer.hero_setup != Hero.MAUGA
    
    destroyProgressBarInWorldText(eventPlayer.MaugaShieldBarHUD)
    destroyInWorldText(eventPlayer.MaugaShieldNumberHUD)


def initMccree():
    @Name "[mccree/init.opy]: initMccree()"
    
    eventPlayer.custom_hp_pvar[0] = 225
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1680
    eventPlayer.macro_pvar[0] = 0.667
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.hero_initialized = true


rule "[mccree/deadeye.opy]: Set damage during deadeye":
    @Event eachPlayer
    @Hero cassidy
    @Condition eventPlayer.isUsingUltimate() == true
    
    eventPlayer.setDamageDealt(100)
    waitUntil(not eventPlayer.isUsingUltimate(), 999999986991104)
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])


rule "[mccree/init.opy]: Correct Cassidy melee damage and gun damage":
    @Event playerDealtDamage
    @Hero cassidy
    @Condition eventAbility in [Button.MELEE, Button.PRIMARY_FIRE] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[mccree/flashbang.opy] Flashbang stun target for 0.4s":
    @Event playerDealtDamage
    @Hero cassidy
    @Condition eventAbility == Button.ABILITY_2
    
    victim.setStatusEffect(eventPlayer, Status.STUNNED, 0.4)


rule "[mei/init.opy]: Increase Mei melee damage":
    @Event playerDealtDamage
    @Hero mei
    @Condition eventAbility == Button.MELEE
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[mei/wall.opy]: Wall cooldown seconds Mei":
    @Event eachPlayer
    @Hero mei
    @Condition eventPlayer.isUsingAbility2() == true
    
    waitUntil(eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true or eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true, 99999)
    if eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true:
        waitUntil(eventPlayer.isUsingAbility2() == false, 99999)
        eventPlayer.setAbilityCooldown(Button.ABILITY_2, 10)


rule "[mei/cryo_freeze.opy]: OW1 Cryo-Freeze healing":
    @Event eachPlayer
    @Hero mei
    @Condition eventPlayer.isUsingAbility1() == true
    
    eventPlayer.setHealingReceived(80)
    waitUntil(not eventPlayer.isUsingAbility1(), 999999986991104)
    eventPlayer.setHealingReceived(100)


rule "[mei/init.opy]: Increase Mei other forms of damage":
    @Event playerDealtDamage
    @Hero mei
    @Condition eventAbility in [Button.PRIMARY_FIRE, Button.MELEE] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


def initMercy():
    @Name "[mercy/init.opy]: initMercy()"
    
    eventPlayer.custom_hp_pvar[0] = 200
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1400
    eventPlayer.macro_pvar[1] = 0.917
    eventPlayer.setHealingDealt(100 * eventPlayer.macro_pvar[1])
    eventPlayer.setAmmo(0, 20)
    eventPlayer.setMaxAmmo(0, 20)
    eventPlayer.disallowButton(Button.ULTIMATE)
    eventPlayer.setAbility2Enabled(false)
    eventPlayer.hero_initialized = true


rule "[mercy/init.opy]: Reduce Valkyrie healing and force self-healing":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.isUsingUltimate() == true
    
    eventPlayer.stopAllHealingOverTime()
    eventPlayer.startHealingOverTime(null, 15, 20)
    heal(eventPlayer, null, 50)
    eventPlayer.setHealingDealt(138.462)
    wait(2)
    eventPlayer.setHealingDealt(92.308)
    waitUntil(not eventPlayer.isUsingUltimate(), 999999986991104)
    eventPlayer.setHealingDealt(100 * eventPlayer.macro_pvar[1])


def initMoira():
    @Name "[moira/init.opy]: initMoira()"
    
    eventPlayer.custom_hp_pvar[0] = 200
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2800
    eventPlayer.macro_pvar[0] = 0.923
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.hero_initialized = true


rule "[moira/coalescence.opy]: Prevent fading during Coalescence":
    @Event eachPlayer
    @Hero moira
    @Condition eventPlayer.isUsingUltimate() == true
    
    eventPlayer.setAbility1Enabled(false)
    eventPlayer.setDamageDealt(82.353)
    eventPlayer.setMoveSpeed(107.143)
    waitUntil(not eventPlayer.isUsingUltimate(), 999999986991104)
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.setMoveSpeed(100 * eventPlayer.macro_pvar[2])
    eventPlayer.setAbility1Enabled(true)


rule "[moira/init.opy]: Increase Moira other forms of damage":
    @Event playerDealtDamage
    @Hero moira
    @Condition eventPlayer.isUsingUltimate() == false
    @Condition eventAbility in [Button.MELEE, Button.ABILITY_2] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


def initOrisa():
    @Name "[orisa/init.opy]: initOrisa()"
    
    eventPlayer.custom_hp_pvar[0] = 225
    eventPlayer.custom_hp_pvar[1] = 225
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1814
    removeTankPassive()
    eventPlayer.macro_pvar[0] = 0.924
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    #if not eventPlayer.isDuplicatingAHero():
    #setBaseDamage(eventPlayer, ADJ_ORISA_JAVELIN_DIRECT_DAMAGE / OW2_ORISA_JAVELIN_DIRECT_DAMAGE)
    eventPlayer.balance_change_check = true
    eventPlayer.hero_initialized = true


rule "[orisa/terra_surge.opy]: Reduce Terra Surge base damage and add bonus overhealth":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isUsingUltimate() == true
    
    eventPlayer.addHealthPool(Health.NORMAL, 150, false)
    eventPlayer.terra_overhealth_id = getLastCreatedHealthPool()
    eventPlayer.setDamageDealt(80)
    waitUntil(not eventPlayer.isUsingUltimate(), 999999986991104)
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    removeHealthPool(eventPlayer.terra_overhealth_id)


rule "[orisa/terra_surge.opy]: Increase Terra Surge overhealth":
    @Event playerDealtDamage
    @Hero orisa
    @Condition eventAbility == Button.ULTIMATE
    #do not include wind-up damage
    @Condition eventDamage >= 50
    
    damage(victim, attacker, 100 - eventDamage)


rule "[orisa/fortify.opy]: -10% damage reduction and shorter cooldown = 10s":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isUsingAbility1() == true
    
    #I don't know where this value comes from or how to calculate it
    damage(eventPlayer, null, 181.8)
    eventPlayer.MoveSpeed = eventPlayer.MoveSpeed + 10
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    eventPlayer.DamageRecieved = eventPlayer.DamageRecieved + 20
    eventPlayer.setDamageReceived(eventPlayer.DamageRecieved)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.ORANGE, eventPlayer, 8)
    createEffect(getAllPlayers(), Effect.RING, Color.ORANGE, eventPlayer, 8, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.Orisa_ring_effect = getLastCreatedEntity()
    waitUntil(eventPlayer.isUsingAbility1() == false, 99999)
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 10)
    eventPlayer.DamageRecieved = eventPlayer.DamageRecieved - 20
    destroyEffect(eventPlayer.Orisa_ring_effect)
    eventPlayer.setDamageReceived(eventPlayer.DamageRecieved)
    eventPlayer.MoveSpeed = eventPlayer.MoveSpeed - 10
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)


rule "[orisa/fortify.opy]: Orisa Fortify others by 10%":
    @Event eachPlayer
    @Condition getPlayersOnHero(Hero.ORISA, eventPlayer.getTeam()).isUsingAbility1() == true
    @Condition distance(eventPlayer, getPlayersOnHero(Hero.ORISA, eventPlayer.getTeam())) < 8
    
    eventPlayer.DamageRecieved = eventPlayer.DamageRecieved - 10
    eventPlayer.setDamageReceived(eventPlayer.DamageRecieved)
    waitUntil(distance(eventPlayer, getPlayersOnHero(Hero.ORISA, eventPlayer.getTeam())) > 8 or getPlayersOnHero(Hero.ORISA, eventPlayer.getTeam()).isUsingAbility1() == false, 99999)
    eventPlayer.DamageRecieved = eventPlayer.DamageRecieved + 10
    eventPlayer.setDamageReceived(eventPlayer.DamageRecieved)


rule "[orisa/fortify.opy]: Orisa damage enemys around her":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isUsingAbility1() == true
    
    (getPlayersInRadius(eventPlayer + Vector.UP, 8, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES)).startDamageOverTime(eventPlayer, 1, 25)
    getPlayersInRadius(eventPlayer, 8, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES).setStatusEffect(eventPlayer, Status.BURNING, 1)
    wait(1, Wait.ABORT_WHEN_FALSE)
    if ruleCondition:
        loop()


rule "[orisa/fortify.opy]: Orisa cancel fortify after 3s":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isUsingAbility1() == true
    
    wait(3)
    eventPlayer.forceButtonPress(Button.ABILITY_1)


rule "[orisa/fortify.opy]: Orisa cancel spin after 1s":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isUsingAbility2() == true
    
    wait(1)
    eventPlayer.forceButtonPress(Button.ABILITY_2)


rule "[orisa/spin.opy]: Movementspeed increase during Spin":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isUsingAbility2() == true
    
    eventPlayer.MoveSpeed = eventPlayer.MoveSpeed + 50
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    waitUntil(eventPlayer.isUsingAbility2() == false, 99999)
    eventPlayer.MoveSpeed = eventPlayer.MoveSpeed - 50
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)


rule "[orisa/init.opy]: Clean up Orisa":
    @Event eachPlayer
    @Condition eventPlayer.hero_setup != Hero.ORISA
    
    destroyEffect(eventPlayer.Orisa_ring_effect)


def initPharah():
    @Name "[pharah/init.opy]: initPharah()"
    
    eventPlayer.custom_hp_pvar[0] = 200
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2100
    eventPlayer.hero_initialized = true


def initRamattra():
    @Name "[ramattra/init.opy]: initRamattra()"
    
    eventPlayer.custom_hp_pvar[0] = 400
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2016
    removeTankPassive()
    eventPlayer.macro_pvar[0] = 1.1
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.max_health_scaler = 0.632
    eventPlayer.hero_initialized = true


rule "[ramattra/nemesis_form.opy]: Correct Nemesis Form armor and movement speed":
    @Event eachPlayer
    @Hero ramattra
    @Condition eventPlayer.isUsingAbility1() == true
    
    eventPlayer.startScalingSize(0.97)
    eventPlayer.setDamageDealt(92.308)
    eventPlayer.MoveSpeed = eventPlayer.MoveSpeed - 20
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    #for some reason the addHealthPool function doesn't read constants as usable numbers
    eventPlayer.addHealthPool(Health.ARMOR, 10, true)
    waitUntil(eventPlayer.getMaxHealthOfType(Health.ARMOR) < 11, 999999986991104)
    eventPlayer.MoveSpeed = eventPlayer.MoveSpeed + 20
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    eventPlayer.stopScalingSize()
    removeHealthPool(getLastCreatedHealthPool())
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])


rule "[ramattra/nemesis_form.opy]: Increase other forms of damage (in nemesis)":
    @Event playerDealtDamage
    @Hero ramattra
    @Condition eventPlayer.isUsingUltimate() == true
    #This condition stops pummel from applying the damage increase
    @Condition eventDamage < 60
    
    damage(victim, null, (eventDamage / 0.923 - eventDamage) / 0.923)


rule "[ramattra/init.opy]: Reduce Ramattra melee damage and vortex damage":
    @Event playerDealtDamage
    @Hero ramattra
    @Condition eventPlayer.getMaxHealthOfType(Health.ARMOR) == false
    @Condition eventAbility in [Button.ABILITY_2, Button.MELEE] == true
    
    heal(victim, null, eventDamage - eventDamage / eventPlayer.macro_pvar[0])


def initReaper():
    @Name "[reaper/init.opy]: initReaper()"
    
    eventPlayer.custom_hp_pvar[0] = 225
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1900
    eventPlayer.macro_pvar[0] = 0.981
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.macro_pvar[1] = 1.2
    eventPlayer.setHealingDealt(100 * eventPlayer.macro_pvar[1])
    eventPlayer.hero_initialized = true


rule "[reaper/init.opy]: Increase Reaper melee damage":
    @Event playerDealtDamage
    @Hero reaper
    @Condition eventAbility == Button.MELEE
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[reaper/init.opy]: Reduce Death Blossom damage":
    @Event eachPlayer
    @Hero reaper
    @Condition eventPlayer.isUsingUltimate() == true
    
    eventPlayer.setDamageDealt(91.892)
    waitUntil(not eventPlayer.isUsingUltimate(), 999999986991104)
    eventPlayer.setDamageDealt(98.148)


def initReinhardt():
    @Name "[reinhardt/init.opy]: initReinhardt()"
    
    eventPlayer.custom_hp_pvar[0] = 275
    eventPlayer.custom_hp_pvar[1] = 275
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1460
    eventPlayer.macro_pvar[0] = 0.85
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.setKnockbackReceived(93.333)
    eventPlayer.stopForcingThrottle()
    eventPlayer.max_health_scaler = 1.067
    eventPlayer.hero_initialized = true


rule "[reinhardt/pin.opy]: Slow Reinhardt after pin":
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer.isUsingAbility1() == true
    
    waitUntil(eventPlayer.isUsingAbility1() == false, 99999)
    eventPlayer.MoveSpeed = eventPlayer.MoveSpeed - 50
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    wait(1)
    eventPlayer.MoveSpeed = eventPlayer.MoveSpeed + 50
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)


rule "[reinhardt/firestrike.opy]: Force single firestrike":
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer.isUsingAbility2() == true
    
    waitUntil(not eventPlayer.isUsingAbility2(), 0.9)
    #Every time rein uses firestrike, reset the resource to 0
    eventPlayer.setAbilityCharge(Button.ABILITY_2, 0)
    wait(6)
    eventPlayer.setAbilityCharge(Button.ABILITY_2, 2)


rule "[reinhardt/firestrike.opy]: decrease Firestrike damage (early animation)":
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer.isUsingAbility2() == true
    
    eventPlayer.setDamageDealt(83.333)
    wait(1)
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])


rule "[reinhardt/charge.opy]: Correct Charge damage":
    @Event playerDealtDamage
    @Hero reinhardt
    @Condition eventAbility == Button.ABILITY_1
    
    #Checks for pin vs boop damage (+ 1 because apparently 50.0 > 50 == true for whatever reason)
    if eventDamage > 51:
        damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])
    else:
        damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[reinhardt/shatter.opy]: Correct Earthshatter damage":
    @Event playerDealtDamage
    @Hero reinhardt
    @Condition eventAbility == Button.ULTIMATE
    @Condition eventWasCriticalHit == false
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[reinhardt/shatter.opy]: Correct Earthshatter critical damage":
    @Event playerDealtDamage
    @Hero reinhardt
    @Condition eventAbility == Button.ULTIMATE
    @Condition eventWasCriticalHit == true
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


def initRoadhog():
    @Name "[roadhog/init.opy]: initRoadhog()"
    
    eventPlayer.custom_hp_pvar[0] = 600
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2380
    removeTankPassive()
    eventPlayer.macro_pvar[0] = 0.831
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.setAmmo(0, 6)
    eventPlayer.setMaxAmmo(0, 6)
    eventPlayer.hero_initialized = true


rule "[roadhog/pigpen.opy]: Cancel Pigpen Animation":
    @Event eachPlayer
    @Hero roadhog
    @Condition eventPlayer.isUsingAbility2() == true
    
    wait(0.08)
    eventPlayer.cancelPrimaryAction()


rule "[roadhog/pigpen.opy]: Target Teammate":
    @Event eachPlayer
    @Hero roadhog
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0
    
    eventPlayer.Roadhog_vape_target = (sorted([player for player in getLivingPlayers(eventPlayer.getTeam()) if angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getEyePosition(), player)) <= 30 and player.hasSpawned() and distance(eventPlayer, player) <= 20 and player != eventPlayer and isInLoS(eventPlayer, player)], lambda i: angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getEyePosition(), i))))[0]
    wait(0.16)
    if ruleCondition:
        loop()


rule "[roadhog/pigpen.opy]: Target Teammate HUD and allow Vape":
    @Event eachPlayer
    @Hero roadhog
    @Condition eventPlayer.Roadhog_vape_target != null
    
    #targeting hud
    createInWorldText(eventPlayer if eventPlayer.Roadhog_vape_target != null and eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0 else null, " \n\n\n\n\n\n     ︿\n〈      〉\n     ﹀ ", eventPlayer.Roadhog_vape_target + vect(0, 0.7, 0), 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, rgb(55, 230, 255, 210))
    eventPlayer.Roadhog_targeting_hud = getLastCreatedText()
    eventPlayer.allowButton(Button.ABILITY_2)


rule "[roadhog/pigpen.opy]: Disallow Vape":
    @Event eachPlayer
    @Hero roadhog
    @Condition eventPlayer.Roadhog_vape_target == null
    
    eventPlayer.disallowButton(Button.ABILITY_2)
    destroyInWorldText(eventPlayer.Roadhog_targeting_hud)


rule "[roadhog/pigpen.opy]: Confirm Target":
    @Event eachPlayer
    @Hero roadhog
    @Condition eventPlayer.isUsingAbility2() == true
    
    eventPlayer.Roadhog_vape_target.Roadhog_vape_confirmed = true


rule "[roadhog/pigpen.opy]: Buff Teammate and play effects":
    @Event eachPlayer
    @Condition eventPlayer.Roadhog_vape_confirmed == true
    
    eventPlayer.Roadhog_vape_confirmed = false
    createEffect(getAllPlayers(), Effect.CLOUD, Color.YELLOW, eventPlayer, 0.9, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.Roadhog_vape_effect = getLastCreatedEntity()
    getPlayersOnHero(Hero.ROADHOG, eventPlayer.getTeam()).Roadhog_vape_target = null
    eventPlayer.Roadhog_vape_hud_icon = true
    bigMessage(eventPlayer, "VAPED")
    playEffect(getAllPlayers(), DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 80)
    eventPlayer.startHealingOverTime(getPlayersOnHero(Hero.ROADHOG, eventPlayer.getTeam()), 3, 60)
    eventPlayer.DamageRecieved = eventPlayer.DamageRecieved - 30
    eventPlayer.setDamageReceived(eventPlayer.DamageRecieved)
    wait(3)
    eventPlayer.DamageRecieved = eventPlayer.DamageRecieved + 30
    eventPlayer.setDamageReceived(eventPlayer.DamageRecieved)
    destroyEffect(eventPlayer.Roadhog_vape_effect)
    eventPlayer.Roadhog_vape_hud_icon = false


rule "[roadhog/breather.opy]: Adjust Breather efficacy":
    @Event eachPlayer
    @Hero roadhog
    @Condition eventPlayer.isFiringSecondaryFire() == true
    
    eventPlayer.setHealingDealt(222.222)
    wait(0.8)
    eventPlayer.setHealingDealt(48.387)
    waitUntil(not eventPlayer.isFiringSecondaryFire(), 999999986991104)
    eventPlayer.setHealingDealt(100)


rule "[roadhog/wholehog.opy]: Disable abilities during wholehog":
    @Event eachPlayer
    @Hero roadhog
    @Condition eventPlayer.isUsingUltimate() == true
    
    eventPlayer.setMeleeEnabled(false)
    eventPlayer.setSecondaryFireEnabled(false)
    eventPlayer.setAbility1Enabled(false)
    eventPlayer.setAbility2Enabled(false)
    eventPlayer.setDamageDealt(100)
    eventPlayer.setKnockbackDealt(100)


rule "[roadhog/wholehog.opy]: Enable abilities after wholehog":
    @Event eachPlayer
    @Hero roadhog
    @Condition eventPlayer.isUsingUltimate() == false
    
    eventPlayer.setMeleeEnabled(true)
    eventPlayer.setSecondaryFireEnabled(true)
    eventPlayer.setAbility1Enabled(true)
    eventPlayer.setAbility2Enabled(true)
    eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.setKnockbackDealt(35)


rule "[roadhog/wholehog.opy]: Force autofire while in wholehog":
    @Event eachPlayer
    @Hero roadhog
    @Condition eventPlayer.isUsingUltimate() == true
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == false
    
    eventPlayer.startForcingButton(Button.PRIMARY_FIRE)


rule "[roadhog/init.opy]: Correct melee damage":
    @Event playerDealtDamage
    @Hero roadhog
    @Condition eventAbility == Button.MELEE
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[roadhog/init.opy]: Correct Chain Hook damage":
    @Event playerDealtDamage
    @Hero roadhog
    @Condition eventAbility == Button.ABILITY_1
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[roadhog/init.opy]: Clean up Roadhog":
    @Event eachPlayer
    @Condition eventPlayer.hero_setup != Hero.ROADHOG
    
    eventPlayer.Roadhog_vape_target = null
    destroyInWorldText(eventPlayer.Roadhog_targeting_hud)
    destroyHudText(eventPlayer.Explaination_Hud[0])


def initSigma():
    @Name "[sigma/init.opy]: initSigma()"
    
    eventPlayer.custom_hp_pvar[0] = 300
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 100
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2275
    removeTankPassive()
    eventPlayer.macro_pvar[0] = 0.75
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.balance_change_check = 0
    eventPlayer.hero_initialized = true


rule "[sigma/init.opy]: Reduce Accretion stun duration":
    @Event playerDealtDamage
    @Hero sigma
    @Condition victim.hasStatus(Status.KNOCKED_DOWN) == true
    
    wait(0.5)
    victim.clearStatusEffect(Status.KNOCKED_DOWN)


rule "[sigma/kinetic_grasp.opy]: Reduce Kinetic Grasp overhealth":
    @Event eachPlayer
    @Hero sigma
    @Condition eventPlayer.isUsingAbility1() == true
    
    wait(1.2, Wait.ABORT_WHEN_FALSE)
    eventPlayer.hp_exiting_grasp = eventPlayer.getHealth()
    waitUntil(not eventPlayer.isUsingAbility1(), 999999986991104)
    damage(eventPlayer, null, 0.3 * (eventPlayer.getHealth() - eventPlayer.hp_exiting_grasp))


rule "[sigma/init.opy]: Increase Sigma other forms of damage":
    @Event playerDealtDamage
    @Hero sigma
    @Condition eventAbility in [Button.MELEE, Button.PRIMARY_FIRE] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[sigma/init.opy]: Increase Gravitic Flux damage":
    @Event eachPlayer
    @Hero sigma
    @Condition eventPlayer.isUsingUltimate() == true
    
    eventPlayer.setDamageDealt(100)
    #waitUntil(not eventPlayer.isUsingUltimate(), 999999986991104)
    waitUntil(eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true or not eventPlayer.isUsingUltimate(), 10)
    wait(1.7)
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])


def initSojourn():
    @Name "[sojourn/init.opy]: initSojourn()"
    
    eventPlayer.custom_hp_pvar[0] = 200
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2100
    eventPlayer.macro_pvar[0] = 0.834
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.hero_initialized = true


rule "[sojourn/primary.opy] Increased primary damage":
    @Event playerDealtDamage
    @Hero sojourn
    @Condition eventAbility == Button.PRIMARY_FIRE
    
    if eventWasCriticalHit == true:
        damage(victim, eventPlayer, 3)
    else:
        damage(victim, eventPlayer, 1.5)


rule "[sojourn/orb.opy] Increased disruptor shot damage":
    @Event playerDealtDamage
    @Hero sojourn
    @Condition eventAbility == Button.ABILITY_2
    
    damage(victim, eventPlayer, 5.2)


rule "[sojourn/ultimate.opy] 200 damage in ult":
    @Event playerDealtDamage
    @Hero sojourn
    @Condition eventPlayer.isUsingUltimate() == true
    @Condition eventAbility == Button.ULTIMATE
    
    if eventWasCriticalHit == true:
        damage(victim, eventPlayer, eventDamage * 0.4)


def initSoldier():
    @Name "[soldier/init.opy]: initSoldier()"
    
    eventPlayer.custom_hp_pvar[0] = 200
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2310
    eventPlayer.macro_pvar[1] = 0.875
    eventPlayer.setHealingDealt(100 * eventPlayer.macro_pvar[1])
    eventPlayer.setAmmo(0, 30)
    eventPlayer.setMaxAmmo(0, 30)
    eventPlayer.hero_initialized = true


def initSombra():
    @Name "[sombra/init.opy]: initSombra()"
    
    eventPlayer.custom_hp_pvar[0] = 200
    eventPlayer.custom_hp_pvar[1] = null
    eventPlayer.custom_hp_pvar[2] = null
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 3000
    eventPlayer.macro_pvar[0] = 0.875
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.Sombra_invisible = false
    createInWorldText(eventPlayer, "{0} {1}".format(len([player for player in getLivingPlayers(eventPlayer.getTeam()) if distance(eventPlayer, player) <= 15 and isInLoS(eventPlayer, player, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) == true and player.getHero() != Hero.SOMBRA]), iconString(Icon.PLUS)), updateEveryFrame(eventPlayer.getEyePosition() + (100 * (0 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + (-0.3 * (directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 * eventPlayer.getFacingDirection()))), 1.8)
    eventPlayer.Sombra_hud = getLastCreatedText()
    eventPlayer.hero_initialized = true


rule "[sombra/init.opy]: Increase Sombra melee damage":
    @Event playerDealtDamage
    @Hero sombra
    @Condition eventAbility == Button.MELEE
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[sombra/virus.opy]: Sombra Virus Cancel":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.isUsingAbility1() == true
    
    wait(0.04)
    eventPlayer.cancelPrimaryAction()


rule "[sombra/virus.opy]: Target Teammate":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0
    
    eventPlayer.Sombra_virus_target = (sorted([player for player in getLivingPlayers(eventPlayer.getTeam()) if angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getEyePosition(), player)) <= 30 and player.hasSpawned() and distance(eventPlayer, player) <= 20 and player != eventPlayer and isInLoS(eventPlayer, player)], lambda i: angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getEyePosition(), i))))[0]
    wait(0.16)
    if ruleCondition:
        loop()


rule "[sombra/virus.opy]: Target Teammate HUD and allow Virus":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.Sombra_virus_target != null
    
    #targeting hud
    createInWorldText(eventPlayer if eventPlayer.Sombra_virus_target != null and eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0 else null, " \n\n\n\n\n\n     ︿\n〈      〉\n     ﹀ ", eventPlayer.Sombra_virus_target + vect(0, 0.7, 0), 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, rgb(55, 230, 255, 210))
    eventPlayer.Sombra_targeting_hud = getLastCreatedText()
    eventPlayer.allowButton(Button.ABILITY_1)


rule "[sombra/virus.opy]: Disallow Virus":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.Sombra_virus_target == null
    
    eventPlayer.disallowButton(Button.ABILITY_1)
    destroyInWorldText(eventPlayer.Sombra_targeting_hud)


rule "[sombra/virus.opy]: Confirm Target":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.isUsingAbility1() == true
    
    eventPlayer.Sombra_virus_target.Sombra_virus_confirmed = true


rule "[sombra/virus.opy]: Buff Teammate and play effects":
    @Event eachPlayer
    @Condition eventPlayer.Sombra_virus_confirmed == true
    
    eventPlayer.Sombra_virus_confirmed = false
    bigMessage(eventPlayer, "HACKED")
    getPlayersOnHero(Hero.SOMBRA, eventPlayer.getTeam()).Sombra_virus_target = null
    createInWorldText(getAllPlayers(), abilityIconString(Hero.SOMBRA, Button.ULTIMATE), eventPlayer + vect(0, 2.5, 0), 2, Clip.SURFACES, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.PURPLE)
    eventPlayer.Sombra_hack_effect = getLastCreatedText()
    eventPlayer.Sombra_hack_icon = true
    eventPlayer.startHealingOverTime(getPlayersOnHero(Hero.SOMBRA, eventPlayer.getTeam()), 5, 35)
    playEffect(getAllPlayers(), DynamicEffect.GOOD_PICKUP_EFFECT, Color.PURPLE, eventPlayer, 90)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.PURPLE, eventPlayer + Vector.UP, 4)
    playEffect(getAllPlayers(), DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 80)
    eventPlayer.MoveSpeed = eventPlayer.MoveSpeed + 30
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    wait(5)
    eventPlayer.MoveSpeed = eventPlayer.MoveSpeed - 30
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    destroyInWorldText(eventPlayer.Sombra_hack_effect)
    eventPlayer.Sombra_hack_icon = false


rule "[sombra/heal.opy]: If visiable heal 15m 40 - players *6":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.Sombra_invisible == false
    
    ([player for player in getLivingPlayers(eventPlayer.getTeam()) if distance(eventPlayer, player) <= 15 and isInLoS(eventPlayer, player) == true and player.getHero() != Hero.SOMBRA]).startHealingOverTime(eventPlayer, 1, 38 - ((len([player for player in getLivingPlayers(eventPlayer.getTeam()) if distance(eventPlayer, player) <= 15 and isInLoS(eventPlayer, player, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) == true and player.getHero() != Hero.SOMBRA])) * 6))
    eventPlayer.startHealingOverTime(null, 1, 18 - ((len([player for player in getLivingPlayers(eventPlayer.getTeam()) if distance(eventPlayer, player) <= 15 and isInLoS(eventPlayer, player, BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) == true and player.getHero() != Hero.SOMBRA])) * 6))
    wait(1)
    if ruleCondition:
        loop()


rule "[sombra/heal.opy]: Healing Ring sombra":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.Sombra_invisible == false
    
    createEffect(getPlayers(eventPlayer.getTeam()), Effect.RING, Color.PURPLE, eventPlayer, 15, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.Sombra_healing_ring = getLastCreatedEntity()
    waitUntil(eventPlayer.Sombra_invisible == true or eventPlayer.getHero() != Hero.SOMBRA, 99999)
    destroyEffect(eventPlayer.Sombra_healing_ring)


rule "[sombra/translocator.opy]: Sombra Invis Increase move Speed":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer.Sombra_invisible == true
    
    eventPlayer.MoveSpeed = eventPlayer.MoveSpeed + 10
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    waitUntil(eventPlayer.Sombra_invisible == false, 99999)
    eventPlayer.MoveSpeed = eventPlayer.MoveSpeed - 10
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)


rule "[sombra/translocator.opy] Sombra stealth damage cancel count damage":
    @Event playerTookDamage
    @Hero sombra
    @Condition eventPlayer.stealth_timer > 0
    @Condition eventPlayer.stealth_timer <= 5
    
    #eventPlayer.Sombra_invis_damage += eventDamage
    #if eventPlayer.Sombra_invis_damage >= 40:
    eventPlayer.setStatusEffect(null, Status.ROOTED, 0.001)
    eventPlayer.stealth_timer = 0
    eventPlayer.Sombra_invisible = false
    #eventPlayer.Sombra_invis_damage = 0
    #else:
    #wait(1, Wait.RESTART_WHEN_TRUE)
    #eventPlayer.Sombra_invis_damage = 0
    #__end__()


rule "[sombra/translocator_cooldown_reset.opy]: When Translocator is used, begin tracking how long Sombra is in stealth":
    @Event eachPlayer
    @Condition eventPlayer.getHero() == Hero.SOMBRA
    @Condition eventPlayer.isUsingAbility2() == true
    
    #eventPlayer.Sombra_invis_damage = 0
    eventPlayer.stealth_timer = 5.5
    waitUntil(not eventPlayer.isUsingAbility2(), 999999986991104)
    eventPlayer.Sombra_invisible = true
    chaseAtRate(eventPlayer.stealth_timer, 0, 1, ChaseRateReeval.NONE)
    #Sombra can't break stealth during the cast time of stealth
    wait(0.5, Wait.RESTART_WHEN_TRUE)
    #Wait until Sombra exits Stealth
    waitUntil(any([eventPlayer.hasStatus(Status.ASLEEP), eventPlayer.hasStatus(Status.FROZEN), eventPlayer.hasStatus(Status.HACKED), eventPlayer.hasStatus(Status.KNOCKED_DOWN), eventPlayer.hasStatus(Status.STUNNED), eventPlayer.hasStatus(Status.ROOTED)]) or eventPlayer.Sombra_invisible == false or eventPlayer.isFiringPrimaryFire() or eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) and not eventPlayer.isFiringSecondaryFire() or eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0 and eventPlayer.isHoldingButton(Button.ABILITY_1) or eventPlayer.isHoldingButton(Button.MELEE) or eventPlayer.isMeleeing() or eventPlayer.isUsingUltimate() or eventPlayer.stealth_pvar[1] == 100 and eventPlayer.isHoldingButton(Button.ULTIMATE), 5)
    eventPlayer.Sombra_invisible = false
    stopChasingVariable(eventPlayer.stealth_timer)
    if eventPlayer.stealth_timer <= 0:
        return
    if NEGATIVE_STATUS_PREVENTS_REFUND:
        if any([eventPlayer.hasStatus(Status.ASLEEP), eventPlayer.hasStatus(Status.FROZEN), eventPlayer.hasStatus(Status.HACKED), eventPlayer.hasStatus(Status.KNOCKED_DOWN), eventPlayer.hasStatus(Status.STUNNED), eventPlayer.hasStatus(Status.ROOTED)]):
            return
    waitUntil(eventPlayer.getAbilityCooldown(Button.ABILITY_2) > 0, 1)
    #printLog("Current Translocator Cooldown: {0} | Target Translocator Cooldown: {1}".format(eventPlayer.getAbilityCooldown(Button.ABILITY_2), eventPlayer._stealth_max_cooldown - 5 + (eventPlayer.stealth_timer * (1 - STEALTH_REFUND_FRACTION))))
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, eventPlayer.stealth_pvar[0] - 5 + (eventPlayer.stealth_timer * (1 - STEALTH_REFUND_FRACTION)))


rule "[sombra/translocator_cooldown_reset.opy]: Sombra stealth refund variables":
    STEALTH_REFUND_FRACTION = createWorkshopSettingInt("Gameplay Settings", "Percent of Stealth Timer Remaining Refunded Towards Translocator Cooldown", 40, 0, 100) / 100
    NEGATIVE_STATUS_PREVENTS_REFUND = createWorkshopSettingBool("Gameplay Settings", "Negative Status Effects Cancelling Stealth Prevents Translocator Cooldown Refund", true, 1)
    MINIMUM_TRANSLOCATOR_COOLDOWN = 4


rule "[sombra/translocator_cooldown_reset.opy]: Set max stealth cooldown observed":
    @Event eachPlayer
    @Condition eventPlayer.getHero() == Hero.SOMBRA
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) > eventPlayer.stealth_pvar[0]
    
    eventPlayer.stealth_pvar[0] = round(eventPlayer.getAbilityCooldown(Button.ABILITY_2))


rule "[sombra/hack.opy] Hacked healpack bonus speed":
    @Event playerReceivedHealing
    @Condition eventWasHealthPack == true
    
    if healer.getHero() == Hero.SOMBRA:
        eventPlayer.MoveSpeed = eventPlayer.MoveSpeed + 25
        eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
        wait(2)
        eventPlayer.MoveSpeed = eventPlayer.MoveSpeed - 25
        eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)


rule "[sombra/opportunist.opy] Remove 20% damage increase":
    @Event playerDealtDamage
    @Hero sombra
    @Condition victim.hasStatus(Status.HACKED) == true
    
    heal(victim, null, eventDamage / 6)


rule "[sombra/hack.opy] Hack target for 2s":
    @Event eachPlayer
    @Condition eventPlayer.hasStatus(Status.HACKED) == true
    @Condition getPlayersOnHero(Hero.SOMBRA, getOppositeTeam(eventPlayer.getTeam())).getAbilityCooldown(Button.SECONDARY_FIRE) != 0
    
    eventPlayer.setStatusEffect(getPlayersOnHero(Hero.SOMBRA, getOppositeTeam(eventPlayer.getTeam())), Status.HACKED, 2)


rule "[sombra/init.opy]: Clean up Sombra":
    @Event eachPlayer
    @Condition eventPlayer.hero_setup != Hero.SOMBRA
    
    eventPlayer.Sombra_virus_target = null
    destroyInWorldText(eventPlayer.Sombra_targeting_hud)
    destroyEffect(eventPlayer.Sombra_healing_ring)
    destroyInWorldText(eventPlayer.Sombra_hud)
    destroyHudText(eventPlayer.Explaination_Hud[3])


def initSymmetra():
    @Name "[symmetra/init.opy]: initSymmetra()"
    
    eventPlayer.custom_hp_pvar[0] = 125
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 100
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1680
    eventPlayer.max_health_scaler = 0.75
    eventPlayer.hero_initialized = true


rule "[symmetra/init.opy]: Correct Photon projector damage":
    @Event playerDealtDamage
    @Hero symmetra
    @Condition eventAbility == Button.SECONDARY_FIRE
    
    damage(victim, attacker, eventDamage * 1.05 - eventDamage)


def initTorbjorn():
    @Name "[torbjorn/init.opy]: initTorbjorn()"
    
    eventPlayer.custom_hp_pvar[0] = 200
    eventPlayer.custom_hp_pvar[1] = 50
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2142
    eventPlayer.setAmmo(0, 18)
    eventPlayer.setMaxAmmo(0, 18)
    eventPlayer.overhealth_check = false
    eventPlayer.hero_initialized = true


rule "[torbjorn/init.opy]: Increase Rivet Gun alternate fire ammo cost":
    @Event eachPlayer
    @Hero torbjorn
    @Condition eventPlayer.isFiringSecondaryFire() == true
    
    eventPlayer.setAmmo(0, eventPlayer.getAmmo() - 1)


rule "[torbjorn/init.opy]: Increase Overload overhealth":
    @Event eachPlayer
    @Hero torbjorn
    @Condition eventPlayer.isUsingAbility2() == true
    
    eventPlayer.addHealthPool(Health.NORMAL, 11.111, false)
    eventPlayer.overload_overhealth = getLastCreatedHealthPool()
    waitUntil(not eventPlayer.isUsingAbility2(), 999999986991104)
    removeHealthPool(eventPlayer.overload_overhealth)


def initTracer():
    @Name "[tracer/init.opy]: initTracer()"
    
    if eventPlayer.isDuplicatingAHero():
        eventPlayer.removeAllHealthPools()
        wait(0.15)
        #DO NOT REMOVE THIS LINE
        eventPlayer.setMaxHealth(100.001)
        #DO NOT REMOVE THIS LINE
        wait(0.15)
        eventPlayer.setMaxHealth(100)
        eventPlayer.setHealingReceived(0)
        eventPlayer.addHealthPool(Health.NORMAL, 1, true)
        eventPlayer.addHealthPool(Health.ARMOR, 1, true)
        eventPlayer.addHealthPool(Health.SHIELDS, 1, true)
        eventPlayer.removeAllHealthPools()
    eventPlayer.ult_charge_pvar[1] = 1250
    eventPlayer.macro_pvar[0] = 0.964
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.startScalingSize(0.96)
    eventPlayer.max_health_scaler = 0.857
    eventPlayer.hero_initialized = true


rule "[tracer/init.opy]: Correct melee and Pulse Bomb damage":
    @Event playerDealtDamage
    @Hero tracer
    @Condition eventAbility in [Button.MELEE, Button.ULTIMATE] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


def initVenture():
    @Name "[venture/init.opy]: initVenture()"
    
    eventPlayer.custom_hp_pvar[0] = 300
    eventPlayer.custom_hp_pvar[1] = 50
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1550
    eventPlayer.macro_pvar[0] = 0.429
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.setKnockbackDealt(80)
    eventPlayer.setAmmo(0, 6)
    eventPlayer.setMaxAmmo(0, 6)
    eventPlayer.max_health_scaler = 0.833
    eventPlayer.startScalingSize(1.18)
    eventPlayer.hero_initialized = true


rule "[venture/init.opy]: Reduce Headshot damage taken Venture":
    @Event playerTookDamage
    @Hero venture
    @Condition eventWasCriticalHit == true
    
    heal(eventPlayer, null, eventDamage * 0.3)


rule "[venture/excavator.opy]: Prepare Smart Excavator damage increase":
    @Event eachPlayer
    @Hero venture
    @Condition eventPlayer.isFiringPrimaryFire() == true
    
    eventPlayer.is_firing_excavator = true
    wait(0.3)
    eventPlayer.is_firing_excavator = false


rule "[venture/excavator.opy]: Correct Smart Excavator damage":
    @Event playerDealtDamage
    @Hero venture
    @Condition eventPlayer.is_firing_excavator != false
    @Condition eventPlayer.isUsingAbility1() == false
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] * 0.8 - eventDamage) / eventPlayer.macro_pvar[0])
    eventPlayer.is_firing_excavator = false


rule "[venture/drill_dash.opy]: Correct Drill Dash damage":
    @Event playerDealtDamage
    @Hero venture
    @Condition eventAbility == Button.SECONDARY_FIRE
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] * 0.444 - eventDamage) / eventPlayer.macro_pvar[0])


rule "[venture/clobber.opy]: Correct Venture melee damage":
    @Event playerDealtDamage
    @Hero venture
    @Condition eventAbility == Button.MELEE
    
    #damage(victim, attacker, ((eventDamage/eventPlayer._base_damage_scalar) * (ADJ_VENTURE_CLOBBER_DAMAGE / OW2_VENTURE_CLOBBER_DAMAGE) - eventDamage)/eventPlayer._base_damage_scalar)
    eventPlayer.clobber_cooldown_accelerator = eventPlayer.getAbilityCooldown(Button.ABILITY_1)
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, eventPlayer.clobber_cooldown_accelerator - 0.5)


rule "[venture/burrow.opy]: Burrow speed decrease and dash cooldown 0":
    @Event eachPlayer
    @Hero venture
    @Condition eventPlayer.isUsingAbility1() == true
    
    waitUntil(eventPlayer.isOnGround() == true, 7)
    wait(0.6, Wait.ABORT_WHEN_FALSE)
    if eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE) != 0 and not eventPlayer.isFiringSecondaryFire():
        eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, 0)
    eventPlayer.MoveSpeed = eventPlayer.MoveSpeed - 70
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    waitUntil(eventPlayer.isUsingAbility1() == false, 99999)
    eventPlayer.MoveSpeed = eventPlayer.MoveSpeed + 70
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    if eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE) != 0 and not eventPlayer.isFiringSecondaryFire():
        eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, 0)


rule "[venture/burrow.opy]: Burrow speed increase when dashing":
    @Event eachPlayer
    @Hero venture
    @Condition eventPlayer.isUsingAbility1() == true
    @Condition eventPlayer.isFiringSecondaryFire() == true
    
    eventPlayer.MoveSpeed = eventPlayer.MoveSpeed + 110
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    waitUntil(eventPlayer.isFiringSecondaryFire() == false, 99999)
    eventPlayer.MoveSpeed = eventPlayer.MoveSpeed - 110
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)


rule "[venture/burrow.opy]: Correct Burrow damage":
    @Event playerDealtDamage
    @Hero venture
    @Condition eventAbility == Button.ABILITY_1
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] * 0.55 - eventDamage) / eventPlayer.macro_pvar[0])


rule "[venture/burrow.opy]: Burrow Knockup":
    @Event playerDealtDamage
    @Hero venture
    @Condition eventAbility == Button.ABILITY_1
    
    victim.applyImpulse(Vector.UP, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)


rule "[venture/tectonic_shock.opy]: Tectonic Shock logic":
    @Event playerDealtDamage
    @Hero venture
    @Condition eventAbility == Button.ULTIMATE
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] * 0.73 - eventDamage) / eventPlayer.macro_pvar[0])
    victim.applyImpulse(Vector.UP, 8, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)


def initWidowmaker():
    @Name "[widowmaker/init.opy]: initWidowmaker()"
    
    eventPlayer.custom_hp_pvar[0] = 165
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1540
    eventPlayer.hero_initialized = true


rule "[widowmaker/init.opy]: Reduce Scoped Shot damage":
    @Event eachPlayer
    @Hero widowmaker
    @Condition eventPlayer.isFiringSecondaryFire() == true
    
    eventPlayer.setDamageDealt(87.5)
    waitUntil(not eventPlayer.isFiringSecondaryFire(), 999999986991104)
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])


rule "[widowmaker/weapon.opy] Widowmaker scope glint":
    @Event eachPlayer
    @Hero widowmaker
    @Condition eventPlayer.isFiringSecondaryFire() == true
    
    #Without aiming at widow check
    createEffect([player for player in getPlayers(getOppositeTeam(eventPlayer.getTeam())) if distance(eventPlayer, player) >= 3 and eventPlayer.isInViewAngle(player.getEyePosition(), 15)], Effect.GOOD_AURA, Color.WHITE, eventPlayer.getEyePosition(), 0.45, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.WidowScopeGlint_effect = getLastCreatedEntity()
    waitUntil(not eventPlayer.isFiringSecondaryFire(), 100000000)
    destroyEffect(eventPlayer.WidowScopeGlint_effect)


def initWinston():
    @Name "[winston/init.opy]: initWinston()"
    
    eventPlayer.custom_hp_pvar[0] = 253.846
    eventPlayer.custom_hp_pvar[1] = 100
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.addHealthPool(Health.NORMAL, 146.154, true)
    eventPlayer.primal_pvar[2] = getLastCreatedHealthPool()
    eventPlayer.ult_charge_pvar[1] = 1650
    removeTankPassive()
    eventPlayer.macro_pvar[0] = 0.821
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.max_health_scaler = 0.923
    eventPlayer.setMaxAmmo(0, 100)
    eventPlayer.setAmmo(0, 100)
    eventPlayer.hero_initialized = true


rule "[winston/primal.opy]: Remove bonus Primal Rage health":
    @Event eachPlayer
    @Hero winston
    @Condition eventPlayer.isUsingUltimate() == true
    
    removeHealthPool(eventPlayer.primal_pvar[2])
    wait(9.904)
    eventPlayer.primal_pvar[0] = eventPlayer.getHealthOfType(Health.NORMAL)
    eventPlayer.primal_pvar[1] = eventPlayer.getHealthOfType(Health.ARMOR)
    waitUntil(not eventPlayer.isUsingUltimate(), 999999986991104)
    eventPlayer.addHealthPool(Health.NORMAL, 146.154, true)
    eventPlayer.primal_pvar[2] = getLastCreatedHealthPool()
    eventPlayer.setHealth(min(400, eventPlayer.primal_pvar[0]) + eventPlayer.primal_pvar[1])


rule "[winston/primal.opy]: Reduce Primal Rage damage":
    @Event eachPlayer
    @Hero winston
    @Condition eventPlayer.isUsingUltimate() == true
    
    eventPlayer.setDamageDealt(80)
    waitUntil(not eventPlayer.isUsingUltimate(), 999999986991104)
    #revert damage back after Primal Rage concludes
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])


rule "[winston/primal.opy]: Correct Jump Pack damage during Primal Rage":
    @Event playerDealtDamage
    @Hero winston
    @Condition eventPlayer.isUsingUltimate() == true
    @Condition eventAbility == Button.ABILITY_1
    
    damage(victim, attacker, (eventDamage / 0.8 - eventDamage) / 0.8)


rule "[winston/init.opy]: Correct Jump Pack, Melee, Primal Rage damage":
    @Event playerDealtDamage
    @Hero winston
    @Condition eventPlayer.isUsingUltimate() == false
    @Condition eventAbility in [Button.ABILITY_1, Button.MELEE, Button.SECONDARY_FIRE] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


def initWreckingBall():
    @Name "[wreckingball/init.opy]: initWreckingBall()"
    
    eventPlayer.custom_hp_pvar[0] = 475
    eventPlayer.custom_hp_pvar[1] = 75
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1540
    removeTankPassive()
    eventPlayer.macro_pvar[0] = 0.788
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.setAmmo(0, 80)
    eventPlayer.setMaxAmmo(0, 80)
    eventPlayer.max_health_scaler = 0.5
    eventPlayer.hero_initialized = true


rule "[wreckingball/grapple.opy]: Force Grappling Hook cooldown":
    @Event eachPlayer
    @Hero wreckingBall
    @Condition eventPlayer.isFiringSecondaryFire() == true
    
    waitUntil(eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE) > 0, 999999986991104)
    if eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE) <= 1:
        eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, 1.92)


rule "[wreckingball/grapple.opy]: Increase Fireball impact damage":
    @Event playerDealtDamage
    @Hero wreckingBall
    @Condition eventAbility == Button.SECONDARY_FIRE
    
    damage(victim, attacker, (0.833 * (eventDamage / eventPlayer.macro_pvar[0]) - eventDamage) / eventPlayer.macro_pvar[0])


rule "[wreckingball/shields.opy]: Remove Adaptive Shields overhealth transfer":
    @Event eachPlayer
    @Hero wreckingBall
    @Condition eventPlayer.isUsingAbility2() == true
    
    eventPlayer.disallowButton(Button.ABILITY_2)
    eventPlayer.setAbility2Enabled(false)
    waitUntil(not eventPlayer.isUsingAbility2(), 999999986991104)
    enableAllAbilities()
    eventPlayer.allowButton(Button.ABILITY_2)


rule "[wreckingball/shields.opy]: Increase Adaptive Shield base overhealth gain":
    @Event eachPlayer
    @Hero wreckingBall
    @Condition eventPlayer.isUsingAbility2() == true
    
    eventPlayer.addHealthPool(Health.NORMAL, 100, false)
    eventPlayer.adaptive_overhealth_id = getLastCreatedHealthPool()
    waitUntil(not eventPlayer.isUsingAbility2(), 999999986991104)
    removeHealthPool(eventPlayer.adaptive_overhealth_id)
    eventPlayer.adaptive_overhealth_id = null


rule "[wreckingball/piledriver.opy]: Increase Piledriver / Quadcannon damage":
    @Event playerDealtDamage
    @Hero wreckingBall
    @Condition eventAbility in [Button.PRIMARY_FIRE, Button.CROUCH] == true
    
    damage(victim, attacker, (0.8 * (eventDamage / eventPlayer.macro_pvar[0]) - eventDamage) / eventPlayer.macro_pvar[0])


rule "[wreckingball/init.opy]: Correct fireball, melee damage":
    @Event playerDealtDamage
    @Hero wreckingBall
    @Condition eventAbility in [Button.ABILITY_1, Button.MELEE] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


def initZarya():
    @Name "[zarya/init.opy]: initZarya()"
    
    eventPlayer.custom_hp_pvar[0] = 200
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 200
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2100
    removeTankPassive()
    eventPlayer.self_bubble_cooldown = 0
    eventPlayer.ally_bubble_cooldown = 0
    eventPlayer.macro_pvar[0] = 0.895
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.max_health_scaler = 1
    eventPlayer.hero_initialized = true


def showSelfBubbleCD():
    @Name "[zarya/self_bubble.opy]: showSelfBubbleCD()"
    
    if eventPlayer.self_bubble_cd_text == null:
        createInWorldText(eventPlayer, "{0}".format(ceil(eventPlayer.self_bubble_cooldown)), updateEveryFrame(eventPlayer.getEyePosition() + (100 * (1.99 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + (-1.9 * (directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 * eventPlayer.getFacingDirection()))), 3)
        eventPlayer.self_bubble_cd_text = getLastCreatedText()
        createInWorldText(eventPlayer, "{0} {1}".format(ceil(eventPlayer.self_bubble_cooldown), abilityIconString(Hero.ZARYA, Button.ABILITY_1)), updateEveryFrame(eventPlayer.getEyePosition() + (100 * (0.2 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + (-0.36 * (directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 * eventPlayer.getFacingDirection()))), 1.3)
        eventPlayer.zarya_self_bubble_centre_hud = getLastCreatedText()


def hideSelfBubbleCD():
    @Name "[zarya/self_bubble.opy]: hideSelfBubbleCD()"
    
    destroyInWorldText(eventPlayer.self_bubble_cd_text)
    eventPlayer.self_bubble_cd_text = null
    destroyInWorldText(eventPlayer.zarya_self_bubble_centre_hud)
    eventPlayer.zarya_self_bubble_centre_hud = null


rule "[zarya/self_bubble.opy]: OW1 zarya self bubble cooldown":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.isUsingAbility1() == true
    @Condition eventPlayer.HeroCoreActive == null
    
    eventPlayer.disallowButton(Button.ABILITY_1)
    eventPlayer.setAbilityCharge(Button.ABILITY_1, 2)
    #wait bubble duration
    waitUntil(not eventPlayer.isUsingAbility1(), 2)
    eventPlayer.setAbility1Enabled(false)
    eventPlayer.self_bubble_cooldown = 9
    eventPlayer.allowButton(Button.ABILITY_1)
    chaseAtRate(eventPlayer.self_bubble_cooldown, 0, 1, ChaseRateReeval.NONE)


rule "[zarya/self_bubble.opy]: Disable self bubble if on cooldown":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.self_bubble_cooldown > 0
    @Condition eventPlayer.HeroCoreActive == null
    
    eventPlayer.setAbility1Enabled(false)
    showSelfBubbleCD()


rule "[zarya/self_bubble.opy]: Enable self bubble if not on cooldown":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.hero_setup == Hero.ZARYA
    @Condition eventPlayer.self_bubble_cooldown <= 0
    @Condition eventPlayer.HeroCoreActive == null
    
    eventPlayer.setAbility1Enabled(true)
    hideSelfBubbleCD()


def showAllyBubbleCD():
    @Name "[zarya/ally_bubble.opy]: showAllyBubbleCD()"
    
    if eventPlayer.ally_bubble_cd_text == null:
        createInWorldText(eventPlayer, "{0}".format(ceil(eventPlayer.ally_bubble_cooldown)), updateEveryFrame(eventPlayer.getEyePosition() + (100 * (2.3 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + (-1.9 * (directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 * eventPlayer.getFacingDirection()))), 3)
        eventPlayer.ally_bubble_cd_text = getLastCreatedText()
        createInWorldText(eventPlayer, "{0} {1}".format(ceil(eventPlayer.ally_bubble_cooldown), abilityIconString(Hero.ZARYA, Button.ABILITY_2)), updateEveryFrame(eventPlayer.getEyePosition() + (100 * (0.2 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + (-0.48 * (directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 * eventPlayer.getFacingDirection()))), 1.3)
        eventPlayer.zarya_ally_bubble_centre_hud = getLastCreatedText()


def hideAllyBubbleCD():
    @Name "[zarya/ally_bubble.opy]: hideAllyBubbleCD()"
    
    destroyInWorldText(eventPlayer.ally_bubble_cd_text)
    eventPlayer.ally_bubble_cd_text = null
    destroyInWorldText(eventPlayer.zarya_ally_bubble_centre_hud)
    eventPlayer.zarya_ally_bubble_centre_hud = null


rule "[zarya/ally_bubble.opy]: OW1 zarya ally bubble cooldown":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.isUsingAbility2() == true
    
    eventPlayer.setAbilityCharge(Button.ABILITY_2, 2)
    eventPlayer.setAbility2Enabled(false)
    #waitUntil(not eventPlayer.isUsingAbility2(), ADJ_ZARYA_BUBBLE_DURATION) # wait bubble duration
    #wait bubble duration
    wait(2)
    eventPlayer.ally_bubble_cooldown = 7
    chaseAtRate(eventPlayer.ally_bubble_cooldown, 0, 1, ChaseRateReeval.NONE)


rule "[zarya/ally_bubble.opy]: Disable ally bubble if on cooldown":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.ally_bubble_cooldown > 0
    
    eventPlayer.setAbility2Enabled(false)
    showAllyBubbleCD()


rule "[zarya/ally_bubble.opy]: Enable ally bubble if not on cooldown":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.ally_bubble_cooldown <= 0
    
    eventPlayer.setAbility2Enabled(true)
    hideAllyBubbleCD()


rule "[zarya/init.opy]: Clean up Zarya":
    @Event eachPlayer
    @Condition eventPlayer.hero_setup != Hero.ZARYA
    
    hideSelfBubbleCD()
    hideAllyBubbleCD()


rule "[zarya/init.opy]: Increase Particle Cannon alternate fire damage":
    @Event playerDealtDamage
    @Hero zarya
    @Condition eventAbility == Button.SECONDARY_FIRE
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] * 0.909 - eventDamage) / eventPlayer.macro_pvar[0])


rule "[zarya/init.opy]: Correct Zarya Melee damage":
    @Event playerDealtDamage
    @Hero zarya
    @Condition eventAbility == Button.MELEE
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


def initZenyatta():
    @Name "[zenyatta/init.opy]: initZenyatta()"
    
    eventPlayer.custom_hp_pvar[0] = 50
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 150
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2200
    eventPlayer.setAmmo(0, 20)
    eventPlayer.setMaxAmmo(0, 20)
    eventPlayer.setKnockbackDealt(4)
    eventPlayer.hero_initialized = true


rule "[echo/copy.opy] Echo new ultimate":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE) == true
    @Condition eventPlayer.hero_setup == Hero.ECHO
    
    if eventPlayer.isAlive() == true and eventPlayer.getUltCharge() == 100:
        getPlayers(eventPlayer.getTeam()).Echo_Copy = true
        eventPlayer.startForcingHero(((sorted([player for player in getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())) if angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getEyePosition(), player)) <= 19 and player.hasSpawned() and distance(eventPlayer, player) <= 40 and player != getPlayersOnHero(Hero.ECHO, Team.ALL) and isInLoS(eventPlayer, player)], lambda i: angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getEyePosition(), i))))[0]).getHero())
        if eventPlayer.getHero() != Hero.ECHO:
            eventPlayer.setStatusEffect(null, Status.FROZEN, 1)
            eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 1)
            wait(1)
            eventPlayer.setUltCharge(95)
            EchoCopy()
            waitUntil(not eventPlayer.isAlive(), 16)
            destroyProgressBarInWorldText(eventPlayer.EchoHUD)
            stopChasingVariable(eventPlayer.EchoUltSeconds)
            eventPlayer.startForcingHero(Hero.ECHO)
            eventPlayer.stopForcingCurrentHero()
            getPlayers(eventPlayer.getTeam()).Echo_Copy = false


rule "[sombra/emp.opy]: Heal damage EMP does and prevent extra hack time from triggering":
    @Event playerDealtDamage
    @Hero sombra
    @Condition eventAbility == Button.ULTIMATE
    
    heal(victim, null, eventDamage)
    wait(3)
    victim.clearStatusEffect(Status.HACKED)


rule "[mcree/combat_roll.opy]: remove 30% damage reducion from roll":
    @Event eachPlayer
    @Hero cassidy
    @Condition eventPlayer.isUsingAbility1() == true
    
    eventPlayer.DamageRecieved = eventPlayer.DamageRecieved + 30
    eventPlayer.setDamageReceived(eventPlayer.DamageRecieved)
    waitUntil(not eventPlayer.isUsingAbility1(), 3)
    eventPlayer.DamageRecieved = eventPlayer.DamageRecieved - 30
    eventPlayer.setDamageReceived(eventPlayer.DamageRecieved)


def initMei():
    @Name "[mei/init.opy]: initMei()"
    @Disabled
    
    eventPlayer.custom_hp_pvar[0] = 250
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1610
    eventPlayer.macro_pvar[0] = 0.882
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.max_health_scaler = 1.1
    eventPlayer.hero_initialized = true


def EchoCopy():
    @Name "[echo/ultimate.opy]: Sub for HUD"
    
    eventPlayer.EchoUltSeconds = 100
    chaseAtRate(eventPlayer.EchoUltSeconds, 0, 6.25)
    createProgressBarInWorldText(eventPlayer, eventPlayer.EchoUltSeconds, "{0} {1}".format(abilityIconString(Hero.ECHO, Button.ULTIMATE), ceil(eventPlayer.EchoUltSeconds / 6.25)), updateEveryFrame(eventPlayer.getEyePosition() + (100 * (-1 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + ((-0.05 - 0.2) * (directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 * eventPlayer.getFacingDirection()))), 0.75)
    eventPlayer.EchoHUD = getLastCreatedText()


rule "[echo/init.opy]: Clean up Echo":
    @Event eachPlayer
    @Condition eventPlayer.hero_setup != Hero.ECHO
    
    destroyProgressBarInWorldText(eventPlayer.EchoHUD)
    stopChasingVariable(eventPlayer.EchoUltSeconds)
    getPlayers(eventPlayer.getTeam()).Echo_Copy = false
    eventPlayer.EchoHUD = null
    eventPlayer.EchoUltSeconds = null


rule "[ana/nade.opy]: Increase Biotic Grenade damage":
    @Event playerDealtDamage
    @Hero ana
    @Condition eventAbility == Button.ABILITY_2
    
    damage(victim, attacker, (0.8 * (eventDamage / eventPlayer.macro_pvar[0]) - eventDamage) / eventPlayer.macro_pvar[0])


rule "[soldier/init.opy]: Increase Heavy Pulse Rifle damage":
    @Event playerDealtDamage
    @Hero soldier
    @Condition eventAbility == Button.PRIMARY_FIRE
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] * 1.053 - eventDamage) / eventPlayer.macro_pvar[0])


rule "Mercy track ult charge that would have been gained from custom abilities":
    @Event playerDealtHealing
    @Hero mercy
    @Condition (eventAbility != Button.PRIMARY_FIRE and healee != eventPlayer and isGameInProgress() == true) == true
    @Condition eventPlayer.getUltCharge() < 100
    @Disabled
    
    eventPlayer.MercyUltTrack += eventHealing


rule "Mercy ult add":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.MercyUltTrack >= eventPlayer.ult_charge_pvar[1] / 100
    @Disabled
    
    eventPlayer.setUltCharge(eventPlayer.getUltCharge() + floor(eventPlayer.MercyUltTrack / (eventPlayer.ult_charge_pvar[1] / 100)))
    eventPlayer.MercyUltTrack -= floor(eventPlayer.MercyUltTrack / (eventPlayer.ult_charge_pvar[1] / 100)) * (eventPlayer.ult_charge_pvar[1] / 100)
    wait(0.2)


rule "Mercy rez HUD":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.getUltCharge() >= 100
    @Condition eventPlayer.RezHUD == null
    
    hudHeader(eventPlayer if eventPlayer.isAlive() and len(getPlayersInRadius(eventPlayer, 5.5, eventPlayer.getTeam(), LosCheck.SURFACES).exclude(getLivingPlayers(Team.ALL))) > 0 else null, "Resurrect {0}".format(heroIcon(sorted(getPlayersInRadius(eventPlayer, 5.5, eventPlayer.getTeam(), LosCheck.SURFACES).exclude(getLivingPlayers(eventPlayer.getTeam())), lambda i: angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer, i)))[0].getHero())), HudPosition.TOP, 0, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING)
    eventPlayer.RezHUD = getLastCreatedText()


rule "Mercy imbue target icon":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0
    @Condition eventPlayer.ImbueTargetIcon == null
    
    createInWorldText(eventPlayer if ((sorted([player for player in getPlayersInRadius(eventPlayer, 20.5, eventPlayer.getTeam(), LosCheck.SURFACES_AND_ENEMY_BARRIERS) if eventPlayer.isInViewAngle(player.getPosition(), 2 + 60 / distance(eventPlayer, player)) == true and player != eventPlayer and player.isAlive() == true], lambda i: angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getPosition(), i.getPosition()))))[0]) != null and not eventPlayer.isInAlternateForm() else null, "+", (((sorted([player for player in getPlayersInRadius(eventPlayer, 20.5, eventPlayer.getTeam(), LosCheck.SURFACES_AND_ENEMY_BARRIERS) if eventPlayer.isInViewAngle(player.getPosition(), 2.5 + 60 / distance(eventPlayer, player)) == true and player != eventPlayer and player.isAlive() == true], lambda i: angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getPosition(), i.getPosition()))))[0]).getEyePosition()) + vect(0, 1, 0), 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, Color.BLUE if eventPlayer.isFiringSecondaryFire() else Color.YELLOW)
    eventPlayer.ImbueTargetIcon = getLastCreatedText()


rule "Mercy imbue":
    @Event eachPlayer
    @Hero mercy
    #Staff equipped, cooldown ready, E pressed, target within range
    @Condition (eventPlayer.isInAlternateForm() == false and eventPlayer.isHoldingButton(Button.ABILITY_2) == true and eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0 and (sorted([i for i in getPlayersInRadius(eventPlayer, 20.5, eventPlayer.getTeam(), LosCheck.SURFACES_AND_ENEMY_BARRIERS).exclude(eventPlayer).exclude(getDeadPlayers(eventPlayer.getTeam())) if eventPlayer.isInViewAngle(i.getPosition(), 2.5 + 60 / distance(eventPlayer, i)) == true], lambda i: angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getPosition(), i.getPosition()))))[0] != null) == true
    
    #Vanilla rez cd hero setting needs to be changed if cooldown is changed so icon matches
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, 15)
    eventPlayer.setAbility2Enabled(true)
    destroyInWorldText(eventPlayer.ImbueTargetIcon)
    eventPlayer.ImbueTargetIcon = null
    eventPlayer.ImbueSecondary = true if eventPlayer.isFiringSecondaryFire() else false
    #Set target
    eventPlayer.ImbueTarget = (sorted([player for player in getPlayersInRadius(eventPlayer, 20.5, eventPlayer.getTeam(), LosCheck.SURFACES_AND_ENEMY_BARRIERS) if eventPlayer.isInViewAngle(player.getPosition(), 2.5 + 60 / distance(eventPlayer, player)) == true and player != eventPlayer and player.isAlive() == true], lambda i: angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getPosition(), i.getPosition()))))[0]
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
    waitUntil(eventPlayer.isAlive() == false or eventPlayer.getAbilityCooldown(Button.ABILITY_2) <= 0.3 or eventPlayer.getHero() != Hero.MERCY, 14.7)
    if eventPlayer.getHero() != Hero.MERCY:
        return
    eventPlayer.setAbility2Enabled(false)


rule "Mercy imbue AOE":
    @Event eachPlayer
    @Hero mercy
    @Condition (eventPlayer.ImbueDuration > 0 and eventPlayer.ImbueTarget != null) == true
    
    #Aura visuals
    createEffect(getPlayers(Team.ALL if eventPlayer.ImbueSecondary else eventPlayer.getTeam()), Effect.RING, (Color.TEAM_1 if eventPlayer.getTeam() == Team.1 else Color.TEAM_2) if eventPlayer.ImbueSecondary else Color.YELLOW, eventPlayer.ImbueTarget, 8 if eventPlayer.ImbueSecondary else 10, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.ImbueAOERing = getLastCreatedEntity()
    if eventPlayer.ImbueSecondary:
        createEffect(getPlayers(eventPlayer.getTeam()), Effect.ENERGY_SOUND, Color.WHITE, eventPlayer.ImbueTarget, 80, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    else:
        createEffect(getPlayers(eventPlayer.getTeam()), Effect.SPARKLES_SOUND, Color.WHITE, eventPlayer.ImbueTarget, 90, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.ImbueAOESound = getLastCreatedEntity()
    #AoE
    while eventPlayer.ImbueTarget.isAlive() == true and eventPlayer.ImbueDuration > 0:
        #20 dps for 3 seconds
        if eventPlayer.ImbueSecondary:
            getPlayersInRadius(eventPlayer.ImbueTarget, 8, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES_AND_ENEMY_BARRIERS).startDamageOverTime(eventPlayer, 0.5, 20)
            #15 hps for 5 seconds
        else:
            heal(getPlayersInRadius(eventPlayer.ImbueTarget, 10, eventPlayer.getTeam(), LosCheck.SURFACES_AND_ENEMY_BARRIERS), eventPlayer, 7.5)
        waitUntil(eventPlayer.ImbueTarget.isAlive() == false or eventPlayer.ImbueDuration == 0, 0.5)
    destroyEffect(eventPlayer.ImbueAOERing)
    destroyEffect(eventPlayer.ImbueAOESound)
    stopChasingVariable(eventPlayer.ImbueDuration)
    eventPlayer.ImbueTarget = null


rule "Mercy rez":
    @Event eachPlayer
    @Hero mercy
    @Condition (eventPlayer.getUltCharge() == 100 and eventPlayer.isHoldingButton(Button.ULTIMATE) == true and eventPlayer.isAlive() == true and len(getPlayersInRadius(eventPlayer, 5.5, eventPlayer.getTeam(), LosCheck.SURFACES).exclude(getLivingPlayers(Team.ALL))) > 0) == true
    
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


rule "Mercy swap hero":
    @Event eachPlayer
    @Condition (eventPlayer.getHero() != Hero.MERCY and eventPlayer.hasSpawned()) == true
    
    eventPlayer.allowButton(Button.ULTIMATE)
    destroyHudText(eventPlayer.RezHUD)
    destroyInWorldText(eventPlayer.ImbueTargetIcon)
    eventPlayer.MercyUltTrack = 0
    destroyEffect(eventPlayer.ImbueAOERing)
    destroyEffect(eventPlayer.ImbueAOESound)
    destroyEffect(eventPlayer.ImbueBeam)
    destroyEffect(eventPlayer.ImbueSparkle)
    eventPlayer.ImbueTargetIcon = null
    eventPlayer.RezHUD = null
    eventPlayer.ImbueTarget = null


rule "Overrun logic":
    @Event eachPlayer
    @Hero mauga
    @Condition eventPlayer.isUsingAbility1() == true
    
    stopChasingVariable(eventPlayer.MaugaOverHP)
    eventPlayer.MoveSpeed = eventPlayer.MoveSpeed - 15
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    wait(0.32)
    waitUntil(not eventPlayer.isUsingAbility1() or eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true or eventPlayer.isHoldingButton(Button.JUMP) == true, 99999)
    eventPlayer.MoveSpeed = eventPlayer.MoveSpeed + 15
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    if (eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) or eventPlayer.isHoldingButton(Button.JUMP)) == true:
        waitUntil(not eventPlayer.isUsingAbility1(), 2.6)
        eventPlayer.setAbilityCooldown(Button.ABILITY_1, 6)


rule "Overrun subtract damage taken":
    @Event playerTookDamage
    @Hero mauga
    @Condition eventPlayer.isUsingAbility1() == true
    
    eventPlayer.MaugaOverHP = eventPlayer.MaugaOverHP - eventDamage * 2
    if eventPlayer.isUsingAbility2() == true:
        eventPlayer.MaugaOverHP = eventPlayer.MaugaOverHP - eventDamage * 1.4


rule "Overrun break shield":
    @Event eachPlayer
    @Hero mauga
    @Condition eventPlayer.MaugaOverHP <= 0
    
    if eventPlayer.isUsingAbility1() == true:
        eventPlayer.forceButtonPress(Button.ABILITY_1)
    eventPlayer.setStatusEffect(null, Status.STUNNED, 0.2)
    wait(0.5)
    eventPlayer.setAbility1Enabled(false)
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 8)
    eventPlayer.MaugaOverHP = 0
    waitUntil(eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0, 8)
    eventPlayer.setAbility1Enabled(true)


rule "Overrun recharge shield":
    @Event eachPlayer
    @Hero mauga
    @Condition eventPlayer.MaugaOverHP != 200
    @Condition eventPlayer.isUsingAbility1() == false
    
    if not eventPlayer.isUsingAbility1():
        wait(2, Wait.ABORT_WHEN_FALSE)
        chaseAtRate(eventPlayer.MaugaOverHP, 200, 50)


rule "Overrun check for stomp":
    @Event eachPlayer
    @Hero mauga
    @Condition eventPlayer.isUsingAbility1() == true
    
    wait(3, Wait.ABORT_WHEN_FALSE)
    waitUntil(not eventPlayer.isUsingAbility1(), 1)
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 6)


rule "[sombra/translocator.opy] Sombra stealth self cancel":
    @Event eachPlayer
    @Hero sombra
    @Condition (eventPlayer.stealth_timer <= 5 and eventPlayer.stealth_timer > 0 and eventPlayer.isHoldingButton(Button.ABILITY_2)) == true
    @Condition eventPlayer.Sombra_invisible == true
    
    eventPlayer.setStatusEffect(null, Status.ROOTED, 0.001)
    eventPlayer.Sombra_invisible = false
    #printLog("Current Translocator Cooldown: {0} | Target Translocator Cooldown: {1}".format(eventPlayer.getAbilityCooldown(Button.ABILITY_2), eventPlayer._stealth_max_cooldown - 5 + (eventPlayer.stealth_timer * (1 - STEALTH_REFUND_FRACTION))))
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, eventPlayer.stealth_pvar[0] - 5 + (eventPlayer.stealth_timer * (1 - STEALTH_REFUND_FRACTION)))
    eventPlayer.stealth_timer = 0


rule "destroy all huds and effects between rounds":
    @Event eachPlayer
    @Condition isMatchBetweenRounds() == true
    
    destroyAllProgressBarInWorldTexts()
    destroyAllInWorldTexts()
    destroyAllEffects()
    destroyAllProgressBarHuds()
    destroyAllHudTexts()


rule "Doomfist punch track":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.isFiringSecondaryFire() == true
    
    eventPlayer.DoomPunchTrack = false
    waitUntil(not eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) or not eventPlayer.isFiringSecondaryFire(), 1.6)
    eventPlayer.DoomPunchTrack = true


rule "Reinhardt charge track":
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer.isUsingAbility1() == true
    
    eventPlayer.ReinChargeTrack = true
    waitUntil(not eventPlayer.isUsingAbility1(), 5)
    eventPlayer.ReinChargeTrack = false


rule "Mauga overrun knockdown":
    @Event playerDealtDamage
    @Hero mauga
    @Condition eventAbility == Button.ABILITY_1
    @Condition (victim.getHero() == Hero.REINHARDT and victim.ReinChargeTrack or victim.getHero() == Hero.DOOMFIST and victim.isFiringSecondaryFire() and victim.DoomPunchTrack or victim.getHero() == Hero.BRIGITTE and victim.isFiringSecondaryFire() and victim.isFiringPrimaryFire()) == true
    @Condition abs(angleDifference(eventPlayer.getHorizontalFacingAngle(), victim.getHorizontalFacingAngle() * -1)) <= 90 == true
    
    eventPlayer.cancelPrimaryAction()
    eventPlayer.setStatusEffect(victim, Status.KNOCKED_DOWN, 1.7)
    victim.setStatusEffect(eventPlayer, Status.KNOCKED_DOWN, 1.7)
    wait(0.09)
    victim.applyImpulse(victim.getVelocity() * -1, 0.001, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)


rule "[orisa/init.opy]: Correct Orisa Spin, Melee damage":
    @Event playerDealtDamage
    @Hero orisa
    @Condition eventAbility in [Button.ABILITY_1, Button.ABILITY_2, Button.MELEE] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[orisa/init.opy]: Correct Orisa Javelin damage":
    @Event playerDealtDamage
    @Hero orisa
    @Condition eventAbility == Button.SECONDARY_FIRE
    
    damage(victim, attacker, (0.929 * (eventDamage / eventPlayer.macro_pvar[0]) - eventDamage) / eventPlayer.macro_pvar[0])


rule "[status/hud.opy]: Display buffs from Roadhog and Sombra":
    @Event eachPlayer
    @Condition (eventPlayer.Roadhog_vape_hud_icon or eventPlayer.Sombra_hack_icon) == true
    
    hudSubtext(eventPlayer, " \r\n\r\n\r\n\r", HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
    eventPlayer.Status_Effect_Spectator_HUD = getLastCreatedText()
    hudSubtext(eventPlayer, " \r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n                                             {2}{0} {1}".format(abilityIconString(Hero.ROADHOG, Button.SECONDARY_FIRE) if eventPlayer.Roadhog_vape_hud_icon == true else " ", abilityIconString(Hero.SOMBRA, Button.ULTIMATE) if eventPlayer.Sombra_hack_icon == true else " ", "              "), HudPosition.LEFT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    eventPlayer.Status_effect_hud = getLastCreatedText()
    wait(5)
    destroyHudText(eventPlayer.Status_effect_hud)
    destroyHudText(eventPlayer.Status_Effect_Spectator_HUD)


rule "[ana/sleep.opy]: Cleanse the sleep on tanks on damage":
    @Event playerTookDamage
    @Condition eventPlayer.hasStatus(Status.KNOCKED_DOWN) == true
    @Condition eventPlayer.Ana_Sleepdart_Target == true
    
    if getPlayersOnHero(Hero.ANA, getOppositeTeam(eventPlayer.getTeam())).getAbilityCooldown(Button.ABILITY_1) != 0:
        eventPlayer.clearStatusEffect(Status.KNOCKED_DOWN)
        eventPlayer.Ana_Sleepdart_Target = null


rule "[lifeweaver/healing.opy]: Lifeweaver Healing cooldown":
    @Event eachPlayer
    @Condition eventPlayer.Lifeweaver_healing_cd == true
    
    wait(4, Wait.ABORT_WHEN_FALSE)
    eventPlayer.Lifeweaver_healing_cd = null


rule "[juno/init.opy]: Correct Pulsar Torpedo healing over time":
    @Event playerDealtHealing
    @Hero juno
    @Condition eventHealing > 69
    
    healee.startDamageOverTime(null, 2.4, 10)

def initMei():
    @Name "[mei/init.opy]: Initialize Mei TANK"
    
    eventPlayer.custom_hp_pvar[0] = 400
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2800
    eventPlayer.macro_pvar[0] = 0.66
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.startScalingSize(1.15)
    eventPlayer.hero_initialized = true
    eventPlayer.max_health_scaler = 1.1


rule "[mei/init.opy]: Reduce Headshot damage taken Mei":
    @Event playerTookDamage
    @Hero mei
    @Condition eventWasCriticalHit == true
    
    heal(eventPlayer, null, eventDamage * 0.3)


rule "[mei/endothermic.opy]: AOE Damage Mei":
    @Event playerDealtDamage
    @Hero mei
    @Condition eventAbility == Button.SECONDARY_FIRE
    
    playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.SKY_BLUE, victim, 2)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.AQUA, victim, 5)
    playEffect(getAllPlayers(), DynamicEffect.DEBUFF_IMPACT_SOUND, Color.SKY_BLUE, eventPlayer, 40)
    damage(getPlayersInRadius(victim, 5, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES_AND_ENEMY_BARRIERS), attacker, 25)


rule "[junkerqueen/init.opy]: Shout indicator":
    @Event eachPlayer
    @Hero junkerQueen
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0
    @Condition isMatchBetweenRounds() == false
    
    createInWorldText(eventPlayer, "{0} {1}".format(len([player for player in getLivingPlayers(eventPlayer.getTeam()) if distance(eventPlayer, player) <= 15 and isInLoS(eventPlayer, player) == true and player.getHero() != Hero.JUNKER_QUEEN]), abilityIconString(Hero.JUNKER_QUEEN, Button.ABILITY_1)), updateEveryFrame(eventPlayer.getEyePosition() + (100 * (0 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + (-0.5 * (directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 * eventPlayer.getFacingDirection()))), 2)
    eventPlayer.JQ_Shout_Hud = getLastCreatedText()
    waitUntil(eventPlayer.isUsingAbility1() == true, 99999)
    destroyInWorldText(eventPlayer.JQ_Shout_Hud)
    eventPlayer.JQ_Shout_Hud = null


rule "[junkerqueen/init.opy]: Clean up JQ":
    @Event eachPlayer
    @Condition eventPlayer.hero_setup != Hero.JUNKER_QUEEN
    
    destroyInWorldText(eventPlayer.JQ_Shout_Hud)


rule "hazard reveal enemies":
    @Event playerDealtDamage
    @Hero hazard
    @Condition victim.hasStatus(Status.ROOTED) == true
    @Condition eventAbility == Button.ULTIMATE
    @Condition victim.Hazard_Downpour_Target == null
    
    createInWorldText(eventPlayer, "{0} {1}m".format(abilityIconString(Hero.HAZARD, Button.ULTIMATE), ceil(distance(eventPlayer, victim))), victim + vect(0, 2.5, 0), 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING)
    victim.Hazard_Downpour_effect = getLastCreatedText()
    victim.Hazard_Downpour_Target = true


rule "hazard reset reveal enemies":
    @Event eachPlayer
    @Condition eventPlayer.Hazard_Downpour_Target == true
    
    wait(2.5)
    destroyInWorldText(eventPlayer.Hazard_Downpour_effect)
    eventPlayer.Hazard_Downpour_Target = null
    eventPlayer.Hazard_Downpour_effect = null


def initFreja():
    @Name "[freja/init.opy]: initFreja()"
    @Disabled
    
    eventPlayer.custom_hp_pvar[0] = 200
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1900
    eventPlayer.macro_pvar[0] = 0.667
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.startScalingSize(0.96)
    eventPlayer.hero_initialized = true


rule "[freja/init.opy]: Correct Freja other forms of damage":
    @Event playerDealtDamage
    @Condition eventAbility == Button.MELEE
    @Disabled
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[freja/init.opy]: Correct Freja secondary impact damage":
    @Event playerDealtDamage
    @Condition eventAbility == Button.SECONDARY_FIRE
    @Disabled
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])
    wait(3)



rule "[mccree/fanthehammer.opy]: Increase Fan the hammer damage to 40":
    @Event playerDealtDamage
    @Hero cassidy
    @Condition eventAbility == Button.SECONDARY_FIRE
    
    damage(victim, attacker, (0.8 * (eventDamage / eventPlayer.macro_pvar[0]) - eventDamage) / eventPlayer.macro_pvar[0])


rule "[ashe/dynamite.opy]: Decreased dynamite damage by healing until timeout or cleansed = 85 damage":
    @Event playerDealtDamage
    @Hero ashe
    @Condition eventAbility == Button.ABILITY_2
    
    victim.startHealingOverTime(null, 5, 2)
    victim.Ashe_Dynamite_Healing_ID = getLastHealingModification()
    waitUntil(victim.hasStatus(Status.PHASED_OUT) == true, 5)
    stopHealingOverTime(victim.Ashe_Dynamite_Healing_ID)
    victim.Ashe_Dynamite_Healing_ID = null


