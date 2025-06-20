#!mainFile "../../main.opy"

playervar adaptive_overhealth_id

#!include "grapple.opy"
#!include "shields.opy"
#!include "piledriver.opy"

def initWreckingBall():
    @Name "[wreckingball/init.opy]: initWreckingBall()"
    
    eventPlayer.custom_hp_pvar[0] = 175
    eventPlayer.custom_hp_pvar[1] = 12.5
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1540
    removeTankPassive()
    eventPlayer._base_damage_scalar = 0.788
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer.setAmmo(0, 80)
    eventPlayer.setMaxAmmo(0, 80)
    eventPlayer.max_health_scaler = 0.5
    eventPlayer.hero_initialized = true

rule "[wreckingball/init.opy]: Correct fireball, melee damage":
    @Event playerDealtDamage
    @Hero wreckingBall
    @Condition eventAbility in [Button.ABILITY_1, Button.MELEE] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar - eventDamage) / eventPlayer._base_damage_scalar)
