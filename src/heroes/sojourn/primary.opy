#!mainFile "../../main.opy"

rule "[sojourn/primary.opy] Increased primary damage":
    @Event playerDealtDamage
    @Hero sojourn
    @Condition eventAbility == Button.PRIMARY_FIRE

    if eventWasCriticalHit:
        damage(victim, eventPlayer, 3)
    else:
        damage(victim, eventPlayer, 1.5)
