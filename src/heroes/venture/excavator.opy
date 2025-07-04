#!mainFile "../../main.opy"

rule "[venture/excavator.opy]: Prepare Smart Excavator damage increase":
    @Event eachPlayer
    @Hero venture
    @Condition eventPlayer.isFiringPrimaryFire() == true

    eventPlayer.is_firing_excavator = true
    wait(0.3)
    eventPlayer.is_firing_excavator = false


rule "[venture/excavator.opy]: Correct Smart Excavator damage":
    @Event playerDealtDamage
    @Hero venture
    @Condition eventPlayer.is_firing_excavator != false
    @Condition eventPlayer.isUsingAbility1() == false

    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar * 0.8 - eventDamage) / eventPlayer._base_damage_scalar)
    eventPlayer.is_firing_excavator = false
