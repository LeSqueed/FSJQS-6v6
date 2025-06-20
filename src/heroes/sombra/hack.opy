rule "[sombra/hack.opy] Hacked healpack bonus speed":
    @Event playerReceivedHealing
    @Condition eventWasHealthPack == true
    
    if healer.getHero() == Hero.SOMBRA:
        eventPlayer._current_move_speed += 25
        eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)
        wait(2)
        eventPlayer._current_move_speed -= 25
        eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)


rule "[sombra/hack.opy] Hack target for 1.8s":
    @Event eachPlayer
    @Condition eventPlayer.hasStatus(Status.HACKED) == true
    @Condition getPlayersOnHero(Hero.SOMBRA, getOppositeTeam(eventPlayer.getTeam())).getAbilityCooldown(Button.SECONDARY_FIRE) != 0
    
    eventPlayer.setStatusEffect(getPlayersOnHero(Hero.SOMBRA, getOppositeTeam(eventPlayer.getTeam())), Status.HACKED, 1.8)
