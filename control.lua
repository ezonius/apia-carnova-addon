local HIVE_NAME = 'artificial-hive'
local EFFECTS = { 'speed', 'productivity', 'consumption', 'pollution', 'quality' }
local SETTING_PREFIX = 'apia-carnova-addon-hive-effect-'

--- Build a lookup set of currently enabled effect types.
local function allowed_effects()
	local set = {}
	for _, effect in ipairs(EFFECTS) do
		set[effect] = settings.global[SETTING_PREFIX .. effect].value
	end
	return set
end

--- Returns true if the given item prototype is a module with at least one disabled effect.
local function is_module_disallowed(item, allowed)
	for effect in pairs(item.module_effects) do
		if not allowed[effect] then
			return true
		end
	end
	return false
end

--- Remove modules whose effects are currently disabled from a single machine.
local function scrub_entity(entity)
	local allowed = allowed_effects()
	local inventory = entity.get_inventory(defines.inventory.crafter_modules)
	if not inventory or inventory.is_empty() then
		return
	end
	for i = #inventory, 1, -1 do
		local stack = inventory[i]
		if stack and stack.valid_for_read then
			local item = prototypes.item[stack.name]
			if item and item.module_effects and is_module_disallowed(item, allowed) then
				inventory.remove({ name = stack.name, count = stack.count })
			end
		end
	end
end

--- Scrub every artificial hive on every surface.
local function scrub_all()
	local allowed = allowed_effects()
	local any_disabled = false
	for _, effect in ipairs(EFFECTS) do
		if not allowed[effect] then
			any_disabled = true
			break
		end
	end
	if not any_disabled then
		return
	end
	for _, surface in pairs(game.surfaces) do
		for _, entity in pairs(surface.find_entities_filtered({ name = HIVE_NAME })) do
			scrub_entity(entity)
		end
	end
end

script.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
	if event.setting:find(SETTING_PREFIX, 1, true) then
		scrub_all()
	end
end)

local function on_created(event)
	local entity = event.entity or event.destination
	if entity and entity.valid and entity.name == HIVE_NAME then
		scrub_entity(entity)
	end
end

script.on_event({ defines.events.on_built_entity, defines.events.on_robot_built_entity, defines.events.on_entity_cloned, defines.events.script_raised_built, defines.events.script_raised_revive }, on_created)

-- Safety net: periodically scrub hives in case modules were inserted while an
-- effect toggle was disabled (the prototype-level allowed_effects list still
-- permits all five effect types).
script.on_nth_tick(600, function()
	scrub_all()
end)
