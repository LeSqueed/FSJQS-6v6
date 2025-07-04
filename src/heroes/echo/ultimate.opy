#!mainFile "../../main.opy"

def EchoCopy():
    @Name "[echo/ultimate.opy]: Sub for HUD"

    eventPlayer.EchoUltSeconds = 100
    chaseAtRate(eventPlayer.EchoUltSeconds, 0, 6.25)
    createProgressBarInWorldText(eventPlayer, eventPlayer.EchoUltSeconds, "{0} {1}".format(abilityIconString(Hero.ECHO, Button.ULTIMATE), ceil(eventPlayer.EchoUltSeconds / 6.25)), updateEveryFrame(eventPlayer.getEyePosition() + (100 * (-1 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + (-0.25 * (directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 * eventPlayer.getFacingDirection()))), 0.75)
    eventPlayer._echo_copy_seconds_text = getLastCreatedText()