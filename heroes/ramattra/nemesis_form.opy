rule "[ramattra/nemesis_form.opy]: Correct Nemesis Form armor and movement speed":
    @Event eachPlayer
    @Hero ramattra
    @Condition eventPlayer.isUsingAbility1() == true
    
    eventPlayer.startScalingSize(0.97)
    eventPlayer.setDamageDealt(92.308)
    eventPlayer.MoveSpeed -= 16.6
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    #for some reason the addHealthPool function doesn't read constants as usable numbers
    eventPlayer.addHealthPool(Health.ARMOR, 11, true, false)
    eventPlayer.Nemesis_armor = getLastCreatedHealthPool()
    waitUntil(not eventPlayer.isUsingAbility1(), 999999986991104)
    eventPlayer.MoveSpeed += 16.6
    eventPlayer.setMoveSpeed(eventPlayer.MoveSpeed)
    eventPlayer.stopScalingSize()
    removeHealthPool(eventPlayer.Nemesis_armor)
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])


rule "[ramattra/nemesis_form.opy]: Increase other forms of damage (in nemesis)":
    @Event playerDealtDamage
    @Hero ramattra
    @Condition eventPlayer.isUsingUltimate() == true
    #This condition stops pummel from applying the damage increase
    @Condition eventDamage < 60
    
    damage(victim, null, (eventDamage / 0.923 - eventDamage) / 0.923)
