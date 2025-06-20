rule "[juno/orbital_ray.opy]: Adjust Orbital Ray Healing":
    @Event eachPlayer
    @Hero juno
    @Condition eventPlayer.isUsingUltimate() == true
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.hasStatus(Status.ASLEEP) == false
    @Condition eventPlayer.hasStatus(Status.FROZEN) == false
    @Condition eventPlayer.hasStatus(Status.KNOCKED_DOWN) == false
    @Condition eventPlayer.hasStatus(Status.STUNNED) == false
    
    wait(0.469)
    eventPlayer.orbital_ray_x = (eventPlayer.getPosition() + 1.625 * directionFromAngles(eventPlayer.getHorizontalFacingAngle(), 0)).x
    eventPlayer.orbital_ray_z = (eventPlayer.getPosition() + 1.625 * directionFromAngles(eventPlayer.getHorizontalFacingAngle(), 0)).z
    eventPlayer.orbital_ray_final_x = (eventPlayer.getPosition() + 24.125 * directionFromAngles(eventPlayer.getHorizontalFacingAngle(), 0)).x
    eventPlayer.orbital_ray_final_z = (eventPlayer.getPosition() + 24.125 * directionFromAngles(eventPlayer.getHorizontalFacingAngle(), 0)).z
    chaseOverTime(eventPlayer.orbital_ray_x, eventPlayer.orbital_ray_final_x, 10, ChaseTimeReeval.NONE)
    chaseOverTime(eventPlayer.orbital_ray_z, eventPlayer.orbital_ray_final_z, 10, ChaseTimeReeval.NONE)
    #createBeam(eventPlayer, Beam.GOOD, vect(eventPlayer.orbital_ray_x, 0.0, eventPlayer.orbital_ray_z), vect(eventPlayer.orbital_ray_x, 100.0, eventPlayer.orbital_ray_z), Color.WHITE, EffectReeval.POSITION_AND_RADIUS)
    while eventPlayer.isUsingUltimate():
        ([player for player in getLivingPlayers(eventPlayer.getTeam()) if distance(vect(eventPlayer.orbital_ray_x, 0, eventPlayer.orbital_ray_z), vect(player.getPosition().x, 0, player.getPosition().z)) < 8 and player.getHealth() < player.getMaxHealth() and player.remainingAntiDuration <= 0]).startDamageOverTime(null, 0.098, 19)
        wait(0.098)
