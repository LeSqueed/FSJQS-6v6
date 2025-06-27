#!mainFile "../../main.opy"

playervar MercyMomentum
playervar Overloaded
playervar MercyOverloadFx
playervar MercyOverloadSfx
playervar MercyUltTrack
playervar Mercy_Rez_charges
playervar RezTarget

#!include "valkyrie.opy"
#!include "momentum.opy"
#!include "resurrect.opy"

def initMercy():
    @Name "[mercy/init.opy]: initMercy()"
    eventPlayer.ult_charge_pvar[1] = 2000
    eventPlayer._base_damage_scalar = 1.1
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer._base_healing_scalar = 1.25
    eventPlayer.setHealingDealt(100 * eventPlayer._base_healing_scalar)
    eventPlayer.setAmmo(0, 20)
    eventPlayer.setMaxAmmo(0, 20)
    eventPlayer.setAbility2Enabled(false)
    eventPlayer.hero_initialized = true
    eventPlayer.MercyMomentum = 100

    createProgressBarInWorldText(eventPlayer, eventPlayer.MercyMomentum, "Momentum", updateEveryFrame(eventPlayer.getEyePosition() + (100 * (-0.7 * (directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 120)) + 3 * eventPlayer.getFacingDirection()))), 0.7, Clip.NONE, Color.ORANGE, Color.ORANGE)
    eventPlayer._mercy_momentum_bar = getLastCreatedText()

rule "[mercy/init.opy]: Reduce Valkyrie healing and force self-healing":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.isUsingUltimate() == true
    eventPlayer.stopAllHealingOverTime()
    eventPlayer.startHealingOverTime(null, 15, 20)
    heal(eventPlayer, null, 50)
    eventPlayer.setHealingDealt(138.462)
    wait(2)
    eventPlayer.setHealingDealt(92.308)
    waitUntil(not eventPlayer.isUsingUltimate(), Math.INFINITY)
    eventPlayer.setHealingDealt(100 * eventPlayer._base_healing_scalar)

rule "[mercy/init.opy]: Mercy swap hero":
    @Event eachPlayer
    @Condition eventPlayer.getHero() != Hero.MERCY
    @Condition eventPlayer.hasSpawned() == true
    eventPlayer.allowButton(Button.ULTIMATE)
    eventPlayer.allowButton(Button.ABILITY_2)
    eventPlayer._mercy_momentum_bar = null
    destroyHudText(eventPlayer._mercy_rez_hud)
    destroyInWorldText(eventPlayer._mercy_momentum_bar)
    destroyEffect(eventPlayer.MercyOverloadFx)
    destroyEffect(eventPlayer.MercyOverloadSfx)
    eventPlayer.MercyMomentum = null
    eventPlayer.MercyOverloadFx = null
    eventPlayer.MercyOverloadSfx = null
    eventPlayer.Overloaded = false
    eventPlayer._mercy_rez_hud = null
    eventPlayer.MercyUltTrack = null
    
