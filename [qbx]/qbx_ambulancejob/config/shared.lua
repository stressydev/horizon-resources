return {
    checkInCost = 1500, -- Price for using the hospital check-in system
    minForCheckIn = 2, -- Minimum number of people with the ambulance job to prevent the check-in system from being used

    locations = { -- Various interaction points
        duty = {
            vec3(311.7367, -569.0660, 43.2699),
            --vec3(-254.88, 6324.5, 32.58),
        },
        vehicle = {
            vec4(295.6316, -603.6403, 43.0833, 71.3458),
            --vec4(-234.28, 6329.16, 32.15, 222.5),
        },
        helicopter = {
            vec4(351.58, -587.45, 74.16, 160.5),
            --vec4(-475.43, 5988.353, 31.716, 31.34),
        },
        armory = {
            {
                shopType = 'AmbulanceArmory',
                name = 'Armory',
                groups = { ambulance = 0 },
                inventory = {
                    { name = 'radio', price = 100 },
                    { name = 'bandage', price = 25 },
                    { name = 'firstaid', price = 50 },

                },
                locations = {
                    vec3(312.2776, -597.4467, 43.2698)
                }
            }
        },
        roof = {
            vec3(338.5365, -583.8097, 74.1617),
        },
        main = {
            vec3(316.7561, -577.2393, 43.2758),
        },
        stash = {
            {
                name = 'ambulanceStash',
                label = 'Personal stash',
                weight = 100000,
                slots = 30,
                groups = { ambulance = 0 },
                owner = true, -- Set to false for group stash
                location = vec3(297.9679, -592.4637, 43.2699)
            }
        },

        ---@class Bed
        ---@field coords vector4
        ---@field model number

        ---@type table<string, {coords: vector3, checkIn?: vector3|vector3[], beds: Bed[]}>
        hospitals = {
            pillbox = {
                coords = vec3(350, -580, 43),
                checkIn = vec3(302.1175, -589.5847, 43.2699),
                beds = {
                    {coords = vec4(323.0631, -568.9642, 49.1187, 158.3610), model = 1631638868},
                    {coords = vec4(319.8228, -567.6574, 49.1187, 159.5628), model = 1631638868},
                    {coords = vec4(316.6382, -566.3959, 49.1187, 159.6188), model = 2117668672},
                    {coords = vec4(315.0546, -570.8452, 49.1187, 338.3494), model = 2117668672},
                    {coords = vec4(318.2949, -572.0732, 49.1186, 339.1065), model = 2117668672},
                },
            },
            paleto = {
                coords = vec3(-250, 6315, 32),
                checkIn = vec3(-254.54, 6331.78, 32.43),
                beds = {
                    {coords = vec4(-252.43, 6312.25, 32.34, 313.48), model = 2117668672},
                    {coords = vec4(-247.04, 6317.95, 32.34, 134.64), model = 2117668672},
                    {coords = vec4(-255.98, 6315.67, 32.34, 313.91), model = 2117668672},
                },
            },
            jail = {
                coords = vec3(1777.8342, 2555.2842, 45.7978),
                checkIn = vec3(1777.8699, 2555.0237, 45.7978),
                beds = {
                    {coords = vec4(1777.6747, 2558.9424, 46.7223, 273.4920), model = 2117668672},
                    {coords = vec4(1777.6210, 2561.4521, 46.7223, 271.9924), model = 2117668672},
                    {coords = vec4(1777.7391, 2563.4194, 46.7223, 274.6940), model = 2117668672},
                    {coords = vec4(1777.8055, 2565.5513, 46.7224, 276.5800), model = 2117668672},
                },
            },
        },

        stations = {
            {label = 'Pillbox Hospital', coords = vec4(304.27, -600.33, 43.28, 272.249)},
        }
    },
}

