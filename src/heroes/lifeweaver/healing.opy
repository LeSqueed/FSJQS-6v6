#!mainFile "../../main.opy"

rule "[lifeweaver/healing.opy]: Correct Healing ammount":
    @Event playerDealtHealing
    @Hero lifeweaver
    @Condition eventAbility != Button.ULTIMATE
    @Condition eventAbility != Button.ABILITY_2
    @Condition eventPlayer != healee
    @Condition healee.Lifeweaver_healing_cd != true

    healee.startHealingOverTime(null, 4, 10)
    healee.Lifeweaver_healing_cd = true
    wait(4)
    healee.Lifeweaver_healing_cd = null
