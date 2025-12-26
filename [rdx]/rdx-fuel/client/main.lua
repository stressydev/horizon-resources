local fuelConfig = require 'shared.main'
local nozzleModal = 'prop_cs_fuel_nozle'
local fakePump = 'bkr_prop_bkr_cash_roll_01'
local nozzleProp = nil
local enabledNozzle = false
local attachedRopes = {}
local attachedPump = {}
local isRefueling = false
local liters = 0
local pumpPrice = 1.459
local lastVehicle = cache.vehicle or GetPlayersLastVehicle()
local selectedPayment = 'cash'

local function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 185)
    SetTextEdge(1, 0, 0, 0, 250)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = string.len(text) / 340
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 155, 55, 55, 168)
end

local function loadAnimDict(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do Wait(0) end
    end
end

local function loadModel(model)
    if not HasModelLoaded(model) then
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(10)
        end
    end
end

local function loadRope()
    RopeLoadTextures()
    while not RopeAreTexturesLoaded() do
        Citizen.Wait(1)
    end
end


local function setFuel(vehState, vehicle, amount, replicate)
	if DoesEntityExist(vehicle) then
        amount = tonumber(amount) or 0
        amount = math.max(0, math.min(100, amount))
		SetVehicleFuelLevel(vehicle, amount)
		vehState:set('fuel', amount, replicate)
	end
end

exports.ox_target:addModel(fuelConfig.pumpModel, {
    {
        icon = "fas fa-gas-pump",
        label = 'Take Nozzle',
        distance = 2,
        onSelect = function(data)
            takeNozzle(data)
        end,
        canInteract = function(entity)
            return not nozzleProp
        end,
    },

    {
        icon = "fas fa-gas-pump",
        label = 'Return Nozzle',
        distance = 2,
        onSelect = function(data)
            returnNozzle()
        end,
        canInteract = function(entity)
            return nozzleProp and not isRefueling
        end,
    },
})

local currentVeh = nil

SetFuelConsumptionState(true)
SetFuelConsumptionRateMultiplier(fuelConfig.globalFuelConsumptionRate)

local function startDrivingVehicle()
	local vehicle = cache.vehicle

	if not DoesVehicleUseFuel(vehicle) then return end

	local vehState = Entity(vehicle).state

	if not vehState.fuel then
		vehState:set('fuel', GetVehicleFuelLevel(vehicle), true)
		while not vehState.fuel do Wait(0) end
	end

	--SetVehicleFuelLevel(vehicle, vehState.fuel)

	local fuelTick = 0

	while cache.seat == -1 do
		if GetIsVehicleEngineRunning(vehicle) then
			if not DoesEntityExist(vehicle) then return end
			SetFuelConsumptionRateMultiplier(fuelConfig.globalFuelConsumptionRate)

			local fuelAmount = tonumber(vehState.fuel)
			local newFuel = GetVehicleFuelLevel(vehicle)
			if fuelAmount > 0 then
				if GetVehiclePetrolTankHealth(vehicle) < 700 then
					newFuel -= math.random(10, 20) * 0.01
				end

				if fuelAmount ~= newFuel then
					if fuelTick == 15 then
						fuelTick = 0
					end
                    SetVehicleFuelLevel(vehicle,newFuel)
					--setFuel(vehState, vehicle, newFuel, fuelTick == 0)
					fuelTick += 1
				end
			end
		else
			if not DoesEntityExist(vehicle) then return end
			SetFuelConsumptionRateMultiplier(0.0)
		end
		Wait(1000)
	end

	--setFuel(vehState, vehicle, vehState.fuel, true)
end

if cache.seat == -1 then CreateThread(startDrivingVehicle) end

lib.onCache('seat', function(seat)
	if cache.vehicle then
		lastVehicle = cache.vehicle
	end

	if seat == -1 then
		SetTimeout(0, startDrivingVehicle)
	end
end)


function takeNozzle(data)
    local ped = cache.ped
    local entity = data.entity
    local pumpCoords = GetEntityCoords(entity)
    local pumpModel = GetEntityModel(entity)

    if DoesEntityExist(nozzleProp) then
        DeleteEntity(nozzleProp)
    end

    loadModel(nozzleModal)
    nozzleProp = CreateObject(nozzleModal, 0, 0, 0, true, true, true)

    AttachEntityToEntity(nozzleProp, ped, GetPedBoneIndex(ped, 0x49D9), 0.11, 0.02, 0.02, -80.0, -90.0, 15.0, true, true, false, true, 1, true)
    local netId = NetworkGetNetworkIdFromEntity(nozzleProp)
    TriggerServerEvent('rdx-fuel:attachRope', netId, pumpCoords, pumpModel)

    SendNUIMessage({
        action = 'openUI',
        price = pumpPrice
    })

    CreateThread(function()
        while nozzleProp do
            local sleep = 500
            ped = cache.ped
            local coords = GetEntityCoords(ped)
            local nozzleCoords = GetEntityCoords(nozzleProp)
            local veh = lib.getClosestVehicle(coords, 2.0, true)
            local dist = #(pumpCoords - nozzleCoords)

            if dist > 7.0 then
                nozzleProp = false
                AddExplosion(pumpCoords, 5, 50.0, true, false, true)
                returnNozzle()
            end

            if veh then
                local vehClass = GetVehicleClass(veh)
                local hash = GetHashKey(veh)
                local zPos = fuelConfig.nozzleBasedOnClass[vehClass + 1]
                local isBike = false
                local tankBone 

                local nozzleModifiedPosition = {
                    x = 0.0,
                    y = 0.0,
                    z = 0.0
                }
                local textModifiedPosition = {
                    x = 0.0,
                    y = 0.0,
                    z = 0.0
                }

                if vehClass == 8 and vehClass ~= 13 and not Shared.electricVehicles[hash] then
                    tankBone = GetEntityBoneIndexByName(veh, "petrolcap")
                    if tankBone == -1 then
                        tankBone = GetEntityBoneIndexByName(veh, "petroltank")
                    end
                    if tankBone == -1 then
                        tankBone = GetEntityBoneIndexByName(veh, "engine")
                    end
                    isBike = true
                elseif vehClass ~= 13 and not Shared.electricVehicles[hash] then
                    tankBone = GetEntityBoneIndexByName(veh, "petrolcap")
                    if tankBone == -1 then
                        tankBone = GetEntityBoneIndexByName(veh, "petroltank_l")
                    end
                    if tankBone == -1 then
                        tankBone = GetEntityBoneIndexByName(veh, "hub_lr")
                    end
                    if tankBone == -1 then
                        tankBone = GetEntityBoneIndexByName(veh, "handle_dside_r")
                        nozzleModifiedPosition.x = 0.1
                        nozzleModifiedPosition.y = -0.5
                        nozzleModifiedPosition.z = -0.6
                        textModifiedPosition.x = 0.55
                        textModifiedPosition.y = 0.1
                        textModifiedPosition.z = -0.2
                    end
                end

                local tankPosition = GetWorldPositionOfEntityBone(veh, tankBone)
                if tankPosition and #(coords - tankPosition) < 1.2 then
                    sleep = 1
                    DrawText3D(tankPosition.x + textModifiedPosition.x, tankPosition.y + textModifiedPosition.y, tankPosition.z + zPos + textModifiedPosition.z, isRefueling and "[E] Stop Refueling" or "[E] Refuel Vehicle")
                    if IsControlJustPressed(0, 38) then
                        if not isRefueling then
                            local plate = GetVehicleNumberPlateText(veh)
                            local input = lib.inputDialog('Plate #' ..plate, {
                                {
                                    type = 'select',
                                    label = 'Payment Method',
                                    options = {
                                        { label = 'Cash', value = 'cash' },
                                        { label = 'Bank', value = 'bank' }
                                    },
                                    required = true
                                }
                            })

                            if input then
                                selectedPayment = input[1]
                                isRefueling = true
                                if isBike then
                                    AttachEntityToEntity(nozzleProp, veh, tankBone, 0.0 + nozzleModifiedPosition.x, -0.2 + nozzleModifiedPosition.y, 0.2 + nozzleModifiedPosition.z, -80.0, 0.0, 0.0, true, true, false, false, 1, true)
                                else
                                    AttachEntityToEntity(nozzleProp, veh, tankBone, -0.18 + nozzleModifiedPosition.x, 0.0 + nozzleModifiedPosition.y, 0.75 + nozzleModifiedPosition.z, -125.0, -90.0, -90.0, true, true, false, false, 1, true)
                                end

                                refuelVehicle(veh)
                            end
                        else
                            isRefueling = false
                            ClearPedTasks(ped)
                            AttachEntityToEntity(nozzleProp, ped, GetPedBoneIndex(ped, 0x49D9), 0.11, 0.02, 0.02, -80.0, -90.0, 15.0, true, true, false, true, 1, true)
                            SendNUIMessage({ action = "stop_refuel" })
                        end
                    end
                end
            end
            Wait(sleep)
        end
    end)
end

RegisterNUICallback("stopRefuel", function(_, cb)
    if liters == 0 then return end
    local vehState = Entity(currentVeh).state
    local netId = NetworkGetNetworkIdFromEntity(currentVeh)
    TriggerServerEvent('rdx-fuel:pay', pumpPrice, math.ceil(vehState.fuel + liters), liters, netId, selectedPayment)
    cb({})
end)

function refuelVehicle(veh)
    ResetPump()
    currentVeh = veh

    local maxFuel, interval, totalTime = 100, 100, 15000
	local vehState = Entity(veh).state
	local fuel = vehState.fuel or GetVehicleFuelLevel(veh)
    local remaining = maxFuel - fuel

    if remaining <= 0 then return cancelRefueling() end

    liters = 0
    local fuelPerTick = remaining / (totalTime / interval)
    
    CreateThread(function()
        while isRefueling do
            Wait(interval)

            local add = fuelPerTick + (math.random() * 0.008)
            liters += add
            fuel += add
            -- force to add fuel
            Entity(veh).state:set("fuel", fuel, true)
            if fuel >= maxFuel then
                fuel = maxFuel
                TriggerEvent('stressy-phone:addNotification', "Gas Station", "Fuel Complete", ('Your vehicle tank is full! (%.2f liters filled)'):format(math.floor(liters)), 'fas fa-gas-pump', 10000)
                break
            end

            if isRefueling then
                SendNUIMessage({
                    action = 'refuel',
                    liters = liters,
                    price = pumpPrice
                })
            end
        end
    end)
end

function cancelRefueling()
    isRefueling = false
    ClearPedTasks(cache.ped)
    AttachEntityToEntity(nozzleProp, cache.ped, GetPedBoneIndex(cache.ped, 0x49D9), 0.11, 0.02, 0.02, -80.0, -90.0, 15.0, true, true, false, true, 1, true)
    SendNUIMessage({ action = "stop_refuel" })
end

function ResetPump()
    liters = 0
    SendNUIMessage({ action = "reset" })
end

function returnNozzle()
    print('RETURN NOZZLE')
    TriggerServerEvent('rdx-fuel:detachRope')
    if DoesEntityExist(nozzleProp) then
        DeleteEntity(nozzleProp)
    end
    nozzleProp = nil
    isRefueling = false
    ClearPedTasks(cache.ped)
    liters = 0
    SendNUIMessage({
        action = 'close',
    })
end

RegisterNetEvent('rdx-fuel:pAttachRope', function(src, networkId, pumpCoords, pumpModel)
    local netId = NetworkGetEntityFromNetworkId(networkId)
    if not DoesEntityExist(netId) then return end

    loadModel(fakePump)

    local object = CreateObject(fakePump, pumpCoords.x, pumpCoords.y, pumpCoords.z, true, true, false)
    if object ~= 0 then
        SetEntityRecordsCollisions(object, false)
        SetEntityLoadCollisionFlag(object, false)
        loadRope()
        Wait(100)   
        local ropeId = AddRope(pumpCoords.x, pumpCoords.y, pumpCoords.z, 0.0, 0.0, 0.0, 2.0, 4, 1000.0, 0.0, 2.0, false, false, false, 1.0, true)
        while not ropeId do Wait(0) end

        ActivatePhysics(ropeId)
        local nozzleCoords = GetOffsetFromEntityInWorldCoords(netId, 0.0, -0.019, -0.1749)

        AttachEntitiesToRope(ropeId, object, netId, pumpCoords.x, pumpCoords.y, pumpCoords.z + fuelConfig.pumpOffset[pumpModel], nozzleCoords.x, nozzleCoords.y, nozzleCoords.z, 5.0, false, false, nil, nil)
        attachedRopes[src] = ropeId
        attachedPump[src] = object
    end
end)

RegisterNetEvent('rdx-fuel:pDetachRope', function(source)
    if attachedRopes[source] then
        DeleteRope(attachedRopes[source])
    end
   
    if attachedPump[source] then
        DeleteEntity(attachedPump[source])
    end
end)

