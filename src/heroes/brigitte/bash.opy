#!mainFile "../../main.opy"

rule "[brigitte/bash.opy]: Correct Shield Bash damage":
    @Event playerDealtDamage
    @Hero brigitte
    @Condition eventPlayer.isFiringSecondaryFire() == true
    @Condition eventAbility == Button.PRIMARY_FIRE
    
    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar - eventDamage) / eventPlayer._base_damage_scalar)


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
    eventPlayer.removeAllHealthPools()
    eventPlayer.setMaxHealth(125)
    wait()
    heal(eventPlayer, null, 70)
    waitUntil(not eventPlayer.isUsingUltimate(), Math.INFINITY)
    eventPlayer.setMaxHealth(100)
    eventPlayer._max_health_scalar = HeroHealthPercentage.BRIGITTE / 100
    applyCustomHp()

