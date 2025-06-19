rule "[reinhardt/firestrike.opy]: Force single firestrike":
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer.isUsingAbility2() == true
    
    waitUntil(not eventPlayer.isUsingAbility2(), 0.9)
    #Every time rein uses firestrike, reset the resource to 0
    eventPlayer.setAbilityCharge(Button.ABILITY_2, 0)
    wait(6)
    eventPlayer.setAbilityCharge(Button.ABILITY_2, 2)

rule "[reinhardt/firestrike.opy]: decrease Firestrike damage (early animation)":
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer.isUsingAbility2() == true
    
    eventPlayer.setDamageDealt(83.333)
    wait(1)
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])