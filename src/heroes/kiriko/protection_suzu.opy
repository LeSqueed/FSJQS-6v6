#!mainFile "../../main.opy"

rule "[kiriko/protection_suzu.opy]: correct suzu healing":
    @Event playerDealtHealing
    @Hero kiriko
    @Condition eventAbility == Button.ABILITY_2

    heal(healee, eventPlayer, eventHealing / eventPlayer._base_healing_scalar - eventHealing)