rule "[genji/dragonblade.opy]: Genji Damage in Ultimate 100 and reset deflect cooldown":
    @Event eachPlayer
    @Hero genji
    @Condition eventPlayer.isUsingUltimate() == true
    
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, 0)
    eventPlayer.setDamageDealt(91)
    waitUntil(not eventPlayer.isUsingUltimate(), 6)
    eventPlayer.setDamageDealt(100)
