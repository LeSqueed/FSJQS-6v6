rule "[ashe/viper.opy]: correct viper damage":
    @Event playerDealtDamage
    @Hero ashe
    @Condition eventAbility == Button.PRIMARY_FIRE
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == false
    
    damage(victim, attacker, (eventDamage / eventPlayer.macro_pvar[0] - eventDamage) / eventPlayer.macro_pvar[0])