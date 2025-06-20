rule "[orisa/heat.opy]: subtract ammo generate heat":
    @Event eachPlayer
    @Hero orisa
    @Condition updateEveryFrame(eventPlayer.isFiringPrimaryFire()) == true
    
    eventPlayer.Orisa_Ammo--
    eventPlayer.Orisa_Heat += 4
    wait(0.1)
    if ruleCondition:
        loop()


rule "[orisa/heat.opy]: ammo refresh":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.Orisa_Ammo <= 0
    
    eventPlayer.setAmmo(0, 0)
    chaseAtRate(eventPlayer.Orisa_Ammo, 100, 33)
    eventPlayer.setPrimaryFireEnabled(false)
    #damage(getPlayersInRadius(eventPlayer + Vector.UP, 6, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES_AND_ENEMY_BARRIERS), eventPlayer, eventPlayer.Orisa_Heat / eventPlayer._base_damage_scalar)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.ORANGE, eventPlayer, 8)
    (getPlayersInRadius(eventPlayer + Vector.UP, 8, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES_AND_ENEMY_BARRIERS)).startDamageOverTime(eventPlayer, 3, eventPlayer.Orisa_Heat / 2.5 / eventPlayer._base_damage_scalar)
    getPlayersInRadius(eventPlayer, 8, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES).setStatusEffect(eventPlayer, Status.BURNING, 3)
    wait(1)
    waitUntil(eventPlayer.Orisa_Ammo >= 100, 99999)
    eventPlayer.Orisa_Heat = 0
    eventPlayer.setPrimaryFireEnabled(true)
    stopChasingVariable(eventPlayer.Orisa_Ammo)


rule "[orisa/heat.opy]: reload":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isHoldingButton(Button.RELOAD) == true
    
    eventPlayer.Orisa_Ammo = 0


rule "[orisa/heat.opy]: lock heat at 100":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.Orisa_Heat > 100
    
    eventPlayer.Orisa_Heat = 100


rule "[orisa/heat.opy]: Heat animation 100":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.Orisa_Heat > 90
    
    eventPlayer.setStatusEffect(null, Status.BURNING, Math.INFINITY)
    eventPlayer.startDamageOverTime(eventPlayer, Math.INFINITY, 20)
    eventPlayer.Orisa_Overheating = getLastDamageOverTimeId()
    waitUntil(eventPlayer.Orisa_Heat <= 89, Math.INFINITY)
    eventPlayer.clearStatusEffect(Status.BURNING)
    stopDamageOverTime(eventPlayer.Orisa_Overheating)
    eventPlayer.Orisa_Overheating = null

rule "[orisa/heat.opy]: burn during fortify":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isUsingAbility1() == true
    @Disabled
    
    (getPlayersInRadius(eventPlayer + Vector.UP, 8, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES_AND_ENEMY_BARRIERS)).startDamageOverTime(eventPlayer, 1, eventPlayer.Orisa_Heat / 2.5 / eventPlayer._base_damage_scalar)
    getPlayersInRadius(eventPlayer, 8, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES).setStatusEffect(eventPlayer, Status.BURNING, 1)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.ORANGE, eventPlayer, 8)
    wait(1)
    if ruleCondition:
        loop()

rule "[orisa/heat.opy]: heat refresh":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isFiringPrimaryFire() == false
    
    wait(1, Wait.ABORT_WHEN_FALSE)
    chaseAtRate(eventPlayer.Orisa_Heat, 0, 25)
    waitUntil(eventPlayer.isFiringPrimaryFire(), 99999)
    stopChasingVariable(eventPlayer.Orisa_Heat)

rule "[orisa/heat.opy]: reset heat on death":
    @Event playerDied
    @Hero orisa
    
    eventPlayer.Orisa_Heat = 0
    eventPlayer.Orisa_Ammo = 100
    eventPlayer.setPrimaryFireEnabled(true)
    stopChasingVariable(eventPlayer.Orisa_Ammo)
    stopChasingVariable(eventPlayer.Orisa_Heat)
    destroyEffect(eventPlayer.Orisa_ring_effect)
    eventPlayer.Orisa_ring_effect = null