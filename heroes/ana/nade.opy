rule "[ana/nade.opy]: Increase Biotic Grenade damage":
    @Event playerDealtDamage
    @Hero ana
    @Condition eventAbility == Button.ABILITY_2
    
    damage(victim, attacker, (0.8 * (eventDamage / eventPlayer.macro_pvar[0]) - eventDamage) / eventPlayer.macro_pvar[0])


rule "[ana/nade.opy]: Increase Biotic Grenade healing":
    @Event playerDealtHealing
    @Hero ana
    @Condition eventAbility == Button.ABILITY_2
    
    heal(healee, healer, eventHealing * 1.334 / eventPlayer.macro_pvar[1] - eventHealing)
