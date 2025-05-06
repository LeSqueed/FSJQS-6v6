#!mainFile "../main.opy"

settings {
    "main": {
        "modeName": "6v6 Adjustments + Realth 1.15.9"
    },
    "lobby": {
        "mapRotation": "afterGame",
        "spectatorSlots": 12,
        "team1Slots": 6,
        "team2Slots": 6,
        "pauseGameOnDisconnect": true,
        "returnToLobby": "afterGame"
    },
    "gamemodes": {
        "assault": {
            "enabledMaps": [],
            "captureSpeed%": 120,
            "enableCompetitiveRules": true,
            "enablePerks": false
        },
        "clash": {
            "enabled": false,
            "captureSpeed%": 45
        },
        "control": {
            "enabledMaps": [
                "lijiangTower"
            ],
            "enableCompetitiveRules": true,
            "enablePerks": false
        },
        "escort": {
            "enabledMaps": [],
            "enableCompetitiveRules": true,
            "enablePerks": false
        },
        "flashpoint": {
            "enabledMaps": [],
            "enableCompetitiveRules": true,
            "enablePerks": false,
            "scoringSpeed%": 85
        },
        "hybrid": {
            "enabledMaps": [],
            "enableCompetitiveRules": true,
            "enablePerks": false
        },
        "push": {
            "enabledMaps": [],
            "enableCompetitiveRules": true,
            "enablePerks": false,
            "ts1PushSpeedModifier%": 100
        },
        "general": {
            "gamemodeStartTrigger": "immediately",
            "randomHeroRoleLimitPerTeam": 2,
            "spawnHealthPacks": "enabled",
            "tankPassiveHealthBonus": "disabled"
        }
    },
    "heroes": {
        "allTeams": {
            "ana": {
                "ammoClipSize%": 80,
                "ability2Cooldown%": 86,
                "ability1Cooldown%": 86,
                "ultGen%": 100
            },
            "ashe": {
                "health%": 80,
                "ultGen%": 109
            },
            "baptiste": {
                "health%": 80,
                "ultGen%": 105
            },
            "bastion": {
                "ability1Cooldown%": 100,
                "ultGen%": 96
            },
            "brigitte": {
                "health%": 100,
                "ability2Cooldown%": 100,
                "ultGen%": 103
            },
            "cassidy": {
                "ultGen%": 107
            },
            "dva": {
                "secondaryFireMaximumTime%": 67,
                "secondaryFireRechargeRate%": 90,
                "health%": 86,
                "ultGen%": 110
            },
            "doomfist": {
                "health%": 63,
                "ability1Cooldown%": 114,
                "ability2Cooldown%": 100,
                "ultGen%": 113
            },
            "echo": {
                "ability2Cooldown%": 125,
                "ultGen%": 98
            },
            "genji": {
                "ultDuration%": 50,
                "ultGen%": 145
            },
            "hanzo": {
                "ability2Cooldown%": 125,
                "ability2Quantity%": 5,
                "ultGen%": 110
            },
            "illari": {
                "ammoClipSize%": 85,
                "ability2Cooldown%": 114,
                "health%": 80,
                "solarEnergyMax%": 86,
                "ultGen%": 121
            },
            "junkerQueen": {
                "ability2Cooldown%": 88,
                "ability1Cooldown%": 108,
                "health%": 71,
                "ultGen%": 117
            },
            "junkrat": {
                "ability1Cooldown%": 100,
                "ultGen%": 109
            },
            "juno": {
                "ability1Cooldown%": 133,
                "ability2Cooldown%": 136,
                "secondaryFireCooldown%": 100,
                "ultGen%": 110
            },
            "kiriko": {
                "ability2Cooldown%": 93,
                "ability1Cooldown%": 100,
                "ultGen%": 105
            },
            "lifeweaver": {
                "ammoClipSize%": 80,
                "secondaryFireCooldown%": 100,
                "secondaryFireHealth%": 83,
                "ability1Cooldown%": 0,
                "ability1Health%": 45,
                "ultHealth%": 75,
                "ultGen%": 110
            },
            "lucio": {
                "secondaryFireCooldown%": 105,
                "secondaryFireKb%": 100,
                "ultGen%": 90
            },
            "mauga": {
                "ammoClipSize%": 100,
                "ability2Cooldown%": 84,
                "ability2Healing%": 0,
                "health%": 125,
                "primaryFireIgniteDamage": 223,
                "primaryFireIgniteDuration": 75,
                "ability1Cooldown%": 40,
                "ultGen%": 108
            },
            "mei": {
                "ability1Cooldown%": 50,
                "health%": 110,
                "ultGen%": 120,
                "primaryFireFreezeRate%": 130
            },
            "mercy": {
                "ability1Cooldown%": 73,
                "ability2Cooldown%": 50,
                "enablePassive": false,
                "ultGen%": 111
            },
            "moira": {
                "ultGen%": 104
            },
            "orisa": {
                "secondaryFireCooldown%": 117,
                "ability1Cooldown%": 79,
                "ability2Cooldown%": 75,
                "ultGen%": 119
            },
            "pharah": {
                "ultGen%": 105
            },
            "ramattra": {
                "health%": 63,
                "ability1Cooldown%": 100,
                "ability2Cooldown%": 82,
                "ultDuration%": 100,
                "ultGen%": 114,
                "secondaryFireCooldown%": 81
            },
            "reaper": {
                "ability2Cooldown%": 80,
                "ultGen%": 98
            },
            "reinhardt": {
                "secondaryFireRechargeRate%": 88,
                "ability1Cooldown%": 143,
                "health%": 107,
                "ultGen%": 123
            },
            "roadhog": {
                "ability1Cooldown%": 117,
                "ability2Cooldown%": 75,
                "secondaryFireCooldown%": 480,
                "secondaryFireMaximumTime%": 89,
                "secondaryFireRechargeRate%": 500,
                "ultGen%": 110
            },
            "sigma": {
                "secondaryFireRechargeRate%": 94,
                "ability1Cooldown%": 108,
                "ultGen%": 101
            },
            "sojourn": {
                "ability1Cooldown%": 75,
                "ultGen%": 110
            },
            "soldier": {
                "ultGen%": 119
            },
            "sombra": {
                "secondaryFireCooldown%": 134,
                "ability2Cooldown%": 100,
                "ultGen%": 62,
                "ability1Cooldown%": 100
            },
            "symmetra": {
                "health%": 75,
                "ultGen%": 121
            },
            "torbjorn": {
                "health%": 89,
                "ultGen%": 110
            },
            "tracer": {
                "health%": 86,
                "ability2Cooldown%": 103,
                "ultGen%": 110
            },
            "venture": {
                "ability1Duration%": 50,
                "ultGen%": 137
            },
            "widowmaker": {
                "ultGen%": 101,
                "ability2Cooldown%": 80
            },
            "winston": {
                "health%": 92,
                "ability1Cooldown%": 120,
                "ultGen%": 138
            },
            "wreckingBall": {
                "ability1Kb%": 85,
                "health%": 50,
                "ability3Cooldown%": 125,
                "ultGen%": 120
            },
            "zarya": {
                "ability1Cooldown%": 109,
                "ultGen%": 119
            },
            "zenyatta": {
                "ultGen%": 104
            },
            "disabledHeroes": [
                "freja"
            ],
            "general": {
                "passiveHealthRegen": false
            }
        }
    },
    "workshop": {
        "Activation Hold Time": 5.5,
        "Calculate DPS over seconds": 10,
        "Damage Role Cap": 2,
        "debug mode": false,
        "Support Role Cap": 2,
        "Tank Role Cap": 2
    }
}
