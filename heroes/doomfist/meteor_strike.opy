rule "[doomfist/meteor_strike.opy]: Correct Meteor Strike and Doomfist melee damage":
    @Event playerDealtDamage
    @Hero doomfist
    @Condition eventAbility in [Button.MELEE, Button.ULTIMATE] == true
    
    damage(victim, eventPlayer, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[doomfist/meteor_strike.opy]: Doomfist ult remove self healing":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.isUsingUltimate() == true
    
    eventPlayer.setHealingDealt(0)
    waitUntil(not eventPlayer.isUsingUltimate(), 99999)
    eventPlayer.setHealingDealt(100)
