AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() or resourceName == 'ox_inventory' then
        local hookId = exports.ox_inventory:registerHook('swapItems', function(payload)

            if payload.toType == 'player' then
                return true
            end

            if payload.fromType == payload.toType then
                return true
            end

            if payload.fromInventory == payload.toInventory then
                return true
            end
            return false
        end, {
            print = false,
            itemFilter = {
                money = true,
            },
        })
    end
end)