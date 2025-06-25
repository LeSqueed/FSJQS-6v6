const fs = require('node:fs');

// Compute the value for each setting based on its type
function computeSettingValue(setting) {
    if (setting.type === 'ratio' || setting.type === 'cooldownRatio') {
        // (desired / base) * 100, rounded to nearest integer
        // return Number(setting.desired / setting.base) * 100;
        // Need to round it to max 2 decimal places
        return Math.round((Number(setting.desired) / Number(setting.base)) * 10000) / 100;
    } else if (setting.type === 'percent') {
        return Number(setting.value);
    } else if (setting.type === 'boolean') {
        return Boolean(setting.value);
    } else {
        return setting.value;
    }
}

// Main generator function for JSON-style output (lowercase hero names, opyKey as key, computed value as value)
function generateJsonHeroBlock(heroes) {
    const heroEntries = Object.entries(heroes).map(([hero, settingsArr]) => {
        const settingsObj = {};
        for (const setting of settingsArr) {
            settingsObj[setting.opyKey] = computeSettingValue(setting);
        }
        const settingsEntries = Object.entries(settingsObj).map(([k, v]) => {
            if (typeof v === 'boolean') return `        "${k}": ${v}`;
            else return `        "${k}": ${v}`;
        });
        return `    "${hero.toLowerCase()}": {
${settingsEntries.join(',\n')}
    }`;
    });
    return heroEntries.join(',\n');
}

// Main generator function
async function generateHeroSettings(heroSettingsFile, lobbyFile) {
    if (!fs.existsSync(heroSettingsFile)) {
        throw new Error(`Hero settings file not found: ${heroSettingsFile}`);
    }
    const heroSettings = JSON.parse(fs.readFileSync(heroSettingsFile, 'utf8')).heroes;
    return generateJsonHeroBlock(heroSettings);
}

module.exports = { generateHeroSettings };