local function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(100)
    end
end

local function loadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(10)
    end
end

local function disableKeys()
    DisableControlAction(0, 157, true)
    DisableControlAction(0, 158, true)
    DisableControlAction(0, 160, true)
    DisableControlAction(0, 164, true)
    DisableControlAction(0, 165, true)

    DisableControlAction(0, 24, true) -- Attack
    DisableControlAction(0, 257, true) -- Attack 2
    DisableControlAction(0, 25, true) -- Aim
    DisableControlAction(0, 263, true) -- Melee Attack 1
    DisableControlAction(0, 38, true)
    DisableControlAction(0, 21, true) -- Lshift (fault in Keys table!)
    DisableControlAction(0, 29, true)
    DisableControlAction(0, 47, true)-- Disable weapon
    DisableControlAction(0, 264, true) -- Disable melee
    DisableControlAction(0, 257, true) -- Disable melee
    DisableControlAction(0, 140, true) -- Disable melee
    DisableControlAction(0, 141, true) -- Disable melee
    DisableControlAction(0, 142, true) -- Disable melee
    DisableControlAction(0, 143, true) -- Disable melee
    DisableControlAction(0, 75, true)-- Disable exit vehicle
    DisableControlAction(27, 75, true) -- Disable exit vehicle
end
------------------HANDCUFF-------------------------
local cuffObject = 0
local isHandcuffed = false

local function toggleHandcuff(ped, enable)
    SetEnableHandcuffs(ped, enable)
    DisablePlayerFiring(ped, enable)
    SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), enable)
    DisplayRadar(enable)
    TriggerServerEvent('rdx-playertarget:toggleHandcuff', enable)
end

RegisterNetEvent('rdx-playertarget:handcuffAnim', function()
    local ped = cache.ped
    local animDict = 'mp_arrest_paired'

    loadAnimDict(animDict)

    TaskPlayAnim(ped, animDict, 'cop_p2_back_right', 8.0, -8, 5000, 49, 0, 0, 0, 0)	
    RemoveAnimDict(animDict)
end)

RegisterNetEvent('rdx-playertarget:handcuffTarget', function(target)
    if isHandcuffed then return end
    
	local ped = cache.ped
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))

    if DoesEntityExist(cuffObject) then DeleteEntity(cuffObject) end

    ClearPedTasks(ped)
	ClearPedSecondaryTask(ped)

    AttachEntityToEntity(ped, targetPed, 0, 0.0, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
    
    loadAnimDict('mp_arrest_paired')

    TaskPlayAnim(ped, "mp_arrest_paired", "crook_p2_back_right", 8.0, -8, 5000, 01, 0, 0, 0, 0)
    RemoveAnimDict('mp_arrest_paired')

    DetachEntity(ped, true, false)

    local isResisted = false

    local success = lib.skillCheck({{areaSize = math.random(20, 30), speedMultiplier = 0.75}}, {'w', 'a', 's', 'd'})
    if success then
        lib.notify({ title = 'Cuffs', description = "You resisted from getting cuff.", type = "success", position = "bot-center" })
        isResisted = true
    end

    Citizen.Wait(2500)

    if isResisted then
        return toggleHandcuff(ped, false)
    end

    isHandcuffed = true

    loadAnimDict('mp_arresting')

    TaskPlayAnim(ped, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
    RemoveAnimDict('mp_arresting')

    toggleHandcuff(ped, true)

    CreateThread(function()
        while isHandcuffed do
            Wait(1)
            local playerPed = cache.ped
            
            if not IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) then
                loadAnimDict('mp_arresting')
                TaskPlayAnim(playerPed, "mp_arresting", "idle", 8.0, -8, -1, 49, 0, 0, 0, 0)	
                RemoveAnimDict('mp_arresting')
            end			
            
            if not DoesEntityExist(cuffObject) then
                local model = 'p_cs_cuffs_02_s'
                loadModel(model)

                cuffObject = CreateObject(model, GetEntityCoords(playerPed), true)
                AttachEntityToEntity(cuffObject, playerPed, GetPedBoneIndex(playerPed, 60309), -0.055, 0.06, 0.04, 265.0, 155.0, 80.0, true, false, false, false, 0, true);
            end
        end

        ClearPedTasks(ped)
        ClearPedSecondaryTask(ped)
    end)	
end)


RegisterNetEvent('rdx-playertarget:uncuffAnimation', function()
    local ped = cache.ped
    local animDict = 'mp_arresting'

    loadAnimDict(animDict)

    TaskPlayAnim(ped, "mp_arresting", "a_uncuff", 8.0, -8, 5000, 01, 0, 0, 0, 0)
    RemoveAnimDict(animDict)
end) 

RegisterNetEvent('rdx-playertarget:uncuffTarget', function(target)
    local ped = cache.ped
    local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
    local animDict = 'mp_arresting'

    AttachEntityToEntity(ped, targetPed, 0, 0.0, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)

    loadAnimDict(animDict, 10)

    AttachEntityToEntity(ped, targetPed, 0, 0.0, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)

    TaskPlayAnim(ped, animDict, 'b_uncuff', 8.0, -8, 5000, 01, 0, 0, 0, 0)
    RemoveAnimDict(animDict)

    DetachEntity(ped, true, false)

    Citizen.Wait(5000)

    isHandcuffed = false

    if DoesEntityExist(cuffObject) then DeleteEntity(cuffObject) end

    toggleHandcuff(ped, false)
end)

------------------------ESCORT--------------------------

local isEscorting = false
local isBeingEscort = false

local escortAnimDict = 'amb@world_human_drinking@coffee@female@base'
local escortAnim = 'base'

local function unEscortPlayer(targetId)
    isEscorting = false
    TriggerServerEvent('rdx-playertarget:unescortTarget', targetId)
end

AddEventHandler('rdx-playertarget:escortTarget', function(entity)
    if isEscorting then return end
    isEscorting = true

    local ped = cache.ped
    local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))

    TriggerServerEvent('rdx-playertarget:escortTartPlayer', targetId)

    lib.showTextUI("[E] to Unescort", {
        position = "left-center",
    })

    CreateThread(function()
        loadAnimDict(escortAnimDict)
        TaskPlayAnim(ped, escortAnimDict, escortAnim, 3.0, -3.0, -1, 49, 0.0, false, false, false)

        while isEscorting do
            if IsControlPressed(0, 38) then
                unEscortPlayer(targetId)
            end

            if IsPedInAnyVehicle(ped, false) then
                unEscortPlayer(targetId)
            end

            if not IsEntityPlayingAnim(ped, escortAnimDict, escortAnim, 3) then
                TaskPlayAnim(ped, escortAnimDict, escortAnim, 3.0, -3.0, -1, 49, 0.0, false, false, false)
            end

            Wait(10)
        end

        lib.hideTextUI()
        StopAnimTask(ped, escortAnimDict, escortAnim, 1.0)
        RemoveAnimDict(escortAnimDict)
    end)
end)

RegisterNetEvent('rdx-playertarget:escortMe', function(targetId)
    if isBeingEscort then return end
    isBeingEscort = true

    local ped = cache.ped
    local targetPed = GetPlayerPed(GetPlayerFromServerId(targetId))

    local moveDict = "move_m@casual@c"

    CreateThread(function()
        loadAnimDict(moveDict)

        while isBeingEscort do
            disableKeys()
            if DoesEntityExist(targetPed) and not IsPedDeadOrDying(targetPed, true) then
                if not IsEntityAttachedToEntity(ped, targetPed) then
                    AttachEntityToEntity(
                        ped, targetPed, 11816,
                        0.38, 0.4, 0.0,
                        0.0, 0.0, 0.0,
                        false, false, true, true, 2, true
                    )
                end

                if IsPedWalking(targetPed) then
                    if not IsEntityPlayingAnim(ped, moveDict, "walk", 3) then
                        TaskPlayAnim(ped, moveDict, "walk", 8.0, -8.0, -1, 1, 0.0, false, false, false)
                    end

                elseif IsPedRunning(targetPed) or IsPedSprinting(targetPed) then
                    if not IsEntityPlayingAnim(ped, moveDict, "run", 3) then
                        TaskPlayAnim(ped, moveDict, "run", 8.0, -8.0, -1, 1, 0.0, false, false, false)
                    end
                else
                    StopAnimTask(ped, moveDict, "walk", -4.0)
                    StopAnimTask(ped, moveDict, "run", -4.0)
                end
            else
                isBeingEscort = false
                break
            end

            Wait(0)
        end

        DetachEntity(ped, true, false)
        StopAnimTask(ped, moveDict, "walk", -4.0)
        StopAnimTask(ped, moveDict, "run", -4.0)
        RemoveAnimDict(moveDict)
    end)
end)

RegisterNetEvent('rdx-playertarget:unescortMe', function()
    if not isBeingEscort then return end
    isBeingEscort = false
end)
