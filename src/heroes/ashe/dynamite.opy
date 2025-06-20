rule "[ashe/dynamite.opy]: Decreased dynamite damage by healing until timeout or cleansed = 85 damage":
    @Event playerDealtDamage
    @Hero ashe
    @Condition eventAbility == Button.ABILITY_2
    @Condition victim.Ashe_dynamite_hit == null
    
    eventPlayer.Ashe_dynamite_hit = true
    victim.startHealingOverTime(null, 5, 2)
    victim.Ashe_Dynamite_Healing_ID = getLastHealingModification()
    waitUntil(victim.hasStatus(Status.PHASED_OUT) or victim.hasStatus(Status.INVINCIBLE), 5)
    stopHealingOverTime(victim.Ashe_Dynamite_Healing_ID)
    victim.Ashe_Dynamite_Healing_ID = null
    eventPlayer.Ashe_dynamite_hit = null
