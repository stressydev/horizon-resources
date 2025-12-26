CreateThread(function()
    while true do
        local ped = PlayerPedId()
        SetPedSuffersCriticalHits(ped, false)
        Wait(1)
    end
end)