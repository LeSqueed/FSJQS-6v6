#!mainFile "../../main.opy"

rule "[sombra/emp.opy]: Heal damage EMP does and prevent extra hack time from triggering":
    @Event playerDealtDamage
    @Hero sombra
    @Condition eventAbility == Button.ULTIMATE

    heal(victim, null, eventDamage)
    wait(3)
    victim.clearStatusEffect(Status.HACKED)