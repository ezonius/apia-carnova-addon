-- Module slot count for the Artificial Hive (startup: requires restart).
data:extend({
	{
		type = 'int-setting',
		name = 'apia-carnova-addon-hive-module-slots',
		setting_type = 'startup',
		default_value = 6,
		minimum_value = 0,
		maximum_value = 8,
		order = 'a',
	},
})

-- Per-effect toggles for the Artificial Hive (startup: requires restart).
-- allowed_effects governs both modules inserted in the machine itself and
-- effects received from beacons, so these toggles enable both at once.
local effects = {
	{ 'speed', 'b' },
	{ 'productivity', 'c' },
	{ 'consumption', 'd' },
	{ 'pollution', 'e' },
	{ 'quality', 'f' },
}
local effect_settings = {}
for _, effect in ipairs(effects) do
	table.insert(effect_settings, {
		type = 'bool-setting',
		name = 'apia-carnova-addon-hive-effect-' .. effect[1],
		setting_type = 'startup',
		default_value = false,
		order = effect[2],
	})
end
data:extend(effect_settings)

-- Add the Apia tile recipes (wax platform + artificial soils) to the Biosynthesizer
-- (startup: requires restart).
data:extend({
	{
		type = 'bool-setting',
		name = 'apia-carnova-addon-biosynthesizer-tile-recipes',
		setting_type = 'startup',
		default_value = false,
		order = 'g',
	},
	{
		type = 'bool-setting',
		name = 'apia-carnova-addon-foundation-on-fat-jelly',
		setting_type = 'startup',
		default_value = false,
		order = 'h',
	},
})
