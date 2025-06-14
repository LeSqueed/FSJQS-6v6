rule "[doomfist/meteor_strike.opy]: Correct Meteor Strike and Doomfist melee damage":
    @Event playerDealtDamage
    @Hero doomfist
    @Condition eventAbility in [Button.MELEE, Button.ULTIMATE] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])
