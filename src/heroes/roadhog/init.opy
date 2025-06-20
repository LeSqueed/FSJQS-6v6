#!mainFile "../../main.opy"

playervar Roadhog_vape_target
playervar Roadhog_targeting_hud
playervar Roadhog_vape_confirmed
playervar Roadhog_vape_effect
playervar Roadhog_vape_hud_icon

#!include "heroes/roadhog/pigpen.opy"
#!include "heroes/roadhog/breather.opy"
#!include "heroes/roadhog/wholehog.opy"
#!include "heroes/roadhog/primary.opy"

def initRoadhog():
    @Name "[roadhog/init.opy]: initRoadhog()"
    
    eventPlayer.ult_charge_pvar[1] = 2380
    removeTankPassive()
    eventPlayer._base_damage_scalar = 0.831
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer.setAmmo(0, 6)
    eventPlayer.setMaxAmmo(0, 6)
    eventPlayer.hero_initialized = true

rule "[roadhog/init.opy]: Correct other forms of damage":
    @Event playerDealtDamage
    @Hero roadhog
    @Condition eventAbility in [Button.MELEE, Button.ABILITY_1] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar - eventDamage) / eventPlayer._base_damage_scalar)


rule "[roadhog/init.opy]: Clean up Roadhog":
    @Event eachPlayer
    @Condition eventPlayer.hero_setup != Hero.ROADHOG
    
    eventPlayer.Roadhog_vape_target = null
    destroyInWorldText(eventPlayer.Roadhog_targeting_hud)
