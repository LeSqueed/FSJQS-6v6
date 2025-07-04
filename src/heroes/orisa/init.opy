#!mainFile "../../main.opy"

playervar Orisa_Ammo
playervar Orisa_ring_effect
playervar terra_overhealth_id

#!include "energy_javelin.opy"
#!include "terra_surge.opy"
#!include "fortify.opy"
#!include "spin.opy"
#!include "heat.opy"

def initOrisa():
    @Name "[orisa/init.opy]: initOrisa()"

    eventPlayer.custom_hp_pvar[0] = 121.2
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
    eventPlayer.ult_charge_pvar[1] = 1814
    removeTankPassive()
    eventPlayer._base_damage_scalar = 0.858
    eventPlayer.setDamageDealt(100 * eventPlayer._base_damage_scalar)
    eventPlayer.setKnockbackDealt(82)
    eventPlayer.Orisa_Ammo = 80
    createInWorldText(eventPlayer, "{0} | 80".format(ceil(eventPlayer.Orisa_Ammo)), updateEveryFrame(eventPlayer.getEyePosition() + (100 * (3.35 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + (-1.5 * (directionFromAngles(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 * eventPlayer.getFacingDirection()))), 2)
    eventPlayer._orisa_ammo_text = getLastCreatedText()
    #if not eventPlayer.isDuplicatingAHero():
    #setBaseDamage(eventPlayer, ADJ_ORISA_JAVELIN_DIRECT_DAMAGE / OW2_ORISA_JAVELIN_DIRECT_DAMAGE)
    eventPlayer.balance_change_check = true
    eventPlayer._max_health_scalar = HeroHealthPercentage.ORISA / 100
    eventPlayer.hero_initialized = true


rule "[orisa/init.opy]: Correct Orisa Spin, Melee damage":
    @Event playerDealtDamage
    @Hero orisa
    @Condition eventAbility in [Button.ABILITY_1, Button.ABILITY_2, Button.MELEE] == true

    damage(victim, attacker, (eventDamage / eventPlayer._base_damage_scalar - eventDamage) / eventPlayer._base_damage_scalar)


rule "[orisa/init.opy]: Correct Orisa Javelin damage":
    @Event playerDealtDamage
    @Hero orisa
    @Condition eventAbility == Button.SECONDARY_FIRE

    damage(victim, attacker, (0.929 * (eventDamage / eventPlayer._base_damage_scalar) - eventDamage) / eventPlayer._base_damage_scalar)


rule "[orisa/init.opy]: Clean up Orisa":
    @Event eachPlayer
    @Condition eventPlayer.hero_setup != Hero.ORISA

    destroyEffect(eventPlayer.Orisa_ring_effect)
    eventPlayer.Orisa_Ammo = null
    destroyProgressBarInWorldText(eventPlayer._orisa_ammo_bar)
    destroyInWorldText(eventPlayer._orisa_ammo_text)
