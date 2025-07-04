#!mainFile "../../main.opy"

rule "[passives/damage/healthpack.opy] Healthpacks substitute healing for DPS/SUPPORTS":
    @Event playerReceivedHealing
    @Condition eventWasHealthPack == true
    @Condition eventPlayer.getHero() in getDamageHeroes() == true

    if eventHealing >= 250:
        if eventHealing > 251:
        else:
            heal(eventPlayer, null, 75)
    if eventHealing < 250:
        if eventHealing >= 75:
            if eventHealing > 76:
                heal(eventPlayer, null, 2.5)
            else:
                heal(eventPlayer, null, 25)


rule "[passives/damage/healthpack.opy] Healthpacks substitute healing for TANKS":
    @Event playerReceivedHealing
    @Condition eventWasHealthPack == true
    @Condition eventPlayer.getHero() in getTankHeroes() == true

    if eventHealing >= 250:
        if eventHealing > 251:
            heal(eventPlayer, null, 37.5)
        else:
            heal(eventPlayer, null, 75)
    if eventHealing < 250:
        if eventHealing >= 75:
            if eventHealing > 76:
                heal(eventPlayer, null, 3.75)
            else:
                heal(eventPlayer, null, 25)