
lua54 'yes'
fx_version 'cerulean'
game 'gta5'

author "RDX"

ui_page 'web/index.html'

files {
	'web/*',
}

shared_scripts {
  '@ox_lib/init.lua',
  'shared/*.lua',
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server/**',
}

client_scripts {
  '@qbx_core/modules/playerdata.lua',
  'client/**',
}