lib.callback.register('rdx-playertarget:canRevive', function(source, target)
    local targetId = tonumber(target)
	local Target = exports.qbx_core:GetPlayer(targetId)

    if not Target then return end
    
    return Target.PlayerData.metadata.isdead, Target.PlayerData.metadata.inlaststand
end)


RegisterNetEvent('rdx-playertarget:setRecovery', function(duration, target)
    local src = source
    local targetId = tonumber(target)
    local Target = exports.qbx_core:GetPlayer(targetId)

    if not Target then return end

    if not exports['rdx-playertarget']:isTargetNear(src, targetId, 5.0) then return end

    TriggerClientEvent('rdx-playertarget:recoveryTime', Target.PlayerData.source, duration)
end)