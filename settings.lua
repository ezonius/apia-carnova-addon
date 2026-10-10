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

-- Per-effect toggles for the Artificial Hive (runtime, default off).
-- Enforcement happens in control.lua: disallowed modules are removed from
-- placed hives when the setting changes, when a hive is built, and periodically.
local effects = {
	{ 'speed', 'b' },
	{ 'productivity', 'c' },
	{ 'consumption', 'd' },
	{ 'pollution', 'e' },
	{ 'quality', 'f' },
}
local runtime_settings = {}
for _, effect in ipairs(effects) do
	table.insert(runtime_settings, {
		type = 'bool-setting',
		name = 'apia-carnova-addon-hive-effect-' .. effect[1],
		setting_type = 'runtime-global',
		default_value = false,
		order = effect[2],
	})
end
data:extend(runtime_settings)
