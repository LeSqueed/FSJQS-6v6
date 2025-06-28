rule "[mercy/ressurect.opy]: Mercy rez":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.isUsingUltimate() == true
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE) == true
    @Condition eventPlayer.isAlive() == true
    @Condition len(getPlayersInRadius(eventPlayer, 5.5, eventPlayer.getTeam(), LosCheck.SURFACES).exclude(getLivingPlayers(Team.ALL))) > 0
    @Condition eventPlayer.Mercy_Rez_charges == 1
    
    eventPlayer.MercyUltTrack = 0
    eventPlayer.setUltCharge(0)
    destroyHudText(eventPlayer._mercy_rez_hud)
    eventPlayer._mercy_rez_hud = null
    eventPlayer.communicate(Comms.HELLO)
    #Set rez target
    eventPlayer.RezTarget = sorted(getPlayersInRadius(eventPlayer, 5.5, eventPlayer.getTeam(), LosCheck.SURFACES).exclude(getLivingPlayers(eventPlayer.getTeam())), lambda i: angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer, i)))[0]
    #Show rez in killfeed (skews mercy's elims and target's deaths by 1, but whatever)
    eventPlayer.RezTarget.resurrect()
    eventPlayer.RezTarget.setStatusEffect(null, Status.PHASED_OUT, 0.1)
    eventPlayer.RezTarget.setHealth(0.01)
    kill(eventPlayer.RezTarget, eventPlayer)
    wait()
    #Real rez
    eventPlayer.RezTarget.resurrect()
    eventPlayer.RezTarget.setStatusEffect(null, Status.PHASED_OUT, 2.25)
    eventPlayer.RezTarget.setStatusEffect(null, Status.FROZEN, 1.5)
    eventPlayer.RezTarget.setHealth(eventPlayer.RezTarget.getMaxHealth())
    playEffect(getAllPlayers(), DynamicEffect.GOOD_PICKUP_EFFECT, Color.YELLOW, eventPlayer.RezTarget, 5)
    playEffect(getAllPlayers(), DynamicEffect.BUFF_IMPACT_SOUND, Color.WHITE, eventPlayer.RezTarget, 110)
    eventPlayer.RezTarget.setAmmo(0, eventPlayer.RezTarget.getMaxAmmo())
    eventPlayer.RezTarget.setAmmo(1, eventPlayer.RezTarget.getMaxAmmo(1))
    #0.75s recovery
    eventPlayer.disallowButton(Button.PRIMARY_FIRE)
    eventPlayer.disallowButton(Button.SECONDARY_FIRE)
    eventPlayer.disallowButton(Button.MELEE)
    eventPlayer.disallowButton(Button.ABILITY_2)
    #Disable target abilities for 0.75s movement window in invuln
    eventPlayer.RezTarget.disallowButton(Button.ABILITY_1)
    eventPlayer.RezTarget.disallowButton(Button.ABILITY_2)
    eventPlayer.RezTarget.disallowButton(Button.PRIMARY_FIRE)
    eventPlayer.RezTarget.disallowButton(Button.SECONDARY_FIRE)
    eventPlayer.RezTarget.disallowButton(Button.ULTIMATE)
    eventPlayer.RezTarget.disallowButton(Button.MELEE)
    #End recovery
    wait(0.5)
    eventPlayer.allowButton(Button.PRIMARY_FIRE)
    eventPlayer.allowButton(Button.SECONDARY_FIRE)
    eventPlayer.allowButton(Button.MELEE)
    eventPlayer.allowButton(Button.ABILITY_2)
    #End of target invuln, enable abilities
    wait(1.75)
    eventPlayer.RezTarget.allowButton(Button.ABILITY_1)
    eventPlayer.RezTarget.allowButton(Button.ABILITY_2)
    eventPlayer.RezTarget.allowButton(Button.PRIMARY_FIRE)
    eventPlayer.RezTarget.allowButton(Button.SECONDARY_FIRE)
    eventPlayer.RezTarget.allowButton(Button.ULTIMATE)
    eventPlayer.RezTarget.allowButton(Button.MELEE)
    eventPlayer.RezTarget = null
    eventPlayer.Mercy_Rez_charges = null

rule "[mercy/ressurect.opy]: Mercy rez HUD":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.isUsingUltimate() == true
    @Condition eventPlayer._mercy_rez_hud == null
    @Condition eventPlayer.isUsingUltimate() == true
    @Condition eventPlayer.Mercy_Rez_charges == 1
    
    hudHeader(eventPlayer if eventPlayer.isAlive() and len(getPlayersInRadius(eventPlayer, 5.5, eventPlayer.getTeam(), LosCheck.SURFACES).exclude(getLivingPlayers(Team.ALL))) > 0 else null, "Resurrect {0}".format(heroIcon(sorted(getPlayersInRadius(eventPlayer, 5.5, eventPlayer.getTeam(), LosCheck.SURFACES).exclude(getLivingPlayers(eventPlayer.getTeam())), lambda i: angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer, i)))[0].getHero())), HudPosition.TOP, 0, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING)
    eventPlayer._mercy_rez_hud = getLastCreatedText()
