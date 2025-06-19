rule "[ana/sleep.opy]: Sleep tanks as long as other heroes":
    @Event playerDealtDamage
    @Hero ana
    @Condition eventAbility == Button.ABILITY_1
    @Condition victim.getHero() in getTankHeroes() == true
    
    waitUntil(victim.hasStatus(Status.ASLEEP), 999999986991104)
    wait(0.2)
    #Sleeping someone on top of sleep doesnt work anymore
    victim.setStatusEffect(attacker, Status.KNOCKED_DOWN, 4.8)
    victim.Ana_Sleepdart_Target = true


rule "[ana/sleep.opy]: Cleanse the sleep on tanks on damage":
    @Event playerTookDamage
    @Condition eventPlayer.hasStatus(Status.KNOCKED_DOWN) == true
    @Condition eventPlayer.Ana_Sleepdart_Target == true
    
    if getPlayersOnHero(Hero.ANA, getOppositeTeam(eventPlayer.getTeam())).getAbilityCooldown(Button.ABILITY_1) != 0:
        eventPlayer.clearStatusEffect(Status.KNOCKED_DOWN)
        eventPlayer.Ana_Sleepdart_Target = null