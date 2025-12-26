local isRecovering = false
local CurrentWeapon, crutchObject, lastWalk

AddEventHandler('ox_inventory:currentWeapon', function(weapon)
    CurrentWeapon = weapon
end)

local function spawnCrutch(ped)
    local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(ped, 0.0, 2.0, 0.55))
    lib.requestModel('crutch', 100)
    crutchObject = CreateObjectNoOffset('crutch', x, y, z, true, false)
    SetModelAsNoLongerNeeded('crutch')
    AttachEntityToEntity(crutchObject, ped, GetPedBoneIndex(ped, 43810),
        0.93, -0.15, -0.03, 9.31, -88.64, 177.48, true, true, false, true, 1, true)
    lib.requestAnimSet('move_lester_caneup', 100)
end

local function deleteCrutch()
    if DoesEntityExist(crutchObject) then DeleteEntity(crutchObject) end
end

RegisterNetEvent('rdx-playertarget:recoveryTime', function(duration)
    if isRecovering then return end
    isRecovering = true

    local recoveryTime = duration * 60000
    local startTime = GetGameTimer()
    lastWalk = GetPedMovementClipset(cache.ped)

    CreateThread(function()
        while isRecovering do
            local ped = cache.ped

            if CurrentWeapon then TriggerEvent('ox_inventory:disarm', true) end

            if not DoesEntityExist(crutchObject) and not IsPedRagdoll(ped) then spawnCrutch(ped) end

            local elapsed = GetGameTimer() - startTime
            local remaining = math.max(0, recoveryTime - elapsed)
            lib.showTextUI(("Recovering... %dm %02ds remaining"):format(math.floor(remaining / 60000), math.floor((remaining % 60000) / 1000)), {
                position = "top-center",
                icon = 'fa-solid fa-heart-pulse',
                style = { backgroundColor='#1e1e1e', color='#fff', padding='8px 14px', fontSize='16px' }
            })

            if GetPedMovementClipset(ped) == lastWalk then
                SetPedMovementClipset(ped, 'move_lester_caneup', 1.0)
            end

            if IsPedRunning(ped) or IsPedSprinting(ped) or IsPedJumping(ped) then
                deleteCrutch()
                ShakeGameplayCam("MEDIUM_EXPLOSION_SHAKE", 0.30)
                ClearPedTasks(ped)
                SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
				lib.notify({
					description = 'You shouldn’t be movin’ that much. Rest up before you keel over again.',
					type = 'error',
					position = 'center-right',
					icon = 'fa-solid fa-heart-pulse'
				})
            end	

            if elapsed >= recoveryTime then
                ResetPedMovementClipset(ped, 1.0)
                isRecovering = false
                deleteCrutch()
                lib.hideTextUI()
                lib.notify({
                    description = 'You feel rested and ready to hit the trail again.',
                    type = 'success',
                    position = 'center-right',
                    icon = 'fa-solid fa-heart-pulse'
                })
            end

            Wait(1000)
        end
    end)
end)
