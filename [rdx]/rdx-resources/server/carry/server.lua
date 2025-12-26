RegisterNetEvent('rdx-resources:pCarryPlayer', function(targetId)
    local src = source
    TriggerClientEvent('rdx-playertarget:carryMe', targetId, src)
end)

RegisterNetEvent('rdx-resources:uncarryPlayer', function(targetId)
    TriggerClientEvent('rdx-resources:unCarryMe', targetId)
end)