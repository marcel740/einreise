fx_version 'adamant'
game 'gta5'
version '1.8.7'
author 'marcel_moncler'
lua54 'yes'

escrow_ignore {
  'config.lua'
}

server_scripts {
  '@async/async.lua',
  '@mysql-async/lib/MySQL.lua',
  '@es_extended/locale.lua',
  'server/main.lua',
  'config.lua'
}

client_scripts {
  '@es_extended/locale.lua',
  'client/main.lua',
  'config.lua'
}

dependency '/assetpacks'