#!mainFile "../../main.opy"

rule "[junkrat/trap.opy]: junkrat reveal enemies":
    @Event playerDealtDamage
    @Hero junkrat
    @Condition victim.hasStatus(Status.ROOTED) == true
    @Condition eventAbility == Button.ABILITY_2
    @Condition victim.Junkrat_Trap_target == null

    createInWorldText(getPlayers(eventPlayer.getTeam()), "{0} {1}m".format(abilityIconString(Hero.JUNKRAT, Button.ABILITY_2), ceil(distance(eventPlayer, victim))), victim + vect(0, 2.5, 0), 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING)
    victim.Junkrat_Trap_effect = getLastCreatedText()
    victim.Junkrat_Trap_target = true


rule "[junkrat/trap.opy]: junkrat reset reveal enemies":
	@Event eachPlayer
	@Condition eventPlayer.Junkrat_Trap_target

    wait(2.500)
    destroyInWorldText(eventPlayer.Junkrat_Trap_effect)
    eventPlayer.Junkrat_Trap_target = null
    eventPlayer.Junkrat_Trap_effect = null