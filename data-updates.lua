local hive = data.raw['assembling-machine']['artificial-hive']
if hive then
	local slots = settings.startup['apia-carnova-addon-hive-module-slots'].value --[[@as integer]]
	if slots > 0 then
		hive.module_slots = slots
		-- All five effect types are enabled at the prototype level; which ones are
		-- actually usable is enforced at runtime by control.lua (per-effect toggles).
		hive.allowed_effects = { 'speed', 'productivity', 'consumption', 'pollution', 'quality' }
	end
end
