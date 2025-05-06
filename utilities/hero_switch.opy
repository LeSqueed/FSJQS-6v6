#!mainFile "../main.opy"

playervar hero_setup
playervar hero_switch_pvar
#!defineMember _last_hero_played hero_switch_pvar[0]
#!defineMember _hero_switched hero_switch_pvar[1]

#!define switchedHero(player) player._hero_switched

#!include "utilities/hero_reset.opy"
#!include "utilities/hero_init.opy"

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
    
    waitUntil(eventPlayer.hasSpawned(), 999999986991104)
    waitUntil(not eventPlayer.hero_switch_pvar[1], 999999986991104)
    eventPlayer.hero_setup = eventPlayer.getHero()
    resetHero()
    initHero()


rule "[utilities/hero_switch.opy]: Reinitialize hero on new round":
    @Event eachPlayer
    @Condition isMatchBetweenRounds() == true
    
    waitUntil(not isMatchBetweenRounds(), 999999986991104)
    resetHero()
    initHero()
