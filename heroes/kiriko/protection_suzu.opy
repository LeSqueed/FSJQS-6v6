rule "[kiriko/protection_suzu.opy]: correct suzu healing":
    @Event playerDealtHealing
    @Hero kiriko
    @Condition eventAbility == Button.ABILITY_2
    
    heal(healee, eventPlayer, eventHealing / eventPlayer.macro_pvar[1] - eventHealing)