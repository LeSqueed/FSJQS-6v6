#!include "heroes/roadhog/pigpen.opy"
#!include "heroes/roadhog/breather.opy"
#!include "heroes/roadhog/wholehog.opy"

def initRoadhog():
    @Name "[roadhog/init.opy]: initRoadhog()"
    
    #eventPlayer.custom_hp_pvar[0] = 550
    #eventPlayer.custom_hp_pvar[1] = 0
    #eventPlayer.custom_hp_pvar[2] = 0
    #applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 2380
    removeTankPassive()
    eventPlayer.macro_pvar[0] = 0.831
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.setAmmo(0, 6)
    eventPlayer.setMaxAmmo(0, 6)
    eventPlayer.hero_initialized = true

rule "[roadhog/init.opy]: Correct other forms of damage":
    @Event playerDealtDamage
    @Hero roadhog
    @Condition eventAbility in [Button.MELEE, Button.ABILITY_1] == true
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])


rule "[roadhog/init.opy]: Clean up Roadhog":
    @Event eachPlayer
    @Condition eventPlayer.hero_setup != Hero.ROADHOG
    
    eventPlayer.Roadhog_vape_target = null
    destroyInWorldText(eventPlayer.Roadhog_targeting_hud)
