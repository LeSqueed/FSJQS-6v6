#!mainFile "../main.opy"

rule "[utilities.opy]: destroy all huds and effects between rounds":
    @Event eachPlayer
    @Condition isMatchBetweenRounds() == true

    destroyAllProgressBarInWorldTexts()
    destroyAllInWorldTexts()
    destroyAllEffects()
    destroyAllProgressBarHuds()