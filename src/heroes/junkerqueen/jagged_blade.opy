#!mainFile "../../main.opy"

rule "[junkerqueen/jagged_blade.opy]: Correct Jagged Blade impact damage":
    @Event playerDealtDamage
    @Hero junkerQueen
    @Condition eventDamage == 65 * eventPlayer._base_damage_scalar

    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar - eventDamage) / eventPlayer._base_damage_scalar)


rule "[junkerqueen/jagged_blade.opy]: Increase Jagged Blade pull distance on squishies":
    @Event playerDealtKnockback
    @Hero junkerQueen
    @Condition eventPlayer.isMeleeing() == false
    @Condition victim.getHero() in getTankHeroes() == false

    victim.applyImpulse(vect((normalize(eventPlayer.getPosition() - victim.getPosition())).x, 0, (normalize(eventPlayer.getPosition() - victim)).z), 7.5, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)

