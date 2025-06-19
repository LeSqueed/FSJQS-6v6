rule "[doomfist/punch.opy]: Initialize rocket punch":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.isFiringSecondaryFire() == true
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true
    
    eventPlayer.macro_pvar[0] = 0.5
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.punched_victims = []
    eventPlayer.wall_impacted_victims = []
    waitUntil(not eventPlayer.isFiringSecondaryFire(), 4)
    wait(0.2)
    eventPlayer.macro_pvar[0] = 0.8
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])


rule "[doomfist/punch.opy]: Find wall impacted victims":
    @Event playerDealtDamage
    @Hero doomfist
    @Condition eventAbility == Button.SECONDARY_FIRE
    @Condition victim in attacker.punched_victims == true
    @Condition victim in attacker.wall_impacted_victims == false
    
    attacker.wall_impacted_victims.append(victim)
    victim.clearStatusEffect(Status.STUNNED)
    #OW1 single punch victim
    if len(attacker.punched_victims) == 1:
        damage(victim, attacker, (eventDamage / attacker.macro_pvar[0] - eventDamage) / attacker.macro_pvar[0])
    else:
        # Multiple punch victims, do nothing special


rule "[doomfist/punch.opy]: Find punched victims":
    @Event playerDealtDamage
    @Hero doomfist
    @Condition eventAbility == Button.SECONDARY_FIRE
    @Condition victim in attacker.punched_victims == false
    
    attacker.punched_victims.append(victim)
    #OW1 single punch victim
    if len(attacker.punched_victims) == 1:
        damage(victim, attacker, (eventDamage / attacker.macro_pvar[0] - eventDamage) / attacker.macro_pvar[0])
    else:
        # Multiple punch victims, do nothing special
