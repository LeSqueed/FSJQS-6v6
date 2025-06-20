rule "[sombra/hack.opy] Hacked healpack bonus speed":
    @Event playerReceivedHealing
    @Condition eventWasHealthPack == true
    
    if healer.getHero() == Hero.SOMBRA:
        eventPlayer.macro_pvar[2] = eventPlayer.macro_pvar[2] + 25
        eventPlayer.setMoveSpeed(eventPlayer.macro_pvar[2])
        wait(2)
        eventPlayer.macro_pvar[2] = eventPlayer.macro_pvar[2] - 25
        eventPlayer.setMoveSpeed(eventPlayer.macro_pvar[2])


rule "[sombra/hack.opy] Hack target for 1.8s":
    @Event eachPlayer
    @Condition eventPlayer.hasStatus(Status.HACKED) == true
    @Condition getPlayersOnHero(Hero.SOMBRA, getOppositeTeam(eventPlayer.getTeam())).getAbilityCooldown(Button.SECONDARY_FIRE) != 0
    
    eventPlayer.setStatusEffect(getPlayersOnHero(Hero.SOMBRA, getOppositeTeam(eventPlayer.getTeam())), Status.HACKED, 1.8)
