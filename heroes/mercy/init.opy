#!include "heroes/mercy/valkyrie.opy"

def initMercy():
    @Name "[mercy/init.opy]: initMercy()"
    
    #eventPlayer.custom_hp_pvar[0] = 200
    #eventPlayer.custom_hp_pvar[1] = 0
    #eventPlayer.custom_hp_pvar[2] = 0
    #applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2000
    eventPlayer.macro_pvar[0] = 1.1
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.macro_pvar[1] = 0.917
    eventPlayer.setHealingDealt(100 * eventPlayer.macro_pvar[1])
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
    eventPlayer.setHealingDealt(100 * eventPlayer.macro_pvar[1])


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
