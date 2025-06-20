rule "[passives/damage/healthpack.opy] Healthpacks substitute healing":
    @Event playerReceivedHealing
    @Condition eventWasHealthPack == true
    
    if eventHealing >= 250:
        if eventHealing > 251:
            if eventPlayer.getHero() in getTankHeroes():
                heal(eventPlayer, null, 39)
            else:
                heal(eventPlayer, null, 8)
        else:
            heal(eventPlayer, null, 70)
    elif eventHealing >= 75:
        if eventHealing > 76:
            if eventPlayer.getHero() in getTankHeroes():
                heal(eventPlayer, null, 16)
            else:
                heal(eventPlayer, null, 6)
        else:
            heal(eventPlayer, null, 25)