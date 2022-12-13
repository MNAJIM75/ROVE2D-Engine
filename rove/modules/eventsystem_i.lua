-- 0.5.1
local ev = {}
local evt = {} -- events table that will be called in each sub

function ev.find(_evName) -- find event in the events table
	if evt[_evName] then return true else return false end
end

function ev.sub(_obj, _evName)
	if not ev.find(_evName) then
		evt[_evName] = {} -- init table with the event name
	end
	table.insert(evt[_evName], _obj) -- sub the obj to the event
end

function ev.trigger(_evName, ...)
	if not ev.find(_evName) then return end
	for i, __client in pairs(evt[_evName]) do
		--if __client:getActive() then __client[evt_name](__client, ...) end -- for entity system
		if __client.isEngine then if __client[_evName] then __client[_evName](...) end
        else __client[_evName](__client, ...) end
	end
end

return ev