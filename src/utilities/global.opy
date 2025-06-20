
rule "[utilities/global.opy] Initialize global variables":
    DEBUG_MODE = createWorkshopSettingBool("Dev Tools", "debug mode", true)
    ADJ_TANK_ULT_NEGATION_PERCENT = createWorkshopSettingInt("Passive", "Tank - Ultimate Charge Negation Percent", 0, 0, 40)
    enable_regeneration = createWorkshopSettingBool("Passive", "Global - Regeneration", true)
    ADJ_REGEN_HPS = createWorkshopSettingInt("Passive", "Global - Regeneration Healing per Second", 25, 1, 100)
    ADJ_REGEN_TIMER = createWorkshopSettingInt("Passive", "Global - Regeneration Activation Time", 5, 1, 30)
    ANTI_CRASH_ACTIVATE_PERCENT = createWorkshopSettingInt("Anti Crash", "Activation Percent", 200, 0, 250)
    ANTI_CRASH_HOLD_TIME = createWorkshopSettingFloat("Anti Crash", "Activation Hold Time", 5.5, 0, 20)
    ANTI_CRASH_DEACTIVATE_PERCENT = createWorkshopSettingInt("Anti Crash", "Deactivation Percent", 110, 0, 250)


rule "[utilities/global.opy] Initialize player variables":
    @Event eachPlayer
    
    eventPlayer.within_shout_radius = false
    eventPlayer._current_damage_received = 100
    eventPlayer._current_move_speed = 100
    eventPlayer.Echo_Copy = false
    eventPlayer.Within_speed_radius = false


