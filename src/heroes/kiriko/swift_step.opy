rule "[kiriko/swift_step.opy]: Force swift step cooldown after spawning":
    @Event playerDied
    @Hero kiriko
    
    waitUntil(eventPlayer.isAlive() and eventPlayer.isInSpawnRoom(), 999999986991104)
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 5)


rule "[kiriko/swift_step.opy]: Heal when using Swift Step":
    @Event eachPlayer
    @Hero kiriko
    @Condition eventPlayer.isUsingAbility1() == true
    
    #grace period to allow SS to cleanse anti-heal effects
    wait(0.1)
    eventPlayer.startHealingOverTime(null, 0.25, 140 / eventPlayer._base_healing_scalar)
