rule "[brigitte/bash.opy]: Correct Shield Bash damage":
    @Event playerDealtDamage
    @Hero brigitte
    @Condition eventPlayer.isFiringSecondaryFire() == true
    @Condition eventAbility == Button.PRIMARY_FIRE
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[brigitte/bash.opy]: Track Bash cooldown":
    @Event eachPlayer
    @Hero brigitte
    @Condition eventPlayer.isFiringPrimaryFire() == true
    @Condition eventPlayer.isFiringSecondaryFire() == true
    
    eventPlayer.bash_cooldown = 5.3
    chaseAtRate(eventPlayer.bash_cooldown, 0, 1, ChaseRateReeval.NONE)


rule "[brigitte/bash.opy]: Force cooldown for Bash in Rally":
    @Event eachPlayer
    @Hero brigitte
    @Condition eventPlayer.isUsingUltimate() == true
    
    eventPlayer.setAbilityCooldown(Button.PRIMARY_FIRE, eventPlayer.bash_cooldown)