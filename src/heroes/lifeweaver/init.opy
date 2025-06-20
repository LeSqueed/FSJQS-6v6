#!mainFile "../../main.opy"

playervar Lifeweaver_healing_cd
playervar Lifeweaver_healing_hud
playervar Lifeweaver_dash_charges
playervar Lifeweaver_petal_charges

#!include "healing.opy"
#!include "petalplatform.opy"
#!include "dash.opy"
#!include "grasp.opy"

def initLifeweaver():
    @Name "[lifeweaver/init.opy]: Initialize Lifeweaver"
    
    eventPlayer.custom_hp_pvar[0] = 37.5
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 25
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2000
    eventPlayer._base_damage_scalar = 1.25
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    createInWorldText(eventPlayer, "{0}".format(ceil(eventPlayer.Lifeweaver_petal_charges)), updateEveryFrame(eventPlayer.getEyePosition() + (100 * (1.92 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + (-2.05 * (directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 * eventPlayer.getFacingDirection()))), 3)
    eventPlayer._lifeweaver_petal_charges_text = getLastCreatedText()
    createInWorldText(eventPlayer, "{0}".format(ceil(eventPlayer.Lifeweaver_dash_charges)), updateEveryFrame(eventPlayer.getEyePosition() + (100 * (2.535 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + (-2.05 * (directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 * eventPlayer.getFacingDirection()))), 3)
    eventPlayer._lifeweaver_dash_charges_text = getLastCreatedText()
    createInWorldText(eventPlayer, "{0} {1}".format(ceil(eventPlayer.Lifeweaver_petal_charges), abilityIconString(Hero.LIFEWEAVER, Button.ABILITY_1)), updateEveryFrame(eventPlayer.getEyePosition() + (100 * (-0.22 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + (-0.6 * (directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 * eventPlayer.getFacingDirection()))), 1.3)
    eventPlayer._lifeweaver_petal_charges_icon = getLastCreatedText()
    createInWorldText(eventPlayer, "{0} {1}".format(ceil(eventPlayer.Lifeweaver_dash_charges), abilityIconString(Hero.LIFEWEAVER, Button.JUMP)), updateEveryFrame(eventPlayer.getEyePosition() + (100 * (0.22 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + (-0.6 * (directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 * eventPlayer.getFacingDirection()))), 1.3)
    eventPlayer._lifeweaver_dash_charges_icon = getLastCreatedText()
    eventPlayer.Lifeweaver_petal_charges = 2
    eventPlayer.Lifeweaver_dash_charges = 2
    eventPlayer.setMaxAmmo(0, 5)
    eventPlayer.setAmmo(0, 5)
    eventPlayer.hero_initialized = true


rule "[lifeweaver/init.opy]: Reduce Lifeweaver melee damage":
    @Event playerDealtDamage
    @Hero lifeweaver
    @Condition eventAbility == Button.MELEE
    
    heal(victim, null, eventDamage - eventDamage / eventPlayer._base_damage_scalar)


rule "[lifeweaver/init.opy]: Reduce Tree of Life duration":
    @Event eachPlayer
    @Hero lifeweaver
    @Condition eventPlayer.isUsingUltimate() == true
    
    wait(11)
    eventPlayer.forceButtonPress(Button.ULTIMATE)

rule "[lifeweaver/init.opy]: Clean up lifeweaver":
    @Event eachPlayer
    @Condition eventPlayer.hero_setup != Hero.LIFEWEAVER
    
    destroyInWorldText(eventPlayer._lifeweaver_petal_charges_text)
    destroyInWorldText(eventPlayer._lifeweaver_dash_charges_text)
    destroyInWorldText(eventPlayer._lifeweaver_petal_charges_icon)
    destroyInWorldText(eventPlayer._lifeweaver_dash_charges_icon)

