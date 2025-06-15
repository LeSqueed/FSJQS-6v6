rule "[torbjorn/turret.opy]: turret damage increase":
    @Event playerDealtDamage
    @Hero torbjorn
    @Condition Button.ABILITY_1 == eventAbility
    
    damage(victim, eventPlayer, 1 / eventPlayer.macro_pvar[0])