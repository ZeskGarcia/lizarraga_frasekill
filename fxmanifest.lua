fx_version 'cerulean'
games { 'gta5' }
author 'zsk (lizaarraagaa)'
url 'lizaarraagaa.com'
description ''

lua54 'yes'

client_scripts {
    'Client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'Server/*.lua'
}

shared_scripts {
    '@es_extended/imports.lua',
    'Shared/*.lua'
}

escrow_ignore {
    'Shared/*.lu*'
}
