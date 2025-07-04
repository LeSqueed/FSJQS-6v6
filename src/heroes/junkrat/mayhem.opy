#!mainFile "../../main.opy"

rule "[junkrat/mayhem.opy]: Correct Frag Launcher damage":
    @Event playerDealtDamage
    @Hero junkrat
    @Condition eventAbility == Button.PRIMARY_FIRE

    #damage(victim, attacker, ((eventDamage/eventPlayer._base_damage_scalar)*(ADJ_JUNKRAT_FRAG_DAMAGE/OW2_JUNKRAT_FRAG_DAMAGE) - eventDamage)/eventPlayer._base_damage_scalar)
    heal(victim, null, (eventDamage / eventPlayer._base_damage_scalar * 0.8 - eventDamage) * -1)


rule "[junkrat/mayhem.opy]: Correct Junkrat Melee damage":
    @Event playerDealtDamage
    @Hero junkrat
    @Condition eventAbility == Button.MELEE

    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar - eventDamage) / eventPlayer._base_damage_scalar)


rule "[junkrat/mayhem.opy]: Correct Junkrat Trap damage":
    @Event playerDealtDamage
    @Hero junkrat
    @Condition eventAbility == Button.ABILITY_2

    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar * 0.9 - eventDamage) / eventPlayer._base_damage_scalar)


rule "[junkrat/mayhem.opy]: Reset damage for Rip-Tire":
    @Event eachPlayer
    @Hero junkrat
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE) == true
    @Condition eventPlayer.isOnGround() == true
    @Condition eventPlayer.getUltCharge() >= 100

    eventPlayer.setDamageDealt(100)
    eventPlayer.allowButton(Button.ULTIMATE)
    eventPlayer.forceButtonPress(Button.ULTIMATE)
    eventPlayer.disallowButton(Button.ULTIMATE)
    wait(1)
    #revert damage back after Rip-Tire is deployed
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)