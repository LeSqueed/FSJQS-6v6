#!mainFile "../../main.opy"

def showAllyBubbleCD():
    @Name "[zarya/ally_bubble.opy]: showAllyBubbleCD()"

    if eventPlayer._zarya_ally_bubble_cd == null:
        createInWorldText(eventPlayer, "{0}".format(ceil(eventPlayer.ally_bubble_cooldown)), updateEveryFrame(eventPlayer.getEyePosition() + (100 * (2.3 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + (-1.9 * (directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 * eventPlayer.getFacingDirection()))), 3)
        eventPlayer._zarya_ally_bubble_cd = getLastCreatedText()
        createInWorldText(eventPlayer, "{0} {1}".format(ceil(eventPlayer.ally_bubble_cooldown), abilityIconString(Hero.ZARYA, Button.ABILITY_2)), updateEveryFrame(eventPlayer.getEyePosition() + (100 * (0.2 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + (-0.48 * (directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 * eventPlayer.getFacingDirection()))), 1.3)
        eventPlayer._zarya_ally_bubble_icon = getLastCreatedText()


def hideAllyBubbleCD():
    @Name "[zarya/ally_bubble.opy]: hideAllyBubbleCD()"

    destroyInWorldText(eventPlayer._zarya_ally_bubble_cd)
    eventPlayer._zarya_ally_bubble_cd = null
    destroyInWorldText(eventPlayer._zarya_ally_bubble_icon)
    eventPlayer._zarya_ally_bubble_icon = null


rule "[zarya/ally_bubble.opy]: OW1 zarya ally bubble cooldown":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.isUsingAbility2() == true

    eventPlayer.setAbilityCharge(Button.ABILITY_2, 2)
    eventPlayer.setAbility2Enabled(false)
    #waitUntil(not eventPlayer.isUsingAbility2(), ADJ_ZARYA_BUBBLE_DURATION) # wait bubble duration
    #wait bubble duration
    wait(2)
    eventPlayer.ally_bubble_cooldown = 8
    chaseAtRate(eventPlayer.ally_bubble_cooldown, 0, 1, ChaseRateReeval.NONE)


rule "[zarya/ally_bubble.opy]: Disable ally bubble if on cooldown":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.ally_bubble_cooldown > 0

    eventPlayer.setAbility2Enabled(false)
    showAllyBubbleCD()


rule "[zarya/ally_bubble.opy]: Enable ally bubble if not on cooldown":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.ally_bubble_cooldown <= 0

    eventPlayer.setAbility2Enabled(true)
    hideAllyBubbleCD()