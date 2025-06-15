#!mainFile "../../../main.opy"

rule "[brigitte/repair_pack.opy]: Increase Repair Pack healing":
    @Event playerDealtHealing
    @Hero brigitte
    @Condition eventAbility == Button.ABILITY_2
    
    heal(healee, healer, eventHealing * 1.25 - eventHealing)


rule "[brigitte/repair_pack.opy]: Extra Repair Pack burst healing":
    @Event playerDealtHealing
    @Hero brigitte
    @Condition eventAbility == Button.ABILITY_2
    @Condition eventHealing >= 19
    
    heal(healee, healer, 5)
