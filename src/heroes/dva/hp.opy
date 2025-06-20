rule "[dva/hp.opy]: Correct DVa mech health":
    @Event eachPlayer
    @Condition eventPlayer.hero_setup == Hero.DVA
    @Condition eventPlayer.isInAlternateForm() == false
    @Condition eventPlayer.hero_initialized != false
    
    clearCustomHp()
    eventPlayer.custom_hp_pvar[0] = 169
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()


rule "[dva/hp.opy]: Correct DVa pilot health":
    @Event eachPlayer
    @Condition eventPlayer.hero_setup == Hero.DVA
    @Condition eventPlayer.isInAlternateForm() == true
    @Condition eventPlayer.getMaxHealthOfType(Health.NORMAL) != 150
    @Condition eventPlayer.hero_initialized != false
    
    clearCustomHp()
    eventPlayer.custom_hp_pvar[0] = 28
    eventPlayer.custom_hp_pvar[1] = 0
    eventPlayer.custom_hp_pvar[2] = 0
    applyCustomHp()
