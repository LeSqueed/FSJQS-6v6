rule "[passives/damage/damage_passive.opy]: Remove DPS Passive":
    @Event playerTookDamage
    @Condition attacker.getHero() in getDamageHeroes() == true
    @Condition attacker != victim
    
    if victim.getHero() in getTankHeroes():
        eventPlayer.setHealingReceived(112.5)
    else:
        eventPlayer.setHealingReceived(125)
    wait(0.5)
    wait(2.5, Wait.RESTART_WHEN_TRUE)
    eventPlayer.setHealingReceived(100)
