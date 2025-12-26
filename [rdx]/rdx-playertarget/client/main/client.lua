local pConfig = require 'shared.main'

local function InitTarget()
    local job = QBX.PlayerData.job
    if pConfig[job.name] then
        exports.ox_target:addGlobalPlayer(pConfig[job.name])
    end
    
    exports.ox_target:addGlobalPlayer(pConfig.general)    
end

CreateThread(function()
    while not LocalPlayer.state.isLoggedIn do
        Wait(5000)
    end

    InitTarget()
end)