rule "[venture/tectonic_shock.opy]: Tectonic Shock logic":
    @Event playerDealtDamage
    @Hero venture
    @Condition eventAbility == Button.ULTIMATE
    
    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar * 0.73 - eventDamage) / eventPlayer._base_damage_scalar)
    victim.applyImpulse(Vector.UP, 8, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.setStatusEffect(null, Status.ROOTED, 0.3)
