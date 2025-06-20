rule "[hanzo/mark.opy]: Mark enemy play effects":
    @Event eachPlayer
    @Condition eventPlayer.Hanzo_Marked_icon == true
    
    destroyInWorldText(eventPlayer._hanzo_marked_icon)
    eventPlayer._hanzo_marked_icon = null
    createInWorldText(getPlayersOnHero(Hero.HANZO, getOppositeTeam(eventPlayer.getTeam())), iconString(Icon.SKULL), eventPlayer + vect(0, 2.5, 0), 1.2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.RED)
    eventPlayer._hanzo_marked_icon = getLastCreatedText()

rule "[hanzo/mark.opy]: Extra damage on marked enemy":
    @Event playerDealtDamage
    @Hero hanzo
    @Condition victim.Hanzo_Marked_icon == true
    @Condition eventAbility in [Button.PRIMARY_FIRE, Button.ABILITY_1, Button.ULTIMATE] == true
    
    damage(victim, eventPlayer, eventDamage / eventPlayer._base_damage_scalar)


rule "[hanzo/mark.opy]: Mark enemy on damage":
    @Event playerTookDamage
    @Condition eventAbility in [Button.ABILITY_1, Button.PRIMARY_FIRE, Button.ABILITY_2] == true
    @Condition attacker.getHero() == Hero.HANZO
    
    wait(0.1)
    eventPlayer.Hanzo_Marked_icon = true
    wait(8, Wait.RESTART_WHEN_TRUE)
    eventPlayer.Hanzo_Marked_icon = null
    destroyInWorldText(eventPlayer._hanzo_marked_icon)
    eventPlayer._hanzo_marked_icon = null

rule "[hanzo/mark.opy]: On death, remove mark":
    @Event playerDied
    @Hero hanzo
    
    eventPlayer.Hanzo_Marked_icon = null
    destroyInWorldText(eventPlayer._hanzo_marked_icon)
    eventPlayer._hanzo_marked_icon = null