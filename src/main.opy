rule "Copyright (c) 2024 Overwatch 1 Emulator & 6v6 Adjustments. See github.com/6v6-Adjustments/6v6-adjustments for license to use this code.":
    disableInspector()

#!include "enums/HeroHealthPercentage.opy"
#!include "lobby/lobby.opy"
#!include "constants/global.opy"
#!include "constants/player.opy"

#!optimizeStrict

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
subroutine initCassidy 26
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

#!include "heroes/init.opy"
#!include "utilities/hero_init.opy"
#!include "utilities/global.opy"
#!include "utilities/custom_hp.opy"
#!include "utilities/hero_switch.opy"
#!include "utilities/anti_crash.opy"
#!include "utilities/hud.opy"
#!include "utilities/utilities.opy"
#!include "utilities/reset.opy"
#!include "utilities/role_lock.opy"
#!include "passives/healing.opy"
#!include "passives/tank/ult_charge.opy"
#!include "passives/tank/knockback.opy"
#!include "passives/damage/damage_passive.opy"
#!include "passives/damage/healthpack.opy"
#!include "debug_mode.opy"
