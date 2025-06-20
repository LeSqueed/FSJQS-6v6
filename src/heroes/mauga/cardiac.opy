rule "[mauga/cardiac.opy]: Cardiac Use Ability":
    @Event eachPlayer
    @Hero mauga
    @Condition eventPlayer.isUsingAbility2() == true
    
    eventPlayer.addHealthPool(Health.NORMAL, 150, false)
    eventPlayer.Mauga_Overdrive_Health = getLastCreatedHealthPool()
    eventPlayer._current_damage_received += 40
    eventPlayer.setDamageReceived(eventPlayer._current_damage_received)
    wait(3)
    removeHealthPool(eventPlayer.Mauga_Overdrive_Health)
    eventPlayer._current_damage_received -= 40
    eventPlayer.setDamageReceived(eventPlayer._current_damage_received)


rule "[mauga/cardiac.opy]: Mauga Heal Others":
    @Event eachPlayer
    @Condition getPlayersOnHero(Hero.MAUGA, eventPlayer.getTeam()).isUsingAbility2() == true
    @Condition distance(eventPlayer, getPlayersOnHero(Hero.MAUGA, eventPlayer.getTeam())) <= 10.5
    
    eventPlayer.startHealingOverTime(getPlayersOnHero(Hero.MAUGA, eventPlayer.getTeam()), 3, 40)
    eventPlayer.Cardiac_overdrive_active = getLastHealingOverTimeId()
    waitUntil(not getPlayersOnHero(Hero.MAUGA, eventPlayer.getTeam()).isUsingAbility2(), 3)
    stopHealingOverTime(eventPlayer.Cardiac_overdrive_active)