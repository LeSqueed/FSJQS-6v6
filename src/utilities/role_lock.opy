rule "[role_lock.opy]: Global/set all Heroes":
    AllTankHeroes = [Hero.DVA, Hero.JUNKER_QUEEN, Hero.MAUGA, Hero.ORISA, Hero.RAMATTRA, Hero.REINHARDT, Hero.ROADHOG, Hero.SIGMA, Hero.VENTURE, Hero.WINSTON, Hero.WRECKING_BALL, Hero.ZARYA, Hero.HAZARD]
    AllDpsHeroes = [Hero.ASHE, Hero.BASTION, Hero.CASSIDY, Hero.ECHO, Hero.GENJI, Hero.HANZO, Hero.JUNKRAT, Hero.PHARAH, Hero.REAPER, Hero.SOJOURN, Hero.SOLDIER, Hero.TORBJORN, Hero.TRACER, Hero.WIDOWMAKER, Hero.SYMMETRA, Hero.FREJA, Hero.DOOMFIST, Hero.MEI]
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
        waitUntil(len(([player for player in getPlayers(eventPlayer.getTeam()) if player.getHero() in AllTankHeroes]).exclude(eventPlayer)) < AllRoles[0], Math.INFINITY)
        eventPlayer.AllowedHeroes.append(AllTankHeroes)
        eventPlayer.setAllowedHeroes(eventPlayer.AllowedHeroes)


rule "[role_lock.opy]: Damage":
    @Event eachPlayer
    @Condition len(([player for player in getPlayers(eventPlayer.getTeam()) if player.getHero() in AllDpsHeroes]).exclude(eventPlayer)) >= AllRoles[1]
    @Condition AllRoles[1] > 0
    
    if eventPlayer.Echo_Copy == false:
        eventPlayer.AllowedHeroes.remove(AllDpsHeroes)
        eventPlayer.setAllowedHeroes(eventPlayer.AllowedHeroes)
        waitUntil(len(([player for player in getPlayers(eventPlayer.getTeam()) if player.getHero() in AllDpsHeroes]).exclude(eventPlayer)) < AllRoles[1], Math.INFINITY)
        eventPlayer.AllowedHeroes.append(AllDpsHeroes)
        eventPlayer.setAllowedHeroes(eventPlayer.AllowedHeroes)


rule "[role_lock.opy]: Support":
    @Event eachPlayer
    @Condition len(([player for player in getPlayers(eventPlayer.getTeam()) if player.getHero() in AllSupportHeroes]).exclude(eventPlayer)) >= AllRoles[2]
    @Condition AllRoles[2] > 0
    
    if eventPlayer.Echo_Copy == false:
        eventPlayer.AllowedHeroes.remove(AllSupportHeroes)
        eventPlayer.setAllowedHeroes(eventPlayer.AllowedHeroes)
        waitUntil(len(([player for player in getPlayers(eventPlayer.getTeam()) if player.getHero() in AllSupportHeroes]).exclude(eventPlayer)) < AllRoles[2], Math.INFINITY)
        eventPlayer.AllowedHeroes.append(AllSupportHeroes)
        eventPlayer.setAllowedHeroes(eventPlayer.AllowedHeroes)


rule "[role_lock.opy]: Skip Assemble Heroes":
    @Condition isAssemblingHeroes() == true
    
    wait(1)
    setMatchTime(1)
    waitUntil(not isAssemblingHeroes(), Math.INFINITY)
    setMatchTime(60)