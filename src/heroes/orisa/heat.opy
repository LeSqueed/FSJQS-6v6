#!mainFile "../../main.opy"

rule "[orisa/heat.opy]: subtract ammo generate heat":
    @Event eachPlayer
    @Hero orisa
    @Condition updateEveryFrame(eventPlayer.isFiringPrimaryFire()) == true

    eventPlayer.Orisa_Ammo--
    wait(0.1)
    if ruleCondition:
        loop()


rule "[orisa/heat.opy]: ammo refresh":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.Orisa_Ammo <= 0

    eventPlayer.setAmmo(0, 0)
    chaseAtRate(eventPlayer.Orisa_Ammo, 80, 33)
    eventPlayer.setPrimaryFireEnabled(false)
    wait(1)
    waitUntil(eventPlayer.Orisa_Ammo >= 80, Math.INFINITY)
    eventPlayer.setPrimaryFireEnabled(true)
    stopChasingVariable(eventPlayer.Orisa_Ammo)


rule "[orisa/heat.opy]: reload":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isHoldingButton(Button.RELOAD) == true

    eventPlayer.Orisa_Ammo = 0


rule "[orisa/heat.opy]: burn during fortify":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isUsingAbility1() == true

    (getPlayersInRadius(eventPlayer + Vector.UP, 8, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES_AND_ENEMY_BARRIERS)).startDamageOverTime(eventPlayer, 1, 20 / eventPlayer._base_damage_scalar)
    getPlayersInRadius(eventPlayer, 8, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES).setStatusEffect(eventPlayer, Status.BURNING, 1)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.ORANGE, eventPlayer, 8)
    wait(1)
    if ruleCondition:
        loop()


rule "[orisa/heat.opy]: reset heat on death":
    @Event playerDied
    @Hero orisa

    eventPlayer.Orisa_Ammo = 100
    eventPlayer.setPrimaryFireEnabled(true)
    stopChasingVariable(eventPlayer.Orisa_Ammo)
    destroyEffect(eventPlayer.Orisa_ring_effect)
    eventPlayer.Orisa_ring_effect = null