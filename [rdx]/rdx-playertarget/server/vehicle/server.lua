RegisterNetEvent('rdx-playertarget:putInVehicle', function(target, netid)
    local targetId = tonumber(target)
	local Target = exports.qbx_core:GetPlayer(targetId)

	if not Target then return end

	TriggerClientEvent('rdx-playertarget:putInveh', targetId, netid)	
end)

RegisterNetEvent('rdx-playertarget:OutVehicle', function(target, coords)
    local targetId = tonumber(target)
	local Target = exports.qbx_core:GetPlayer(targetId)

	if not Target then return end

	TriggerClientEvent('rdx-playertarget:outVeh', Target.PlayerData.source, coords)
end)
