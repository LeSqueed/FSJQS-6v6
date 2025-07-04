#!mainFile "../../main.opy"

def resetUltCharge():
    @Name "[passives/tank/ult_charge.opy]: resetUltCharge()"

    eventPlayer.ult_charge_pvar[0] = 0
    eventPlayer.ult_charge_pvar[1] = 0
    waitUntil(eventPlayer.getUltCharge() > 0, 1)
    eventPlayer.setUltCharge(0)


rule "[passives/tank/ult_charge.opy]: Remember missing ult charge from damaging tank":
    @Event playerDealtDamage
    @Condition victim.getHero() in getTankHeroes() == true
    @Condition eventPlayer.isUsingUltimate() == false
    @Condition victim != eventPlayer

    eventPlayer.ult_charge_pvar[0] += ((40 - ADJ_TANK_ULT_NEGATION_PERCENT) / 100) * eventDamage


rule "[passives/tank/ult_charge.opy]: Remember missing ult charge from healing tank (+ workshop healing ultcharge)":
    @Event playerDealtHealing
    #@Condition healee.getHero() in getTankHeroes() == true
    @Condition (healee.getHero() in getTankHeroes() or eventPlayer.getHero() == Hero.SOMBRA and not eventWasHealthPack or eventPlayer.getHero() == Hero.MERCY and eventAbility != Button.PRIMARY_FIRE or healee != eventPlayer and eventPlayer.getHero() == Hero.ROADHOG or eventPlayer.getHero() == Hero.MAUGA) == true
    @Condition eventPlayer.isUsingUltimate() == false
    @Condition eventPlayer.getUltCharge() < 100

    if eventPlayer.getHero() == Hero.SOMBRA and not eventWasHealthPack or (eventPlayer.getHero() == Hero.MERCY and eventAbility != Button.PRIMARY_FIRE or healee != eventPlayer and eventPlayer.getHero() == Hero.ROADHOG or eventPlayer.getHero() == Hero.MAUGA):
        eventPlayer.ult_charge_pvar[0] += eventHealing
    elif healee.getHero() in getTankHeroes():
        eventPlayer.ult_charge_pvar[0] += ((40 - ADJ_TANK_ULT_NEGATION_PERCENT) / 100) * eventHealing


rule "[passives/tank/ult_charge.opy]: Remember missing ult charge from healing tank":
    @Event playerDealtHealing
    @Condition healee.getHero() in getTankHeroes() == true
    @Condition eventPlayer.isUsingUltimate() == false
    @Disabled

    eventPlayer.ult_charge_pvar[0] += ((40 - ADJ_TANK_ULT_NEGATION_PERCENT) / 100) * eventHealing


rule "[passives/tank/ult_charge.opy]: Compensate missing ultimate percentage":
    @Event eachPlayer
    @Condition eventPlayer.ult_charge_pvar[0] > 0.01 * eventPlayer.ult_charge_pvar[1]
    #guard to protect ult resetting accidentally
    @Condition eventPlayer.ult_charge_pvar[1] > 0

    eventPlayer.ult_charge_pvar[2] = ceil(100 * ((eventPlayer.getUltCharge() / 100 * eventPlayer.ult_charge_pvar[1] + eventPlayer.ult_charge_pvar[0]) / eventPlayer.ult_charge_pvar[1]))
    eventPlayer.ult_charge_pvar[0] -= eventPlayer.ult_charge_pvar[2] / 100 * eventPlayer.ult_charge_pvar[1] - eventPlayer.getUltCharge() / 100 * eventPlayer.ult_charge_pvar[1]
    eventPlayer.setUltCharge(eventPlayer.ult_charge_pvar[2])


rule "[passives/tank/ult_charge.opy]: Reset ult compensation after using ult":
    @Event eachPlayer
    @Condition eventPlayer.isUsingUltimate() == true

    eventPlayer.ult_charge_pvar[0] = 0