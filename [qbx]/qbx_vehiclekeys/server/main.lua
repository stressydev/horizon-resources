local config = require 'config.server'

---@param veh number
---@param state string
local function setLockState(veh, state)
	if type(state) ~= 'string' or not DoesEntityExist(veh) then return end
    local vehicleConfig = GetVehicleConfig(veh)
    if vehicleConfig.noLock or vehicleConfig.shared then return end
    Entity(veh).state:set('doorslockstate', state == 'lock' and 2 or 1, true)
end
exports('SetLockState', setLockState)

lib.callback.register('qbx_vehiclekeys:server:findKeys', function(source, netId)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if math.random() <= GetVehicleConfig(vehicle).findKeysChance then
        GiveKeys(source, vehicle)
        exports['stressy-levels']:AddXP(source , 'criminal' , 1)
        return true
    end
end)

lib.callback.register('qbx_vehiclekeys:server:carjack', function(source, netId, weaponTypeGroup)
    local chance = config.carjackChance[weaponTypeGroup] or 0.5
    if math.random() <= chance then
        local vehicle = NetworkGetEntityFromNetworkId(netId)
        GiveKeys(source, vehicle)
        setLockState(vehicle, 'unlock')
        exports['stressy-levels']:AddXP(source , 'criminal' , 1)
        return true
    end
end)

RegisterNetEvent('qbx_vehiclekeys:server:playerEnteredVehicleWithEngineOn', function(netId)
    local src = source
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if not GetIsVehicleEngineRunning(vehicle) then return end
    GiveKeys(src, vehicle)
end)

---TODO: secure this event
RegisterNetEvent('qbx_vehiclekeys:server:tookKeys', function(netId)
    GiveKeys(source, NetworkGetEntityFromNetworkId(netId))
    exports['stressy-levels']:AddXP(source , 'criminal' , 1)
end)

---TODO: secure this event
RegisterNetEvent('qbx_vehiclekeys:server:hotwiredVehicle', function(netId)
    GiveKeys(source, NetworkGetEntityFromNetworkId(netId))
    exports['stressy-levels']:AddXP(source , 'criminal' , 1)
end)

RegisterNetEvent('qb-vehiclekeys:server:breakLockpick', function(itemName)
    if not (itemName == 'lockpick' or itemName == 'advancedlockpick') then return end
    exports.ox_inventory:RemoveItem(source, itemName, 1)
    exports['stressy-levels']:AddXP(source , 'criminal' , 1)
end)

RegisterNetEvent('qb-vehiclekeys:server:setVehLockState', function(netId, state)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
	if type(state) ~= 'number' or not DoesEntityExist(vehicle) then return end
    if state == 2 then state = 'lock' else state = 'unlock' end
	setLockState(vehicle, state)

end)


-- Remove broken item securely
RegisterNetEvent('qbx_vehiclekeys:removeBrokenItem', function(resourceName, itemName, slot)
    local src = source

    if resourceName ~= 'qbx_vehiclekeys' then
        print(('Blocked removeBrokenItem from %s (player %d)'):format(resourceName, src))
        return
    end
    -- Extra sanity checks
    if type(itemName) ~= 'string' or type(slot) ~= 'number' then
        print(('Invalid parameters for removeBrokenItem from player %d'):format(src))
        return
    end
     exports.ox_inventory:RemoveItem(src, itemName, 1, nil, slot)
end)

lib.callback.register('qbx_vehiclekeys:setItemMetadata', function(source, slot, metadata)
    local Player = exports.qbx_core:GetPlayer(source)
    if not Player then return false end
    
    local success = exports.ox_inventory:SetMetadata(source, slot, metadata)
    exports['stressy-levels']:AddXP(source , 'criminal' , 1)
    return success
end)

-- Return current OS time (seconds since epoch)
lib.callback.register('qbx_vehiclekeys:getOsTime', function(source)
    -- Use os.time() for a simple epoch timestamp
    return os.time()
end)
