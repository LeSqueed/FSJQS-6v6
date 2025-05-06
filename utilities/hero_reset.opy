#!mainFile "../main.opy"

playervar overhealth_check
playervar balance_change_check
playervar macro_pvar
playervar DamageRecieved
playervar MoveSpeed

subroutine resetHero
subroutine resetStats
subroutine resetStatuses
subroutine disableAllAbilities
subroutine enableAllAbilities

#!include "utilities/custom_hp.opy"
#!include "passives/tank/ult_charge.opy"
#!include "utilities/hero_init.opy"

def resetHero():
    @Name "[utilities/reset.opy]: resetHero()"
    
    clearCustomHp()
    disableAllAbilities()
    resetStats()
    async(resetUltCharge, AsyncBehavior.RESTART)
    enableAllAbilities()
    eventPlayer.hero_initialized = false

def enableAllAbilities():
    @Name "[utilities/hero_reset.opy]: enableAllAbilities()"
    
    eventPlayer.allowButton(Button.PRIMARY_FIRE)
    eventPlayer.allowButton(Button.SECONDARY_FIRE)
    eventPlayer.allowButton(Button.ABILITY_1)
    eventPlayer.allowButton(Button.ABILITY_2)
    eventPlayer.allowButton(Button.ULTIMATE)
    eventPlayer.allowButton(Button.MELEE)
    eventPlayer.allowButton(Button.JUMP)
    eventPlayer.allowButton(Button.CROUCH)
    eventPlayer.allowButton(Button.RELOAD)
    eventPlayer.allowButton(Button.INTERACT)
    eventPlayer.setPrimaryFireEnabled(true)
    eventPlayer.setSecondaryFireEnabled(true)
    eventPlayer.setAbility1Enabled(true)
    eventPlayer.setAbility2Enabled(true)
    eventPlayer.setUltEnabled(true)
    eventPlayer.setMeleeEnabled(true)
    eventPlayer.setJumpEnabled(true)
    eventPlayer.setCrouchEnabled(true)
    eventPlayer.setReloadEnabled(true)


def disableAllAbilities():
    @Name "[utilities/hero_reset.opy]: disableAllAbilities()"
    
    eventPlayer.disallowButton(Button.PRIMARY_FIRE)
    eventPlayer.disallowButton(Button.SECONDARY_FIRE)
    eventPlayer.disallowButton(Button.ABILITY_1)
    eventPlayer.disallowButton(Button.ABILITY_2)
    eventPlayer.disallowButton(Button.ULTIMATE)
    eventPlayer.disallowButton(Button.MELEE)
    eventPlayer.disallowButton(Button.JUMP)
    eventPlayer.disallowButton(Button.CROUCH)
    eventPlayer.disallowButton(Button.RELOAD)
    eventPlayer.disallowButton(Button.INTERACT)
    eventPlayer.setPrimaryFireEnabled(false)
    eventPlayer.setSecondaryFireEnabled(false)
    eventPlayer.setAbility1Enabled(false)
    eventPlayer.setAbility2Enabled(false)
    eventPlayer.setUltEnabled(false)
    eventPlayer.setMeleeEnabled(false)
    eventPlayer.setJumpEnabled(false)
    eventPlayer.setCrouchEnabled(false)
    eventPlayer.setReloadEnabled(false)


def resetStats():
    @Name "[utilities/hero_reset.opy]: resetStats()"
    
    eventPlayer.macro_pvar[0] = 1
    eventPlayer.setDamageDealt(100 * eventPlayer.macro_pvar[0])
    eventPlayer.setDamageReceived(100)
    eventPlayer.setProjectileSpeed(100)
    eventPlayer.setProjectileGravity(100)
    eventPlayer.macro_pvar[1] = 1
    eventPlayer.setHealingDealt(100 * eventPlayer.macro_pvar[1])
    eventPlayer.setHealingReceived(100)
    eventPlayer.setKnockbackReceived(100)
    eventPlayer.setKnockbackDealt(100)
    #eventPlayer.setGravity(100)
    #eventPlayer.setJumpVerticalSpeed(100) # might be responsible for jump bug
    eventPlayer.macro_pvar[2] = 1
    eventPlayer.setMoveSpeed(100 * eventPlayer.macro_pvar[2])
    eventPlayer.stopScalingSize()
    eventPlayer.stopScalingBarriers()
    #prevent wholehog from keeping primary fire held
    eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
    eventPlayer.max_health_scaler = 1
    eventPlayer.stopAllDamageOverTime()
    eventPlayer.stopAllHealingOverTime()
    eventPlayer.DamageRecieved = 100
    eventPlayer.MoveSpeed = 100


def resetStatuses():
    @Name "[utilities/hero_reset.opy]: resetStatuses()"
    
    eventPlayer.clearStatusEffect(Status.ASLEEP)
    eventPlayer.clearStatusEffect(Status.BURNING)
    eventPlayer.clearStatusEffect(Status.FROZEN)
    eventPlayer.clearStatusEffect(Status.HACKED)
    eventPlayer.clearStatusEffect(Status.INVINCIBLE)
    eventPlayer.clearStatusEffect(Status.KNOCKED_DOWN)
    eventPlayer.clearStatusEffect(Status.PHASED_OUT)
    eventPlayer.clearStatusEffect(Status.ROOTED)
    eventPlayer.clearStatusEffect(Status.STUNNED)
    eventPlayer.clearStatusEffect(Status.UNKILLABLE)

    
rule "[utilities/hero_reset.opy]: Stop DoT/HoT on death":
    @Event playerDied
    
    eventPlayer.stopAllDamageOverTime()
    eventPlayer.stopAllHealingOverTime()