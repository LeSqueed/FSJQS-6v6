#!mainFile "../main.opy"

rule "[utilities/hud.opy]: Padding lines for HUD display Roadhog and Sombra (makes it visable to spectators)":
    @Condition Spectator_padding == null
    @Condition DEBUG_MODE == false

    hudSubtext(localPlayer, " \r\n\r\n\r\n\r", HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
    Spectator_padding = true


rule "[utilities/hud.opy]: Display buffs from Roadhog, Hanzo and Sombra":
    @Event eachPlayer
    @Condition DEBUG_MODE == false

    hudSubtext(eventPlayer, " \r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n                                                         {0} {1} {2}".format(abilityIconString(Hero.ROADHOG, Button.SECONDARY_FIRE) if eventPlayer.Roadhog_vape_hud_icon == true else " ", abilityIconString(Hero.SOMBRA, Button.ULTIMATE) if eventPlayer.Sombra_hack_icon == true else " ", iconString(Icon.SKULL) if eventPlayer.Hanzo_Marked_icon else " "), HudPosition.LEFT, 2, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    eventPlayer._status_effect_hud = getLastCreatedText()
