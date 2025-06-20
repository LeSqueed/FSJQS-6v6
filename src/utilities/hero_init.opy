def initHero():
    @Name "[utilities/hero_init.opy]: initHero()"

    switch eventPlayer.hero_setup:
        case Hero.ANA:
            initAna()
            break
        case Hero.ASHE:
            initAshe()
            break
        case Hero.BAPTISTE:
            initBaptiste()
            break
        case Hero.BASTION:
            initBastion()
            break
        case Hero.BRIGITTE:
            initBrigitte()
            break
        case Hero.DOOMFIST:
            initDoomfist()
            break
        case Hero.DVA:
            initDva()
            break
        case Hero.ECHO:
            initEcho()
            break
        case Hero.GENJI:
            initGenji()
            break
        case Hero.HANZO:
            initHanzo()
            break
        case Hero.ILLARI:
            initIllari()
            break
        case Hero.JUNKER_QUEEN:
            initJunkerQueen()
            break
        case Hero.JUNKRAT:
            initJunkrat()
            break
        case Hero.JUNO:
            initJuno()
            break
        case Hero.KIRIKO:
            initKiriko()
            break
        case Hero.LIFEWEAVER:
            initLifeweaver()
            break
        case Hero.LUCIO:
            initLucio()
            break
        case Hero.MAUGA:
            initMauga()
            break
        case Hero.CASSIDY:
            initCassidy()
            break
        case Hero.MEI:
            initMei()
            break
        case Hero.MERCY:
            initMercy()
            break
        case Hero.MOIRA:
            initMoira()
            break
        case Hero.ORISA:
            initOrisa()
            break
        case Hero.PHARAH:
            initPharah()
            break
        case Hero.RAMATTRA:
            initRamattra()
            break
        case Hero.REAPER:
            initReaper()
            break
        case Hero.REINHARDT:
            initReinhardt()
            break
        case Hero.ROADHOG:
            initRoadhog()
            break
        case Hero.SIGMA:
            initSigma()
            break
        case Hero.SOJOURN:
            initSojourn()
            break
        case Hero.SOLDIER:
            initSoldier()
            break
        case Hero.SOMBRA:
            initSombra()
            break
        case Hero.SYMMETRA:
            initSymmetra()
            break
        case Hero.TORBJORN:
            initTorbjorn()
            break
        case Hero.TRACER:
            initTracer()
            break
        case Hero.VENTURE:
            initVenture()
            break
        case Hero.WIDOWMAKER:
            initWidowmaker()
            break
        case Hero.WINSTON:
            initWinston()
            break
        case Hero.WRECKING_BALL:
            initWreckingBall()
            break
        case Hero.ZARYA:
            initZarya()
            break
        case Hero.ZENYATTA:
            initZenyatta()
            break
        case Hero.HAZARD:
            initHazard()
            break
        case Hero.FREJA:
            initFreja()
            break
        default:
            bigMessage(eventPlayer, "warning: {0} not initialized properly!".format(eventPlayer.hero_setup))