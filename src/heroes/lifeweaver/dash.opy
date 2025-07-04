#!mainFile "../../main.opy"

rule "[lifeweaver/dash.opy]: Lose charges":
    @Event eachPlayer
    @Hero lifeweaver
    @Condition eventPlayer.getVerticalSpeed() == false
    @Condition eventPlayer.isOnGround() == false

    wait(0.032, Wait.ABORT_WHEN_FALSE)
    if distance(eventPlayer, eventPlayer + eventPlayer.getVelocity()) >= 8:
        eventPlayer.Lifeweaver_dash_charges--
    else:
        if distance(eventPlayer, raycast(eventPlayer, eventPlayer + eventPlayer.getVelocity(), null, null, true).getHitPosition()) <= 5:
            eventPlayer.Lifeweaver_dash_charges--


rule "[lifeweaver/dash.opy]: Gain charges":
    @Event eachPlayer
    @Hero lifeweaver
    @Condition eventPlayer.Lifeweaver_dash_charges != 2

    wait(6)
    eventPlayer.Lifeweaver_dash_charges++
    if ruleCondition:
        loop()


rule "[lifeweaver/dash.opy]: Disable Dash":
    @Event eachPlayer
    @Hero lifeweaver
    @Condition eventPlayer.Lifeweaver_dash_charges == 0
    @Condition eventPlayer.isInAir() == true

    eventPlayer.disallowButton(Button.JUMP)
    waitUntil(eventPlayer.isOnGround() or eventPlayer.Lifeweaver_dash_charges != 0, Math.INFINITY)
    eventPlayer.allowButton(Button.JUMP)


rule "[lifeweaver/dash.opy]: Silly charge Bug fix":
    @Event eachPlayer
    @Hero lifeweaver
    @Condition eventPlayer.Lifeweaver_dash_charges > 2

    eventPlayer.Lifeweaver_dash_charges = 2


rule "[lifeweaver/dash.opy]: Silly charge Bug fix 2":
    @Event eachPlayer
    @Hero lifeweaver
    @Condition eventPlayer.Lifeweaver_dash_charges < 0

    eventPlayer.Lifeweaver_dash_charges = 0