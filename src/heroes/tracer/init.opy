#!mainFile "../../main.opy"

def initTracer():
    @Name "[tracer/init.opy]: initTracer()"
    
    eventPlayer.ult_charge_pvar[1] = 1250
    eventPlayer._base_damage_scalar = 0.964
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer.startScalingSize(0.96)
    eventPlayer.max_health_scaler = 0.857
    eventPlayer.hero_initialized = true


rule "[tracer/init.opy]: Correct melee and Pulse Bomb damage":
    @Event playerDealtDamage
    @Hero tracer
    @Condition eventAbility in [Button.MELEE, Button.ULTIMATE] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar - eventDamage) / eventPlayer._base_damage_scalar)
