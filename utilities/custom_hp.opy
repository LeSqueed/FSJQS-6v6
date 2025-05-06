#!mainFile "../main.opy"

# Credit to https://discord.com/channels/570672959799164958/1095384108504465488
# Base code written by CaptCaptain and cactuspuppy
playervar max_health_scaler
playervar custom_hp_pvar
#!defineMember _hp_health custom_hp_pvar[0]
#!defineMember _hp_armor custom_hp_pvar[1]
#!defineMember _hp_shields custom_hp_pvar[2]
#!defineMember _hp_iter_count custom_hp_pvar[3]

#!define MIN_HP 1
#!define HP_ROUNDING_ERROR_MARGIN 0.01
#!define MAX_HP_ITER_COUNT 10

# setCustomHp(0, 0, 0) simply clears the hero's hp
#!define setCustomHp(health, armor, shields)\
    eventPlayer._hp_health = health\
    eventPlayer._hp_armor = armor\
    eventPlayer._hp_shields = shields\
    applyCustomHp()
    
def clearCustomHp():
    @Name "[utilities/custom_hp.opy]: clearCustomHp()"
    
    eventPlayer.removeAllHealthPools()
    wait()
    #DO NOT REMOVE THIS LINE
    eventPlayer.setMaxHealth(99.999)
    #DO NOT REMOVE THIS LINE
    wait()
    eventPlayer.setMaxHealth(100)


def applyCustomHp():
    @Name "[utilities/custom_hp.opy]: applyCustomHp()"
    
    eventPlayer.custom_hp_pvar[3] = 0
    #loop MAX_HP_ITER_COUNT times if hp is incorrect
    while (abs(eventPlayer.getMaxHealthOfType(Health.NORMAL) - eventPlayer.custom_hp_pvar[0]) > 0.01 or abs(eventPlayer.getMaxHealthOfType(Health.ARMOR) - eventPlayer.custom_hp_pvar[1]) > 0.01 or abs(eventPlayer.getMaxHealthOfType(Health.SHIELDS) - eventPlayer.custom_hp_pvar[2]) > 0.01) and eventPlayer.custom_hp_pvar[3] < 10:
        eventPlayer.setHealingReceived(0)
        eventPlayer.setHealth(1)
        eventPlayer.addHealthPool(Health.NORMAL, 1, true)
        eventPlayer.addHealthPool(Health.ARMOR, 1, true)
        eventPlayer.addHealthPool(Health.SHIELDS, 1, true)
        eventPlayer.setStatusEffect(null, Status.INVINCIBLE, 999999986991104)
        eventPlayer.removeAllHealthPools()
        #wait(0.064)
        wait()
        waitUntil(eventPlayer.getMaxHealth() <= 1, 1)
        #Apply custom health pool to player
        if eventPlayer.custom_hp_pvar[0] > 0:
            eventPlayer.addHealthPool(Health.NORMAL, max(1, eventPlayer.custom_hp_pvar[0] - 1), true)
        if eventPlayer.custom_hp_pvar[1] > 0:
            eventPlayer.addHealthPool(Health.ARMOR, max(1, eventPlayer.custom_hp_pvar[1]), true)
        if eventPlayer.custom_hp_pvar[2] > 0:
            eventPlayer.addHealthPool(Health.SHIELDS, max(1, eventPlayer.custom_hp_pvar[2]), true)
        eventPlayer.setHealingReceived(100)
        heal(eventPlayer, null, 999999986991104)
        eventPlayer.clearStatusEffect(Status.INVINCIBLE)
        wait()
        eventPlayer.custom_hp_pvar[3] += 1