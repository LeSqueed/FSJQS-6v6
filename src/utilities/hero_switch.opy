rule "[utilities/hero_switch.opy]: detect hero switch":
    @Event eachPlayer
    @Condition eventPlayer.hero_switch_pvar[0] != eventPlayer.getHero()
    
    eventPlayer.hero_switch_pvar[1] = true
    wait()
    eventPlayer.hero_switch_pvar[0] = eventPlayer.getHero()
    #eventPlayer._hero_id = heroID(eventPlayer._last_hero_played)
    eventPlayer.hero_switch_pvar[1] = false

rule "[utilities/hero_switch.opy]: Initialize hero on hero switch":
    @Event eachPlayer
    @Condition eventPlayer.hero_switch_pvar[1] != false
    
    waitUntil(eventPlayer.hasSpawned(), Math.INFINITY)
    waitUntil(not eventPlayer.hero_switch_pvar[1], Math.INFINITY)
    eventPlayer.hero_setup = eventPlayer.getHero()
    resetHero()
    initHero()


rule "[utilities/hero_switch.opy]: Reinitialize hero on new round":
    @Event eachPlayer
    @Condition isMatchBetweenRounds() == true
    
    waitUntil(not isMatchBetweenRounds(), Math.INFINITY)
    resetHero()
    initHero()