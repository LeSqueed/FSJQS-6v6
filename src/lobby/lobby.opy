#!mainFile "../main.opy"

#!include "../utilities/macro_functions.opy"
#!include "../utilities/texts.opy"

macro VERSION = "1.17.15"
macro PERKS_ENABLED = false

settings {
    "main": {
        "modeName": f"6v6 Adjustments + Realth {VERSION}"
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
            "enablePerks": PERKS_ENABLED
        },
        "clash": {
            "enabled": false,
            "captureSpeed%": 45
        },
        "control": {
            "enabledMaps": [],
            "enableCompetitiveRules": true,
            "enablePerks": PERKS_ENABLED
        },
        "escort": {
            "enabledMaps": [],
            "enableCompetitiveRules": true,
            "enablePerks": PERKS_ENABLED
        },
        "flashpoint": {
            "enabledMaps": [],
            "enableCompetitiveRules": true,
            "enablePerks": PERKS_ENABLED,
            "scoringSpeed%": 85
        },
        "hybrid": {
            "enabledMaps": [],
            "enableCompetitiveRules": true,
            "enablePerks": PERKS_ENABLED
        },
        "push": {
            "enabledMaps": [],
            "enableCompetitiveRules": true,
            "enablePerks": PERKS_ENABLED,
            "ts1PushSpeedModifier%": 100
        },
        "general": {
            "gamemodeStartTrigger": "immediately",
            "healthPackRespawnTime%": 120,
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
                "health%": HeroHealthPercentage.ANA,
                "ability1Cooldown%": 86,
                "ultGen%": 100
            },
            "ashe": {
                "health%": HeroHealthPercentage.ASHE,
                "ultGen%": 109
            },
            "baptiste": {
                "ammoClipSize%": 130,
                "health%": HeroHealthPercentage.BAPTISTE,
                "ultGen%": 105
            },
            "bastion": {
                "health%": HeroHealthPercentage.BASTION,
                "ability1Cooldown%": 100,
                "ultGen%": 96
            },
            "brigitte": {
                "health%": HeroHealthPercentage.BRIGITTE,
                "ability2Cooldown%": 100,
                "ultGen%": 103
            },
            "cassidy": {
                "health%": HeroHealthPercentage.CASSIDY,
                "ultGen%": 107
            },
            "dva": {
                "ability1Cooldown%": 114,
                "secondaryFireMaximumTime%": 67,
                "secondaryFireRechargeRate%": 90,
                "health%": HeroHealthPercentage.DVA,
                "ultGen%": 110
            },
            "doomfist": {
                "health%": HeroHealthPercentage.DOOMFIST,
                "secondaryFireCooldown%": 125,
                "ability2Cooldown%": 100,
                "ultGen%": 113
            },
            "echo": {
                "ability2Cooldown%": 125,
                "health%": HeroHealthPercentage.ECHO,
                "ultGen%": 98
            },
            "freja": {
                "health%": 89
            },
            "genji": {
                "ammoClipSize%": 125,
                "health%": HeroHealthPercentage.GENJI,
                "ultDuration%": 50,
                "ultGen%": 145
            },
            "hanzo": {
                "health%": HeroHealthPercentage.HANZO,
                "ability2Quantity%": 4,
                "ultGen%": 110
            },
            "hazard": {
                "health%": HeroHealthPercentage.HAZARD,
                "ability1Cooldown%": 116
            },
            "illari": {
                "ammoClipSize%": 85,
                "ability2Cooldown%": 114,
                "health%": HeroHealthPercentage.ILLARI,
                "solarEnergyMax%": 86,
                "ultGen%": 121
            },
            "junkerQueen": {
                "ability2Cooldown%": 88,
                "ability1Cooldown%": 108,
                "health%": HeroHealthPercentage.JUNKER_QUEEN,
                "ultGen%": 117
            },
            "junkrat": {
                "ability1Cooldown%": 100,
                "health%": HeroHealthPercentage.JUNKRAT,
                "ultGen%": 109
            },
            "juno": {
                "ability1Cooldown%": 133,
                "health%": HeroHealthPercentage.JUNO,
                "ability2Cooldown%": 136,
                "secondaryFireCooldown%": 100,
                "ultGen%": 110,
                "ammoClipSize%": 66.6
            },
            "kiriko": {
                "health%": HeroHealthPercentage.KIRIKO,
                "ability2Cooldown%": 93,
                "ability1Cooldown%": 100,
                "ultGen%": 117
            },
            "lifeweaver": {
                "ammoClipSize%": 80,
                "health%": HeroHealthPercentage.LIFEWEAVER,
                "secondaryFireCooldown%": 100,
                "secondaryFireHealth%": 133,
                "ability1Cooldown%": 0,
                "ability1Health%": 45,
                "ultHealth%": 150,
                "ultGen%": 110
            },
            "lucio": {
                "health%": HeroHealthPercentage.LUCIO,
                "secondaryFireCooldown%": 105,
                "secondaryFireKb%": 100,
                "ultGen%": 90
            },
            "mauga": {
                "ammoClipSize%": 100,
                "ability2Cooldown%": 84,
                "ability2Healing%": 0,
                "health%": HeroHealthPercentage.MAUGA,
                "primaryFireIgniteDamage": 223,
                "primaryFireIgniteDuration": 75,
                "ability1Cooldown%": 120,
                "ultGen%": 108
            },
            "mei": {
                "health%": HeroHealthPercentage.MEI,
                "ultGen%": 120,
                "primaryFireFreezeRate%": 130
            },
            "mercy": {
                "ability1Cooldown%": 73,
                "health%": HeroHealthPercentage.MERCY,
                "projectileSpeed%": 120,
                "ability2Cooldown%": 50,
                "enablePassive": false
            },
            "moira": {
                "primaryFireMaximumTime%": 85,
                "health%": HeroHealthPercentage.MOIRA,
                "ultGen%": 104
            },
            "orisa": {
                "secondaryFireCooldown%": 117,
                "ability1Cooldown%": 79,
                "health%": HeroHealthPercentage.ORISA,
                "ability2Cooldown%": 75,
                "enableInfiniteAmmo": true,
                "ultGen%": 119
            },
            "pharah": {
                "health%": HeroHealthPercentage.PHARAH,
                "ultGen%": 105
            },
            "ramattra": {
                "health%": HeroHealthPercentage.RAMATTRA,
                "ability1Cooldown%": 100,
                "ability2Cooldown%": 85,
                "ultDuration%": 100,
                "ultGen%": 114,
                "secondaryFireCooldown%": 81
            },
            "reaper": {
                "health%": HeroHealthPercentage.REAPER,
                "ability2Cooldown%": 80,
                "ultGen%": 98
            },
            "reinhardt": {
                "secondaryFireRechargeRate%": 88,
                "ability1Cooldown%": 143,
                "projectileSpeed%": 83,
                "ultGen%": 123
            },
            "roadhog": {
                "ability1Cooldown%": 117,
                "health%": HeroHealthPercentage.ROADHOG,
                "ability2Cooldown%": 75,
                "secondaryFireCooldown%": 480,
                "secondaryFireMaximumTime%": 89,
                "secondaryFireRechargeRate%": 500,
                "ultGen%": 110
            },
            "sigma": {
                "secondaryFireRechargeRate%": 94,
                "health%": HeroHealthPercentage.SIGMA,
                "ability1Cooldown%": 108,
                "ultGen%": 101
            },
            "sojourn": {
                "health%": HeroHealthPercentage.SOJOURN,
                "ability1Cooldown%": 75,
                "ultGen%": 110
            },
            "soldier": {
                "health%": HeroHealthPercentage.SOLDIER,
                "ultGen%": 119
            },
            "sombra": {
                "secondaryFireCooldown%": 134,
                "health%": HeroHealthPercentage.SOMBRA,
                "ability2Cooldown%": 100,
                "ultGen%": 49,
                "ability1Cooldown%": 150
            },
            "symmetra": {
                "health%": HeroHealthPercentage.SYMMETRA,
                "ultGen%": 121
            },
            "torbjorn": {
                "ability1Cooldown%": 83,
                "health%": HeroHealthPercentage.TORBJORN,
                "ultGen%": 110
            },
            "tracer": {
                "health%": HeroHealthPercentage.TRACER,
                "ability2Cooldown%": 103,
                "ultGen%": 110
            },
            "venture": {
                "ability1Duration%": 50,
                "ultGen%": 137
            },
            "widowmaker": {
                "health%": HeroHealthPercentage.WIDOWMAKER,
                "ammoClipSize%": 114,
                "ultGen%": 101,
                "ability2Cooldown%": 80
            },
            "winston": {
                "health%": HeroHealthPercentage.WINSTON,
                "ability1Cooldown%": 120,
                "ultGen%": 138
            },
            "wreckingBall": {
                "secondaryFireCooldown%": 120,
                "ability1Kb%": 85,
                "health%": HeroHealthPercentage.WRECKINGBALL,
                "ability3Cooldown%": 125,
                "ultGen%": 120
            },
            "zarya": {
                "ability1Cooldown%": 109,
                "ultGen%": 119
            },
            "zenyatta": {
                "health%": HeroHealthPercentage.ZENYATTA,
                "ultGen%": 119
            },
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
        "Tank Role Cap": 2,
        "Percent of Stealth Timer Remaining Refunded Towards Translocator Cooldown": 33,
    }
}
