rule "[hazard/spike_guard.opy] Increase damage on block to 230":
    @Event playerDealtDamage
    @Hero hazard
    @Condition eventAbility == Button.SECONDARY_FIRE
    
    damage(victim, attacker, (0.94 * (eventDamage / eventPlayer.macro_pvar[0]) - eventDamage) / eventPlayer.macro_pvar[0])

