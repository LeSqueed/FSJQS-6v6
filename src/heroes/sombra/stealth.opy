rule "[sombra/stealth.opy]: Sombra stealth took damage":
    @Event playerTookDamage
    @Hero sombra
    @Condition eventPlayer.Sombra_invisible == true
    
    eventPlayer.Sombra_invis_damage = true
    wait(1.3, Wait.RESTART_WHEN_TRUE)
    eventPlayer.Sombra_invis_damage = false


rule "[sombra/stealth.opy]: Sombra stealth reveal slow":
    @Event playerTookDamage
    @Hero sombra
    @Condition eventPlayer.Sombra_invis_damage == true
    @Condition eventPlayer.Sombra_invisible == true
    
    eventPlayer._current_move_speed = eventPlayer._current_move_speed - 47.5
    eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)
    waitUntil(not eventPlayer.Sombra_invisible or not eventPlayer.Sombra_invis_damage, 100000000)
    eventPlayer._current_move_speed = eventPlayer._current_move_speed + 47.5
    eventPlayer.setMoveSpeed(eventPlayer._current_move_speed)
