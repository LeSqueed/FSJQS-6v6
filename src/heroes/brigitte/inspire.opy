rule "[brigitte/inspire.opy]: Increase Inspire self healing":
    @Event playerDealtHealing
    @Hero brigitte
    @Condition healee == healer
    
    heal(healee, null, eventHealing * 1.25 - eventHealing)
