local function isTargetNear(src, targetId, maxDist)
    local ped1 = GetPlayerPed(src)
    local ped2 = GetPlayerPed(targetId)

    if not ped1 or not ped2 then
        return false
    end

    local c1 = GetEntityCoords(ped1)
    local c2 = GetEntityCoords(ped2)

    return #(c1 - c2) <= maxDist
end

exports('isTargetNear', isTargetNear)

------------------HANCUFF-----------------
RegisterNetEvent('rdx-playertarget:handcuffPlayer', function(targetId)
    local src = source
    if not isTargetNear(src, targetId, 5.0) then return end

    local _, item = next(exports.ox_inventory:Search(src, 'slots', 'handcuffs'))
    if not item then
        TriggerClientEvent('ox_lib:notify', src, {
            type = 'error',
            description = 'You do not have any handcuffs.'
        })
        return
    end

    local slot = item.slot
    local meta = item.metadata or {}
    local full = (meta.degrade or 0) * 60
    local now = os.time()

    meta.durability = meta.durability - full * 0.25

    exports.ox_inventory:SetMetadata(src, slot, meta)

    if now >= meta.durability then
        exports.ox_inventory:RemoveItem(src, 'handcuffs', 1, nil, slot)
        TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = 'Your Handcuffs has worn out and can no longer be used.' })
    end

    TriggerClientEvent('rdx-playertarget:handcuffTarget', targetId, src)
    TriggerClientEvent('rdx-playertarget:handcuffAnim', src)
end)



RegisterNetEvent('rdx-playertarget:uncuffPlayer', function(targetId)
    local src = source

    if not isTargetNear(src, targetId, 5.0) then return end

    TriggerClientEvent('rdx-playertarget:uncuffTarget', targetId, src)
    TriggerClientEvent('rdx-playertarget:uncuffAnimation', src)
end)

RegisterNetEvent('rdx-playertarget:toggleHandcuff', function(isHandcuffed)
    local src = source
    local Player = exports.qbx_core:GetPlayer(source)

    if not Player then return end

    print(isHandcuffed, 'handcuff')
    Player.Functions.SetMetaData('ishandcuffed', isHandcuffed)
end)

------------------ESCORT------------------
RegisterNetEvent('rdx-playertarget:escortTartPlayer', function(targetId)
    local src = source
    TriggerClientEvent('rdx-playertarget:escortMe', targetId, src)
end)

RegisterNetEvent('rdx-playertarget:unescortTarget', function(targetId)
    local src = source
    TriggerClientEvent('rdx-playertarget:unescortMe', targetId)
end)

------------------SEARCH------------------
RegisterNetEvent('rdx-playertarget:searchPlayer', function(id)
    local src = source
    local trc = tonumber(id) 
    local Player = exports.qbx_core:GetPlayer(src)
    local Target = exports.qbx_core:GetPlayer(trc) 

    if not Target then return end

    exports.ox_inventory:forceOpenInventory(src, 'player', trc)
end)

