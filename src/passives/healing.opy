#!mainFile "../../main.opy"

rule "[passives/healing.opy]: Track Health != 100% stop healing then start healing after 5s":
    @Event playerTookDamage
    @Condition enable_regeneration == true

    stopHealingOverTime(eventPlayer.regen_passive_id)
    if eventPlayer.getHero() == Hero.BASTION:
        stopHealingOverTime(eventPlayer.Bastion_healing_id)
    eventPlayer.self_heal_pvar = false
    wait(ADJ_REGEN_TIMER, Wait.RESTART_WHEN_TRUE)
    eventPlayer.self_heal_pvar = true


rule "[passives/healing.opy]: Healing passive amount and ID":
    @Event eachPlayer
    @Condition eventPlayer.self_heal_pvar != false
    @Condition enable_regeneration == true

    eventPlayer.startHealingOverTime(null, Math.INFINITY, ADJ_REGEN_HPS)
    eventPlayer.regen_passive_id = getLastHealingOverTimeId()
    if eventPlayer.getHero() == Hero.BASTION:
        eventPlayer.startHealingOverTime(null, Math.INFINITY, 15)
        eventPlayer.Bastion_healing_id = getLastHealingOverTimeId()


rule "[passives/healing.opy]: If health = max health stop healing":
    @Event eachPlayer
    @Condition eventPlayer.getNormalizedHealth() >= 1
    @Condition enable_regeneration == true

    stopHealingOverTime(eventPlayer.regen_passive_id)
    if eventPlayer.getHero() == Hero.BASTION:
        stopHealingOverTime(eventPlayer.Bastion_healing_id)