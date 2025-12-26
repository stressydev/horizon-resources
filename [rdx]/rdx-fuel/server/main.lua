RegisterNetEvent('rdx-fuel:attachRope', function(netId, pumpCoords, pumpModel)
    local src = source
    TriggerClientEvent('rdx-fuel:pAttachRope', -1, src, netId, pumpCoords, pumpModel)
end)

RegisterNetEvent('rdx-fuel:detachRope', function()
    local src = source
    TriggerClientEvent('rdx-fuel:pDetachRope', -1, src)
end)

local function setFuelState(netId, fuel)
	local vehicle = NetworkGetEntityFromNetworkId(netId)

	if vehicle == 0 or GetEntityType(vehicle) ~= 2 then
		return
	end

	local state = Entity(vehicle)?.state
	fuel = math.clamp(fuel, 0, 100)

	state:set('fuel', fuel, true)
end


RegisterNetEvent('rdx-fuel:pay', function(pumpPrice, fuel, liters, netid, method)
    local src = source
    local Player = exports.qbx_core:GetPlayer(src)
    if not Player then return end

    fuel = math.floor(fuel)
    liters = math.floor(liters)
    
    local total = math.floor(liters * pumpPrice)

    if Player.Functions.RemoveMoney(method, total, 'FUEL') then
        setFuelState(netid, fuel)

        TriggerClientEvent('stressy-phone:addNotification', src, "Gas Station", "Transaction Complete", ('Added %s liters of fuel Cost: ₱%s'):format(math.floor(liters), lib.math.groupdigits(total), method), 'fas fa-gas-pump', 10000)
    else
        TriggerClientEvent('stressy-phone:addNotification', src, "Gas Station", "Transaction Failed", 'Insufficient funds for refueling.', 'fas fa-gas-pump', 10000)
    end
end)
