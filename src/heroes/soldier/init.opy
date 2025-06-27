#!mainFile "../../main.opy"

def initSoldier():
    @Name "[soldier/init.opy]: initSoldier()"
    

    eventPlayer.ult_charge_pvar[1] = 2310
    eventPlayer._base_healing_scalar = 0.875
    eventPlayer.setHealingDealt(100 * eventPlayer._base_healing_scalar)
    eventPlayer.setAmmo(0, 30)
    eventPlayer.setMaxAmmo(0, 30)
    eventPlayer._max_health_scalar = HeroHealthPercentage.SOLDIER / 100
    eventPlayer.hero_initialized = true


rule "[soldier/init.opy]: Increase Heavy Pulse Rifle damage":
    @Event playerDealtDamage
    @Hero soldier
    @Condition eventAbility == Button.PRIMARY_FIRE
    
    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar * 1.053 - eventDamage) / eventPlayer._base_damage_scalar)