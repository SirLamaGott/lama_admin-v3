fx_version 'cerulean'
games {'gta5'}
lua54 'yes'

author 'SirLamaGott'
description 'Lama - Admin v2'
version '0.2.0'

shared_script 'config.lua'

server_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'server/main.lua'
}
client_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'client/main.lua'
}
dependencies {
	'es_extended' 
} 

escrow_ignore {
  'config.lua',
  'client/*.lua',
  'server/*.lua',
  'locales/*.lua'
}