
def clearCustomHp():
    @Name "[utilities/custom_hp.opy]: clearCustomHp()"
    
    eventPlayer.removeAllHealthPools()


def applyCustomHp():
    @Name "[utilities/custom_hp.opy]: applyCustomHp()"
    
    #eventPlayer.setHealingReceived(0)
    #eventPlayer.setHealth(1)
    #eventPlayer.addHealthPool(Health.NORMAL, 1, true)
    #eventPlayer.addHealthPool(Health.ARMOR, 1, true)
    #eventPlayer.addHealthPool(Health.SHIELDS, 1, true)
    eventPlayer.setStatusEffect(null, Status.INVINCIBLE, 999999986991104)
    #eventPlayer.removeAllHealthPools()
    #wait(0.064)
    wait()
    #waitUntil(eventPlayer.getMaxHealth() <= 1, 1)
    #Apply custom health pool to player
    if eventPlayer.custom_hp_pvar[0] > 0:
        eventPlayer.addHealthPool(Health.NORMAL, max(1, eventPlayer.custom_hp_pvar[0]), true)
    if eventPlayer.custom_hp_pvar[1] > 0:
        eventPlayer.addHealthPool(Health.ARMOR, max(1, eventPlayer.custom_hp_pvar[1]), true)
    if eventPlayer.custom_hp_pvar[2] > 0:
        eventPlayer.addHealthPool(Health.SHIELDS, max(1, eventPlayer.custom_hp_pvar[2]), true)
    #eventPlayer.setHealingReceived(100)
    heal(eventPlayer, null, 999999986991104)
    eventPlayer.clearStatusEffect(Status.INVINCIBLE)
