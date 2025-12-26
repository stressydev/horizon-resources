Shared = {}

Shared.globalFuelConsumptionRate = 10.0

Shared.pumpOffset = {
    [-2007231801] = 2.3,
    [1339433404] = 2.3,
    [1694452750] = 2.3,
    [1933174915] = 2.3,
    [-462817101] = 1.8,
    [-469694731] = 1.6,
    [-164877493] = 1.6,
}

Shared.nozzleBasedOnClass = {
    0.65, -- Compacts
    0.65, -- Sedans
    0.85, -- SUVs
    0.6, -- Coupes
    0.55, -- Muscle
    0.6, -- Sports Classics
    0.6, -- Sports
    0.55, -- Super
    0.12, -- Motorcycles
    0.8, -- Off-road
    0.7, -- Industrial
    0.6, -- Utility
    0.7, -- Vans
    0.0, -- Cycles
    0.0, -- Boats
    0.0, -- Helicopters
    0.0, -- Planes
    0.6, -- Service
    0.65, -- Emergency
    0.65, -- Military
    0.75, -- Commercial
    0.0 -- Trains
}

Shared.pumpModel = {
    `prop_gas_pump_old2`,
    `prop_gas_pump_1a`,
    `prop_vintage_pump`,
    `prop_gas_pump_old3`,
    `prop_gas_pump_1c`,
    `prop_gas_pump_1b`,
    `prop_gas_pump_1d`,
}

Shared.electricVehicles = {
    `Imorgon`,
    `Neon`,
    `Raiden`,
    `Cyclone`,
    `Voltic`,
    `Voltic2`,
    `Tezeract`,
    `Dilettante`,
    `Dilettante2`,
    `Airtug`,
    `Caddy`,
    `Caddy2`,
    `Caddy3`,
    `Surge`,
    `Khamelion`,
    `RCBandito`
}

return Shared