#!mainFile "../../main.opy"

rule "[sojourn/ultimate.opy] 200 damage in ult":
    @Event playerDealtDamage
    @Hero sojourn
    @Condition eventPlayer.isUsingUltimate() == true
    @Condition eventAbility == Button.ULTIMATE

    if eventWasCriticalHit:
        damage(victim, eventPlayer, eventDamage * 0.4)