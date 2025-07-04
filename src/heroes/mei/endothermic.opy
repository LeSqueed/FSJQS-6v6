#!mainFile "../../main.opy"

rule "[mei/endothermic.opy]: AOE Damage Mei":
    @Event playerDealtDamage
    @Hero mei
    @Condition eventAbility == Button.SECONDARY_FIRE
    @Disabled

    playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.SKY_BLUE, victim, 2)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.AQUA, victim, 5)
    playEffect(getAllPlayers(), DynamicEffect.DEBUFF_IMPACT_SOUND, Color.SKY_BLUE, eventPlayer, 40)
    damage(getPlayersInRadius(victim, 5, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES_AND_ENEMY_BARRIERS), attacker, 25)
