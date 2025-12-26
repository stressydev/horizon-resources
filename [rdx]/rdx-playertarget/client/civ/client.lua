local isHostageTaking = false
local thAnimDict = 'anim@gangops@hostage@'

local function loadAnim(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(100)
    end
end

local AllowedWeapons = {
    `WEAPON_PISTOL`,
    `WEAPON_COMBATPISTOL`,
    `WEAPON_GLOCK`,
    `WEAPON_HEAVYPISTOL`,
    `WEAPON_SNSPISTOL`,
    `WEAPON_VINTAGEPISTOL`,
    `WEAPON_APPISTOL`
}


AddEventHandler('rdx-playertarget:thPlayer', function(entity)
    local pEntity = entity
    local targetId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(pEntity))

	local canTakeHostage = false
	for i=1, #AllowedWeapons do
		if HasPedGotWeapon(cache.ped, AllowedWeapons[i], false) then
			if GetAmmoInPedWeapon(cache.ped, AllowedWeapons[i]) > 0 then
				canTakeHostage = true 
				break
			end 					
		end
	end
    
	if not canTakeHostage then return lib.notify({ description = 'You need a valid weapon with ammo to take a hostage.',type = 'error',duration = 4000}) end

    isHostageTaking = true

    lib.showTextUI('[H] to release hostage', {
        position = "left-center",
    })

    loadAnim(thAnimDict)

    TriggerServerEvent('rdx-playertarget:pTakeHostage', targetId)

    while isHostageTaking do
        local ped = cache.ped

        if IsControlJustPressed(0, 74) then
            isHostageTaking = false
            TriggerServerEvent('rdx-playertarget:releaseHostage', targetId)

            loadAnim('reaction@shove')
            TaskPlayAnim(ped, "reaction@shove", "shove_var_a", 8.0, -8.0, -1, 168, 0, false, false, false)

            Citizen.Wait(1000)
            ClearPedTasks(ped)
            RemoveAnimDict("reaction@shove")
        end

        if not IsEntityPlayingAnim(ped, thAnimDict, 'perp_idle', 3) and isHostageTaking then    
            TaskPlayAnim(ped, thAnimDict, 'perp_idle', 8.0, -8.0, -1, 49, 0, false, false, false)
        end

        Citizen.Wait(0)
    end

    RemoveAnimDict(thAnimDict)
    lib.hideTextUI()
end)

RegisterNetEvent('rdx-playertarget:pHostageTarget', function(entity)
    if isHostageTaking then return end
    
    isHostageTaking = true

    local targetPed = GetPlayerPed(GetPlayerFromServerId(entity))

    loadAnim(thAnimDict)

    while isHostageTaking do
        local ped = cache.ped
        if not IsEntityPlayingAnim(ped, thAnimDict, 'victim_idle', 3) then
            TaskPlayAnim(ped, thAnimDict, 'victim_idle', 8.0, -8.0, -1, 33, 0, false, false, false)
        end

        if not IsEntityAttached(ped) then
            AttachEntityToEntity(ped, targetPed, 0, -0.3, 0.10, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
        end

        Wait(300)
    end

    DetachEntity(cache.ped, true, false)

    StopAnimTask(cache.ped, thAnimDict, 'victim_idle', 3.0)
    RemoveAnimDict(thAnimDict)
end)

RegisterNetEvent('rdx-playertarget:pReleaseHostage', function()
    isHostageTaking = false

    loadAnim('reaction@shove')
    TaskPlayAnim(cache.ped, "reaction@shove", "shoved_back", 8.0, -8.0, -1, 0, 0, false, false, false)

    Citizen.Wait(1000)
    ClearPedTasks(cache.ped)
    RemoveAnimDict("reaction@shove")
end)






