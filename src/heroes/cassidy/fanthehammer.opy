#!mainFile "../../../main.opy"

rule "[cassidy/fanthehammer.opy]: Increase Fan the hammer damage to 40":
    @Event playerDealtDamage
    @Hero cassidy
    @Condition eventAbility == Button.SECONDARY_FIRE
    
    damage(victim, attacker, (0.8 * (eventDamage / eventPlayer.macro_pvar[0]) - eventDamage) / eventPlayer.macro_pvar[0])
