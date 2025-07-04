#!mainFile "../../main.opy"

rule "[sigma/kinetic_grasp.opy]: Reduce Kinetic Grasp overhealth":
    @Event eachPlayer
    @Hero sigma
    @Condition eventPlayer.isUsingAbility1() == true

    wait(1.2, Wait.ABORT_WHEN_FALSE)
    eventPlayer.hp_exiting_grasp = eventPlayer.getHealth()
    waitUntil(not eventPlayer.isUsingAbility1(), Math.INFINITY)
    damage(eventPlayer, null, 0.3 * (eventPlayer.getHealth() - eventPlayer.hp_exiting_grasp))
