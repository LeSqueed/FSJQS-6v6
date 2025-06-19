#!include "heroes/orisa/energy_javelin.opy"
#!include "heroes/orisa/terra_surge.opy"
#!include "heroes/orisa/fortify.opy"
#!include "heroes/orisa/spin.opy"
#!include "heroes/orisa/heat.opy"

def initOrisa():
    @Name "[orisa/init.opy]: initOrisa()"
    
    eventPlayer.custom_hp_pvar[0] = 121
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1814
    removeTankPassive()
    eventPlayer.macro_pvar[0] = 0.858
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.setKnockbackDealt(82)
    eventPlayer.Orisa_Ammo = 100
    createProgressBarInWorldText(eventPlayer, eventPlayer.Orisa_heat, "Heat", updateEveryFrame(eventPlayer.getEyePosition() + (100 * (-0.7 * (directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90)) + 3 * eventPlayer.getFacingDirection()))), 0.7, Clip.NONE, Color.ORANGE, Color.ORANGE)
    eventPlayer.Orisa_Heat_HUD = getLastCreatedText()
    createInWorldText(eventPlayer, "{0}".format(ceil(eventPlayer.Orisa_Ammo)), updateEveryFrame(eventPlayer.getEyePosition() + (100 * (3.35 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + (-1.5 * (directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 * eventPlayer.getFacingDirection()))), 2)
    eventPlayer.Orisa_Ammo_HUD = getLastCreatedText()
    #if not eventPlayer.isDuplicatingAHero():
    #setBaseDamage(eventPlayer, ADJ_ORISA_JAVELIN_DIRECT_DAMAGE / OW2_ORISA_JAVELIN_DIRECT_DAMAGE)
    eventPlayer.balance_change_check = true
    eventPlayer.hero_initialized = true


rule "[orisa/init.opy]: Correct Orisa Spin, Melee damage":
    @Event playerDealtDamage
    @Hero orisa
    @Condition eventAbility in [Button.ABILITY_1, Button.ABILITY_2, Button.MELEE] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[orisa/init.opy]: Correct Orisa Javelin damage":
    @Event playerDealtDamage
    @Hero orisa
    @Condition eventAbility == Button.SECONDARY_FIRE
    
    damage(victim, attacker, (0.929 * (eventDamage / eventPlayer.macro_pvar[0]) - eventDamage) / eventPlayer.macro_pvar[0])

rule "[orisa/init.opy]: Clean up Orisa":
    @Event eachPlayer
    @Condition eventPlayer.hero_setup != Hero.ORISA
    
    destroyEffect(eventPlayer.Orisa_ring_effect)
    eventPlayer.Orisa_Ammo = null
    destroyProgressBarInWorldText(eventPlayer.Orisa_Heat_HUD)
    destroyInWorldText(eventPlayer.Orisa_Ammo_HUD)
