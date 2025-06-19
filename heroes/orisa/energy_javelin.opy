rule "[orisa/energy_javelin.opy]: Increase damage from 60 to 65":
    @Event playerDealtDamage
    @Hero orisa
    @Condition eventAbility == Button.SECONDARY_FIRE
    
    damage(victim, eventPlayer, 5)