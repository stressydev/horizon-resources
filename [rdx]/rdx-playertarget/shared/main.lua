Shared = {}

Shared.police = {
    {
        name = 'police_actions',
        label = 'Police Actions',
        icon = 'fas fa-scale-balanced',
        distance = 2.0,
        openMenu = "police_actions_menu",
        canInteract = function()
            return QBX.PlayerData.job.onduty
        end,
    },
    { 
        label = 'Cuff / Uncuff', 
        icon = 'fa-solid fa-handcuffs', 
        event = 'rdx-playertarget:rdxActions', 
        menuName = "police_actions_menu",
        action = 'handcuffs',
        distance = 2.0
    },
    { 
        label = 'Escort', 
        icon = 'fas fa-hand-holding', 
        event = 'rdx-playertarget:rdxActions', 
        menuName = "police_actions_menu", 
        action = 'escort',
        distance = 2.0
    },
    { 
        label = 'Search Player', 
        icon = 'fas fa-search', 
        event = 'rdx-playertarget:rdxActions', 
        menuName = "police_actions_menu", 
        action = 'search',
        distance = 2.0
    },
    { 
        label = 'Seat', 
        icon = 'fas fa-car-alt', 
        event = 'rdx-playertarget:rdxActions', 
        menuName = "police_actions_menu", 
        action = 'seat',
        distance = 2.0  
    },
}

Shared.ambulance = {
    {
        name = 'ambulance_actions',
        label = 'Medic Actions',
        icon = 'fas fa-truck-medical',
        distance = 2.0,
        openMenu = "ambulance_actions_menu",
        canInteract = function()
            return QBX.PlayerData.job.onduty
        end,
    },
    { 
        label = 'Treat', 
        icon = 'fas fa-bandage', 
        event = 'rdx-playertarget:rdxActions', 
        menuName = "ambulance_actions_menu",
        action = 'treat',
        distance = 2.0
    },
    { 
        label = 'Revive', 
        icon = 'fas fa-hand-holding-heart', 
        event = 'rdx-playertarget:rdxActions', 
        menuName = "ambulance_actions_menu",
        action = 'revive',
        distance = 2.0 
    },
    { 
        label = 'Recovery', 
        icon = 'fa-solid fa-heart-pulse', 
        event = 'rdx-playertarget:rdxActions', 
        menuName = "ambulance_actions_menu",
        action = 'recovery',
        distance = 2.0
    },
    { 
        label = 'Escort', 
        icon = 'fas fa-hand-holding', 
        event = 'rdx-playertarget:rdxActions', 
        menuName = "ambulance_actions_menu",
        action = 'ems_escort',
        distance = 2.0
    },
    { 
        label = 'Seat', 
        icon = 'fas fa-car-alt', 
        event = 'rdx-playertarget:rdxActions', 
        menuName = "ambulance_actions_menu",
        action = 'seat',
        distance = 2.0 
    }, 
}

Shared.general = {
    {
        name = 'general_actions',
        label = 'General Actions',
        icon = 'fas fa-truck-medical',
        distance = 2.0,
        openMenu = "general_actions_menu",
    },
    { 
        label = 'Carry', 
        icon = 'fas fa-people-carry', 
        event = 'rdx-playertarget:rdxActions',
        menuName = "general_actions_menu",
        action = 'carry',
        distance = 2.0
    },
    { 
        label = 'Escort', 
        icon = 'fas fa-hand-holding', 
        event = 'rdx-playertarget:rdxActions',
        menuName = "general_actions_menu",
        action = 'escort',
        distance = 2.0
    },
    { 
        label = 'Cuff / Uncuff', 
        icon = 'fa-solid fa-handcuffs', 
        event = 'rdx-playertarget:rdxActions', 
        menuName = "general_actions_menu",
        action = 'handcuffs',
        distance = 2.0
    },
    { 
        label = 'Takehostage', 
        icon = 'fa-solid fa-handcuffs', 
        event = 'rdx-playertarget:rdxActions', 
        menuName = "general_actions_menu",
        action = 'takehostage',
        distance = 2.0
    },
    { 
        label = 'Seat', 
        icon = 'fas fa-car-alt', 
        event = 'rdx-playertarget:rdxActions', 
        menuName = "general_actions_menu", 
        action = 'seat',
        distance = 2.0  
    },
}

return Shared
