local hive = data.raw['assembling-machine']['artificial-hive']
if hive then
	local slots = settings.startup['apia-carnova-addon-hive-module-slots'].value --[[@as integer]]
	if slots > 0 then
		-- allowed_effects governs both modules inserted in the machine itself and
		-- effects received from beacons.
		local allowed_effects = {}
		local effects = { 'speed', 'productivity', 'consumption', 'pollution', 'quality' }
		for _, effect in ipairs(effects) do
			if settings.startup['apia-carnova-addon-hive-effect-' .. effect].value then
				table.insert(allowed_effects, effect)
			end
		end
		if #allowed_effects > 0 then
			hive.module_slots = slots
			hive.allowed_effects = allowed_effects
		end
	end
end

-- Productivity is disabled by default on recipes that don't set allow_productivity.
-- The honeycomb recipes (the only ones in the artificial-hive-process category) don't,
-- so enable it when the productivity toggle is on so productivity modules/beacon
-- effects actually do something.
if settings.startup['apia-carnova-addon-biosynthesizer-tile-recipes'].value then
	-- The Biosynthesizer can craft 'apicultural' recipes, so adding that category to
	-- Apia's tile recipes makes them craftable in it. One toggle covers all of them.
	local tile_recipe_names = {
		'wax-platform',
		'artificial-honey-soil',
		'artificial-copper-soil',
		'artificial-iron-soil',
	}
	for _, name in ipairs(tile_recipe_names) do
		local recipe = data.raw.recipe[name]
		if recipe then
			recipe.categories = recipe.categories or {}
			table.insert(recipe.categories, 'apicultural')
		end
	end
end

if settings.startup['apia-carnova-addon-hive-effect-productivity'].value then
	for _, recipe in pairs(data.raw.recipe) do
		local categories = recipe.categories or {}
		for _, category in ipairs(categories) do
			if category == 'artificial-hive-process' then
				recipe.allow_productivity = true
			end
		end
	end
end
