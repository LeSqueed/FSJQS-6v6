#!mainFile "../main.opy"

subroutine initHero
subroutine initAna
subroutine initAshe
subroutine initBaptiste
subroutine initBastion
subroutine initBrigitte
subroutine initDoomfist
subroutine initDva
subroutine initEcho
subroutine initGenji
subroutine initHanzo
subroutine initIllari
subroutine initJunkerQueen
subroutine initJunkrat
subroutine initJuno
subroutine initKiriko
subroutine initLucio
subroutine initMccree
subroutine initMercy
subroutine initMoira
subroutine initPharah
subroutine initRamattra
subroutine initReaper
subroutine initReinhardt
subroutine initRoadhog
subroutine initSigma
subroutine initSojourn
subroutine initSoldier
subroutine initTorbjorn
subroutine initTracer
subroutine initWidowmaker
subroutine initWinston
subroutine initWreckingBall
subroutine initZarya
subroutine initZenyatta
subroutine initMauga
subroutine initLifeweaver
subroutine initOrisa
subroutine initVenture
subroutine initMei
subroutine initSombra
subroutine initSymmetra
subroutine initHazard
subroutine initFreja

playervar hero_initialized
playervar remainingAntiDuration

#!include "utilities/hero_switch.opy"

def initHero():
    @Name "[utilities/hero_init.opy]: initHero()"
    
    if true:
        goto loc+[82, 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64, 66, 68, 70, 72, 74, 76, 78, 80][1 + [Hero.ANA, Hero.ASHE, Hero.BAPTISTE, Hero.BASTION, Hero.BRIGITTE, Hero.DOOMFIST, Hero.DVA, Hero.ECHO, Hero.GENJI, Hero.HANZO, Hero.ILLARI, Hero.JUNKER_QUEEN, Hero.JUNKRAT, Hero.JUNO, Hero.KIRIKO, Hero.LIFEWEAVER, Hero.LUCIO, Hero.MAUGA, Hero.CASSIDY, Hero.MEI, Hero.MERCY, Hero.MOIRA, Hero.ORISA, Hero.PHARAH, Hero.RAMATTRA, Hero.REAPER, Hero.REINHARDT, Hero.ROADHOG, Hero.SIGMA, Hero.SOJOURN, Hero.SOLDIER, Hero.SOMBRA, Hero.SYMMETRA, Hero.TORBJORN, Hero.TRACER, Hero.VENTURE, Hero.WIDOWMAKER, Hero.WINSTON, Hero.WRECKING_BALL, Hero.ZARYA, Hero.ZENYATTA].index(eventPlayer.hero_setup)]
        initAna()
    else:
        initAshe()
    else:
        initBaptiste()
    else:
        initBastion()
    else:
        initBrigitte()
    else:
        initDoomfist()
    else:
        initDva()
    else:
        initEcho()
    else:
        initGenji()
    else:
        initHanzo()
    else:
        initIllari()
    else:
        initJunkerQueen()
    else:
        initJunkrat()
    else:
        initJuno()
    else:
        initKiriko()
    else:
        initLifeweaver()
    else:
        initLucio()
    else:
        initMauga()
    else:
        initMccree()
    else:
        initMei()
    else:
        initMercy()
    else:
        initMoira()
    else:
        initOrisa()
    else:
        initPharah()
    else:
        initRamattra()
    else:
        initReaper()
    else:
        initReinhardt()
    else:
        initRoadhog()
    else:
        initSigma()
    else:
        initSojourn()
    else:
        initSoldier()
    else:
        initSombra()
    else:
        initSymmetra()
    else:
        initTorbjorn()
    else:
        initTracer()
    else:
        initVenture()
    else:
        initWidowmaker()
    else:
        initWinston()
    else:
        initWreckingBall()
    else:
        initZarya()
    else:
        initZenyatta()
    else:
        initHazard()
    else:
    else:
    if not eventPlayer.hero_initialized:
        bigMessage(eventPlayer, "warning: {0} not initialized properly!".format(eventPlayer.hero_setup))
