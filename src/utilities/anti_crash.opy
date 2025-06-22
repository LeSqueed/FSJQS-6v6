rule "[utilities/anti_crash.opy]: Activate anti crash":
    @Condition getServerLoad() > ANTI_CRASH_ACTIVATE_PERCENT
    
    wait(ANTI_CRASH_HOLD_TIME, Wait.ABORT_WHEN_FALSE)
    smallMessage(getAllPlayers(), "Crash protection in progress...")
    setSlowMotion(1)
    waitUntil(getServerLoad() < ANTI_CRASH_DEACTIVATE_PERCENT, Math.INFINITY)
    setSlowMotion(100)