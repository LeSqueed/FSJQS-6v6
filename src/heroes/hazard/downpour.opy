rule "[hazard/downpour.opy]: hazard reveal enemies":
    @Event playerDealtDamage
    @Hero hazard
    @Condition victim.hasStatus(Status.ROOTED) == true
    @Condition eventAbility == Button.ULTIMATE
    @Condition victim.Hazard_Downpour_Target == null
    
    createInWorldText(eventPlayer, "{0} {1}m".format(abilityIconString(Hero.HAZARD, Button.ULTIMATE), ceil(distance(eventPlayer, victim))), victim + vect(0, 2.5, 0), 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING)
    victim.Hazard_Downpour_effect = getLastCreatedText()
    victim.Hazard_Downpour_Target = true


rule "[hazard/downpour.opy]: hazard reset reveal enemies":
    @Event eachPlayer
    @Condition eventPlayer.Hazard_Downpour_Target == true
    
    wait(2.5)
    destroyInWorldText(eventPlayer.Hazard_Downpour_effect)
    eventPlayer.Hazard_Downpour_Target = null
    eventPlayer.Hazard_Downpour_effect = null