#!mainFile "../../main.opy"

playervar RezHUD
playervar RezTarget
playervar ImbueTargetIcon
playervar ImbueTarget
playervar ImbueAOERing
playervar ImbueAOESound
playervar ImbueBeam
playervar ImbueSparkle
playervar ImbueDuration
playervar ImbueSecondary
playervar MercyUltTrack
playervar Mercy_Rez_charges

#!include "heroes/mercy/valkyrie.opy"
#!include "heroes/mercy/resurrect.opy"
#!include "heroes/mercy/imbue.opy"

def initMercy():
    @Name "[mercy/init.opy]: initMercy()"
    
    eventPlayer.ult_charge_pvar[1] = 2000
    eventPlayer._base_damage_scalar = 1.1
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer._base_healing_scalar = 0.917
    eventPlayer.setHealingDealt(100 * eventPlayer._base_healing_scalar)
    eventPlayer.setAmmo(0, 20)
    eventPlayer.setMaxAmmo(0, 20)
    eventPlayer.setAbility2Enabled(false)
    eventPlayer.hero_initialized = true

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
    waitUntil(not eventPlayer.isUsingUltimate(), 999999986991104)
    eventPlayer.setHealingDealt(100 * eventPlayer._base_healing_scalar)


rule "[mercy/init.opy]: Mercy swap hero":
    @Event eachPlayer
    @Condition eventPlayer.getHero() != Hero.MERCY
    @Condition eventPlayer.hasSpawned() == true
    
    eventPlayer.allowButton(Button.ULTIMATE)
    destroyHudText(eventPlayer.RezHUD)
    destroyInWorldText(eventPlayer.ImbueTargetIcon)
    eventPlayer.MercyUltTrack = 0
    destroyEffect(eventPlayer.ImbueAOERing)
    destroyEffect(eventPlayer.ImbueAOESound)
    destroyEffect(eventPlayer.ImbueBeam)
    destroyEffect(eventPlayer.ImbueSparkle)
    eventPlayer.ImbueTargetIcon = null
    eventPlayer.RezHUD = null
    eventPlayer.ImbueTarget = null
