#!mainFile "../../../main.opy"

playervar is_using_uppercut
playervar uppercut_victims
playervar doom_uppercut_shields
playervar number_of_victims_uppercut

def executeUppercut():
    @Name "[doomfist/uppercut.opy]: Execute main logic for Rising Uppercut ability"
    
    eventPlayer.uppercut_victims = []
    eventPlayer.is_using_uppercut = true
    
    eventPlayer.disablePlayerCollision()
    eventPlayer.disallowButton(Button.MELEE)
    eventPlayer.disallowButton(Button.PRIMARY_FIRE)
    eventPlayer.setSecondaryFireEnabled(false)
    
    eventPlayer.applyImpulse(
        eventPlayer.getVelocity(), 
        -1 * eventPlayer.getSpeed(), 
        Relativity.TO_WORLD, 
        Impulse.INCORPORATE_CONTRARY_MOTION
    )
    
    eventPlayer.applyImpulse(
        vect(eventPlayer.getFacingDirection().x, 0, eventPlayer.getFacingDirection().z), 
        5, 
        Relativity.TO_WORLD, 
        Impulse.INCORPORATE_CONTRARY_MOTION
    )
    
    eventPlayer.setGravity(0)
    eventPlayer.startForcingThrottle(0, 0, 0, 0, 0, 0)
    
    eventPlayer.communicate(Comms.GOODBYE)
    
    wait(0.15)
    eventPlayer.applyImpulse(Vector.UP, 40, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
    wait(0.1)
    eventPlayer.applyImpulse(
        Vector.DOWN, 
        max(0, eventPlayer.getSpeedInDirection(Vector.UP)), 
        Relativity.TO_WORLD, 
        Impulse.INCORPORATE_CONTRARY_MOTION
    )
    
    eventPlayer.is_using_uppercut = false
    wait()
    
    eventPlayer.applyImpulse(Vector.UP, 2.5, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
    eventPlayer.setGravity(0)
    
    eventPlayer.enablePlayerCollision()
    eventPlayer.allowButton(Button.MELEE)
    eventPlayer.allowButton(Button.PRIMARY_FIRE)
    eventPlayer.setSecondaryFireEnabled(true)
    
    wait(0.35)
    eventPlayer.setAbility2Enabled(true)
    eventPlayer.stopForcingThrottle()
    wait(0.15)
    
    eventPlayer.setGravity(50)
    wait(0.25)
    eventPlayer.setGravity(100)

rule "[doomfist/uppercut.opy]: Control flow for Uppercut":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.isUsingAbility2() == true
    
    executeUppercut()


rule "[doomfist/uppercut.opy]: Detect Uppercut Victims":
    @Event eachPlayer
    @Condition any([i.is_using_uppercut == true for i in [player for player in getPlayersInRadius(eventPlayer, 7, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES) if player.getHero() == Hero.DOOMFIST]]) == true
    @Condition angleBetweenVectors(normalize(vect(((([player for player in getPlayersOnHero(Hero.DOOMFIST, getOppositeTeam(eventPlayer.getTeam())) if player.is_using_uppercut == true])[0]).getFacingDirection()).x, 0, ((([player for player in getPlayersOnHero(Hero.DOOMFIST, getOppositeTeam(eventPlayer.getTeam())) if player.is_using_uppercut == true])[0]).getFacingDirection()).z)), directionTowards(([player for player in getPlayersOnHero(Hero.DOOMFIST, getOppositeTeam(eventPlayer.getTeam())) if player.is_using_uppercut == true])[0], eventPlayer)) <= 90
    @Condition eventPlayer in ((([player for player in getPlayersOnHero(Hero.DOOMFIST, getOppositeTeam(eventPlayer.getTeam())) if player.is_using_uppercut == true])[0]).uppercut_victims) == false
    @Condition eventPlayer.Orisa_fortified == null
    
    define doomfistPlayer = ([player for player in getPlayersOnHero(Hero.DOOMFIST, getOppositeTeam(eventPlayer.getTeam())) if player.is_using_uppercut == true])[0]
    
    doomfistPlayer.uppercut_victims.append(eventPlayer)
    damage(eventPlayer, doomfistPlayer, 60 / getPlayersOnHero(Hero.DOOMFIST, getOppositeTeam(eventPlayer.getTeam())).macro_pvar[0])
    playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.WHITE, eventPlayer, 1)
    playEffect(getAllPlayers(), DynamicEffect.EXPLOSION_SOUND, Color.WHITE, eventPlayer, 80)
    
    eventPlayer.applyImpulse(
        eventPlayer.getVelocity(), 
        -1 * eventPlayer.getSpeed(), 
        Relativity.TO_WORLD, 
        Impulse.INCORPORATE_CONTRARY_MOTION
    )
    
    eventPlayer.applyImpulse(
        vect(doomfistPlayer.getFacingDirection().x, 0, doomfistPlayer.getFacingDirection().z), 
        5, 
        Relativity.TO_WORLD
    )
    
    eventPlayer.setGravity(0)
    
    wait(0.15)
    eventPlayer.applyImpulse(Vector.UP, 40, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
    wait(0.1)
    eventPlayer.applyImpulse(
        Vector.DOWN, 
        max(0, eventPlayer.getSpeedInDirection(Vector.UP)), 
        Relativity.TO_WORLD, 
        Impulse.INCORPORATE_CONTRARY_MOTION
    )
    
    wait()
    eventPlayer.applyImpulse(Vector.UP, 2.5, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
    eventPlayer.setGravity(0)
    
    wait(0.35)
    eventPlayer.stopForcingThrottle()
    wait(0.15)
    
    eventPlayer.setGravity(50)
    wait(0.25)
    eventPlayer.setGravity(100)

rule "[doomfist/uppercut.opy]: Shields for Uppercut":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.is_using_uppercut == true
    
    waitUntil(eventPlayer.is_using_uppercut == false, 99999)
    eventPlayer.number_of_victims_uppercut = len(eventPlayer.uppercut_victims)
    eventPlayer.addHealthPool(Health.NORMAL, eventPlayer.number_of_victims_uppercut * 25, false)
    eventPlayer.doom_uppercut_shields = getLastCreatedHealthPool()
