local isCarrying = false
local carryAnimDict = 'missfinale_c2mcs_1'
local carryAnim = 'fin_c2_mcs_1_camman'

local targetAnimDict = 'amb@world_human_bum_slumped@male@laying_on_left_side@base'
local targetAnim = 'base'

local function loadAnim(dict)
    if HasAnimDictLoaded(dict) then return end

    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(50)
    end
end

--DetachEntity(cache.ped, true, false)
local function stopCarry()
    local ped = cache.ped
		if IsPlayerDead(PlayerId()) then
			ClearPedTasks(ped)
			isCarrying = false
			DetachEntity(ped, true, false)
			return
		end

    isCarrying = false
		DetachEntity(ped, true, false)
		loadAnim('get_up@directional@movement@from_knees@action')
		TaskPlayAnim(ped, 'get_up@directional@movement@from_knees@action', 'getup_r_0', 8.0, -8.0, -1, 0, 0, 0, 0, 0)		
    lib.hideTextUI()
end

AddEventHandler('rdx-resources:carryPlayer', function(targetPed)
    if isCarrying or not DoesEntityExist(targetPed) then return end

    local targetServerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(targetPed))

    isCarrying = true

    lib.showTextUI('[H] toggle Carry', {
        position = 'left-center'
    })

    TriggerServerEvent('rdx-resources:pCarryPlayer', targetServerId)

    CreateThread(function()
        loadAnim(carryAnimDict)

        while isCarrying do
            local ped = cache.ped
            	
            if not IsEntityPlayingAnim(ped, carryAnimDict, carryAnim, 3) then
                TaskPlayAnim(
                    ped,
                    carryAnimDict,
                    carryAnim,
                    3.0, -3.0, -1,
                    49, 0, false, false, false
                )
            end

            if IsPedInAnyVehicle(ped, false) or IsPedInAnyVehicle(targetPed, false) then
                TriggerServerEvent('rdx-resources:uncarryPlayer', targetServerId)
                break
            end

            if IsControlJustPressed(0, 74)  then
                isCarrying = false
                TriggerServerEvent('rdx-resources:uncarryPlayer', targetServerId)
            end	

            Wait(0)
        end

        isCarrying = false
        lib.hideTextUI()
        ClearPedTasks(cache.ped)
        RemoveAnimDict(carryAnimDict)
    end)
end)

RegisterNetEvent('rdx-playertarget:carryMe', function(carrierServerId)
    if isCarrying then return end

    local carrierPed = GetPlayerPed(GetPlayerFromServerId(carrierServerId))
    if not DoesEntityExist(carrierPed) then return end

    isCarrying = true

    CreateThread(function()
        loadAnim(targetAnimDict)

        while isCarrying do
            local ped = cache.ped

            if not DoesEntityExist(carrierPed) then
                isCarrying = false
            end

            if not IsEntityPlayingAnim(ped, targetAnimDict, targetAnim, 3) then
                TaskPlayAnim(ped,targetAnimDict,targetAnim,8.0, -8.0, -1, 1, 0, false, false, false)
            end

            if not IsEntityAttached(ped) then
                AttachEntityToEntity(ped, carrierPed, 1, -0.68, -0.2, 0.94, 180.0, 180.0, 60.0, 1, 1, 0, 1, 0, 1)
            end

            Wait(0)
        end

        stopCarry()
        StopAnimTask(ped, targetAnimDict, targetAnim, 3.0)
        RemoveAnimDict(targetAnimDict)
    end)
end)

RegisterNetEvent('rdx-resources:unCarryMe', function()
    stopCarry()
end)
