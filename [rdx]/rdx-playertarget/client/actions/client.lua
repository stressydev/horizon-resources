local rdxActions = {}

rdxActions["search"] = function(data)
    local ped = data.entity
    local serverId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(ped))

    if lib.progressBar({
        duration = 10000,
        position = "bottom",
        disable = { move = true },
        anim = { dict = "missexile3", clip = "ex03_dingy_search_case_a_michael" },
        label = "Searching...",
    }) then
        TriggerServerEvent('rdx-playertarget:searchPlayer', serverId)
    end
end

rdxActions["handcuffs"] = function(data)
    local ped = data.entity
    local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(ped))
    if IsPedCuffed(ped) then
        TriggerServerEvent('rdx-playertarget:uncuffPlayer', targetId)
    else
        if not IsEntityPlayingAnim(ped, 'handsup_base', 'missminuteman_1ig_2', 3) then
            return
        end
        
        TriggerServerEvent('rdx-playertarget:handcuffPlayer', targetId)
    end
end

rdxActions["escort"] = function(data)
    local ped = data.entity

    if IsPedCuffed(ped) then
        TriggerEvent('rdx-playertarget:escortTarget', ped)
    end
end

rdxActions["ems_escort"] = function(data)
    local ped = data.entity

    if IsPedCuffed(ped) then
        TriggerEvent('rdx-playertarget:escortTarget', ped)
    end
end

rdxActions["seat"] = function(data)
    local ped = data.entity
    TriggerEvent('rdx-playertarget:seatVeh', ped)
end

rdxActions["revive"] = function(data)
    local ped = data.entity
    local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(ped))
    if not targetId then return end

    local isDead, lastStand = lib.callback.await('rdx-playertarget:canRevive', false, targetId)
    if not (isDead or lastStand) then return end

    local animDict = lastStand and 'amb@world_human_bum_wash@male@low@idle_a' or 'mini@cpr@char_a@cpr_str'
    local animClip = lastStand and 'idle_a' or 'cpr_pumpchest'
    local labelText = lastStand and 'Treating Wounds...' or 'Reviving Player...'

    if lib.progressBar({
        duration = 5000,
        position = 'bottom',
        label = labelText,
        disable = { move = true, combat = true, car = true },
        anim = { dict = animDict, clip = animClip, flag = 1 },
        canCancel = true
    }) then
        TriggerServerEvent('hospital:server:RevivePlayer', targetId)
    end
end

rdxActions["treat"] = function(data)
    local ped = data.entity
    local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(ped))
    if not targetId then return end

    if lib.progressBar({
        duration = 5000,
        position = 'bottom',
        label = 'Treating Wounds...',
        disable = { move = true, combat = true, car = true },
        anim = { dict = 'amb@world_human_bum_wash@male@low@idle_a', clip = 'idle_a', flag = 1 },
        canCancel = true
    }) then
        TriggerServerEvent('hospital:server:TreatWounds',targetId)
    end
end

rdxActions["takehostage"] = function(data)
    local ped = data.entity

    TriggerEvent('rdx-playertarget:thPlayer', ped)
end

rdxActions["recovery"] = function(data)
    local ped = data.entity
    local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(ped))
    if not targetId then return end

    local input = lib.inputDialog('Recovery', {
    {type = 'number', label = 'Duration', description = '(ex. 1 = 1 minute)', icon = 'hashtag'},
    })

    if not input then return end

    local pAmount = tonumber(input[1])
    TriggerServerEvent('rdx-playertarget:setRecovery', pAmount, targetId)
end

rdxActions["carry"] = function(data)
    local ped = data.entity
    TriggerEvent('rdx-resources:carryPlayer', ped)
end

AddEventHandler('rdx-playertarget:rdxActions', function(data)
    if not data or not data.action then return end

    local func = rdxActions[data.action]
    if func then
        func(data)
    end
end)