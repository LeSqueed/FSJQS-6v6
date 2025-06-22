def showSelfBubbleCD():
    @Name "[zarya/self_bubble.opy]: showSelfBubbleCD()"
    
    if eventPlayer._zarya_self_bubble_cd == null:
        createInWorldText(eventPlayer, "{0}".format(ceil(eventPlayer.self_bubble_cooldown)), updateEveryFrame(eventPlayer.getEyePosition() + (100 * (1.99 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + (-1.9 * (directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 * eventPlayer.getFacingDirection()))), 3)
        eventPlayer._zarya_self_bubble_cd = getLastCreatedText()
        createInWorldText(eventPlayer, "{0} {1}".format(ceil(eventPlayer.self_bubble_cooldown), abilityIconString(Hero.ZARYA, Button.ABILITY_1)), updateEveryFrame(eventPlayer.getEyePosition() + (100 * (0.2 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + (-0.36 * (directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 * eventPlayer.getFacingDirection()))), 1.3)
        eventPlayer._zarya_self_bubble_icon = getLastCreatedText()


def hideSelfBubbleCD():
    @Name "[zarya/self_bubble.opy]: hideSelfBubbleCD()"
    
    destroyInWorldText(eventPlayer._zarya_self_bubble_cd)
    eventPlayer._zarya_ally_bubble_cd = null
    destroyInWorldText(eventPlayer._zarya_self_bubble_icon)
    eventPlayer._zarya_self_bubble_icon = null


rule "[zarya/self_bubble.opy]: OW1 zarya self bubble cooldown":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.isUsingAbility1() == true
    
    eventPlayer.disallowButton(Button.ABILITY_1)
    eventPlayer.setAbilityCharge(Button.ABILITY_1, 2)
    #wait bubble duration
    waitUntil(not eventPlayer.isUsingAbility1(), 2)
    eventPlayer.setAbility1Enabled(false)
    eventPlayer.self_bubble_cooldown = 9
    eventPlayer.allowButton(Button.ABILITY_1)
    chaseAtRate(eventPlayer.self_bubble_cooldown, 0, 1, ChaseRateReeval.NONE)


rule "[zarya/self_bubble.opy]: Disable self bubble if on cooldown":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.self_bubble_cooldown > 0
    
    eventPlayer.setAbility1Enabled(false)
    showSelfBubbleCD()


rule "[zarya/self_bubble.opy]: Enable self bubble if not on cooldown":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.hero_setup == Hero.ZARYA
    @Condition eventPlayer.self_bubble_cooldown <= 0
    
    eventPlayer.setAbility1Enabled(true)
    hideSelfBubbleCD()