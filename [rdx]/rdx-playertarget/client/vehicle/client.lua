
AddEventHandler('rdx-playertarget:seatVeh', function(entity)
    local target = entity
    local ped = cache.ped
    local pos = GetEntityCoords(ped)
    local veh = lib.getClosestVehicle(pos, 5.0)
    
    if not DoesEntityExist(veh) then return end

    local netid = NetworkGetNetworkIdFromEntity(veh)

    if lib.progressBar({
        duration = 5000,
        label = 'Seat',
        useWhileDead = false,
        canCancel = true,
        disable = { move = true, car = true, combat = true }
    }) 
    then
        TriggerServerEvent('rdx-playertarget:putInVehicle',GetPlayerServerId(NetworkGetPlayerIndexFromPed(target)),netid)
    end
end)

AddEventHandler('rdx-playertarget:unseatVeh', function(entity)
    local veh = entity
    if not DoesEntityExist(veh) then return end

    local coords = GetEntityCoords(cache.ped)
    local maxSeats = GetVehicleMaxNumberOfPassengers(veh)

    for seat = -1, maxSeats - 1 do
        local ped = GetPedInVehicleSeat(veh, seat)

        if ped ~= 0 and IsPedAPlayer(ped) then
            if lib.progressBar({
                duration = 5000,
                label = 'Unseat',
                useWhileDead = false,
                canCancel = true,
                disable = { move = true, car = true, combat = true }
            }) 
            then
                local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(ped))
                TriggerServerEvent('rdx-playertarget:OutVehicle', targetId, coords)
            end
        end
    end
end)

RegisterNetEvent('rdx-playertarget:putInveh', function(netid)
    local ped = cache.ped
    local veh = NetworkGetEntityFromNetworkId(netid)

    if not DoesEntityExist(veh) then return end
    if not IsEntityAVehicle(veh) then return end

    for seat = GetVehicleMaxNumberOfPassengers(veh) - 1, 0, -1 do
        if IsVehicleSeatFree(veh, seat) then
            SetPedIntoVehicle(ped, veh, seat)
            return
        end
    end
end)

RegisterNetEvent('rdx-playertarget:outVeh', function(coords)
    local ped = cache.ped

    if not IsPedSittingInAnyVehicle(ped) then return end

    local veh = GetVehiclePedIsIn(ped, false)

	ClearPedTasksImmediately(ped)
    TaskLeaveVehicle(ped, veh, 256)

	SetEntityCoords(ped, coords.x, coords.y, coords.z, false, false, false, false)
end)
