# Lizarraga Frase Kill

## How to install
> 1. Download the script [github.com/ZeskGarcia/lizarraga_frasekill](https://github.com/ZeskGarcia/lizarraga_frasekill)
> 2. Extract the ZIP File (Downloaded Script)
> 3. Insert it into your server (resources folder)
> 4. Open `lizarraga_frasekill.sql` and insert that data in your SQL Database

## How to Give /frase permission
> 1. Go to your SQL Database
> 2. Go into your `users` table
> 3. Select the user you want to give the permission
> 4. Go ahead to `allowedMSG` column and if the value its `0` change it to `1`

## How to change Kill Text Showing time
> 1. Go to `Shared/Config.lua`
> 2. At the second line that starts with `Config.TiempoTexto` as default is in 7 seconds
> 3. From default (7 seconds) change it to the seconds you want to display the message
> 4. Example:
```lua
Config = {}
Config.TiempoTexto = 10 -- Time in seconds (ex. 10 seconds)
```

## Want to contact me?
**Contact me via** ***discord***: [lizaarraagaa](https://discord.com/users/1079397084068847646)
