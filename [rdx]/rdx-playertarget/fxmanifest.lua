fx_version 'cerulean'
game 'gta5'

author "rdx"

shared_scripts {
    '@ox_lib/init.lua',
    '@qbx_core/modules/lib.lua',
    'shared/*.lua',
}

client_scripts {
    '@qbx_core/modules/playerdata.lua',
    '**/client.lua',
}

server_script {
    '**/server.lua',
}


lua54 'yes'
use_experimental_fxv2_oal 'yes'