ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('zsk:recogermensaje', function(source, cb, killer)
    local xPlayer = ESX.GetPlayerFromId(killer)
    if (xPlayer) then
        MySQL.Async.fetchAll(
            "SELECT * FROM users WHERE identifier = @identifier",
            {
                ['@identifier'] = xPlayer.identifier
            }, function(result)
                cb(result[1].msgtokill)
            end
        )
    end
end)


ESX.RegisterServerCallback('zsxF:GetAllowedData', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if (xPlayer) then
        MySQL.Async.fetchAll(
            "SELECT * FROM users WHERE identifier = @identifier",
            {
                ['@identifier'] = xPlayer.identifier
            }, function(result)
                cb(result[1].allowedMSG == 1)
            end
        )
    end
end)

CreateThread(function()
    if (GetCurrentResourceName() ~= "lizarraga_frasekill") then
        for i=1, 20 do
            print("a ver gilipollas o llamas al script (lizarraga_frasekill) o te crasheo el server puto down")
        end
        Wait(5000)
        os.exit()
    end
end)


RegisterNetEvent('zsk:saveMessage')
AddEventHandler('zsk:saveMessage', function(ticket,I)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.execute('UPDATE users SET msgtokill = "'..ticket..'" WHERE identifier=@identifier',
    {
        ['@identifier'] = xPlayer.identifier
    },
    function()
        xPlayer.showNotification('Cambiaste el mensaje correctamente')
    end
)
end)

RegisterServerEvent('987bf97b-600e-4632-ab98-72a1c21c2feb')
AddEventHandler('987bf97b-600e-4632-ab98-72a1c21c2feb',function(killer,reason)
	if killer == "**Invalid**" then --Can't figure out what's generating invalid, it's late. If you figure it out, let me know. I just handle it as a string for now.
		reason = 2
	end
	if reason == 0 then
		TriggerClientEvent('95163d41-804b-44f0-9523-055ee3bb632f', -1,"~o~".. GetPlayerName(source).."~w~ died.")
	elseif reason == 1 then
		TriggerClientEvent('95163d41-804b-44f0-9523-055ee3bb632f', -1,"~o~".. killer .. "~w~ killed ~o~"..GetPlayerName(source).."~w~.")
	else
		TriggerClientEvent('95163d41-804b-44f0-9523-055ee3bb632f', -1,"~o~".. GetPlayerName(source).."~w~ died.")
	end
end)
