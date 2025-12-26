RegisterNetEvent('rdx-playertarget:pTakeHostage', function(target)
    local src = source
    local targetId = tonumber(target)
    local Target = exports.qbx_core:GetPlayer(targetId)

    if not Target then return end

    TriggerClientEvent('rdx-playertarget:pHostageTarget', Target.PlayerData.source, src)
end)

RegisterNetEvent('rdx-playertarget:releaseHostage', function(target)
    local src = source
    local targetId = tonumber(target)
    local Target = exports.qbx_core:GetPlayer(targetId)

    if not Target then return end

    TriggerClientEvent('rdx-playertarget:pReleaseHostage', Target.PlayerData.source)
end)
