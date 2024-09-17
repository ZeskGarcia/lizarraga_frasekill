ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('show2DText')
AddEventHandler('show2DText', function(text)
    local display = true
    local endTime = GetGameTimer() + Config.TiempoTexto * 1000
    Citizen.CreateThread(function()
        while display do
            Citizen.Wait(0)
            Show2DText(text)
            if GetGameTimer() > endTime then
                display = false
            end
        end
    end)
end)

function Show2DText(text)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextScale(0.0, 0.7)
    SetTextColour(255, 0, 0, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(true)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.5, 0.4)
end

RegisterCommand('frase', function()
    OpenFraseMenu()
end, false)

function OpenFraseMenu()
    ESX.TriggerServerCallback('zsxF:GetAllowedData', function(cb)
        if (cb) then
            local elements = {
                {label = 'Editar Frase', value = 'editarmensaje'},
            }
        
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'frase_menu', {
                title = 'Selecciona una frase:',
                align = 'top-left',
                elements = elements,
            }, function(data, menu)
                local selectedCommand = data.current.value
                menu.close()
        
                if selectedCommand == 'editarmensaje' then
                   TriggerEvent('zsk:msgdialog')
                end
            end, function(data, menu)
                menu.close()
            end)
        else
            TriggerEvent('95163d41-804b-44f0-9523-055ee3bb632f', "No puedes usar este comando")
        end
    end)
    
end
RegisterNetEvent('zsk:msgdialog')
AddEventHandler('zsk:msgdialog', function()
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'myDialog', {
        title = 'Escribe tu nuevo mensaje',
    }, function(data, menu)
        local newMessage = data.value
        if newMessage then
            menu.close()
            TriggerServerEvent('zsk:saveMessage', newMessage, source)
        else
            ESX.ShowNotification('Debes escribir un mensaje.')
        end
    end, function(data, menu)
        menu.close()
    end)
end)


RegisterNetEvent('95163d41-804b-44f0-9523-055ee3bb632f')
AddEventHandler('95163d41-804b-44f0-9523-055ee3bb632f', function(text)
    if text ~= nil then
        ShowNotification(text)
    end
end)

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(0, 1)
end

Citizen.CreateThread(function()
    local alreadyDead = false
    while true do
        Citizen.Wait(50)
        local playerPed = PlayerPedId()
        if playerPed ~= nil and IsEntityDead(playerPed) and not alreadyDead then
            local killer = GetPedKiller(playerPed)
            local killername = false
            local killerId = false
            for _, player in ipairs(GetActivePlayers()) do
                if killer == GetPlayerPed(player) then
                    killerId = GetPlayerServerId(player)
                    killername = GetPlayerName(player)
                end
            end

            if killer == playerPed then
                TriggerServerEvent('987bf97b-600e-4632-ab98-72a1c21c2feb', 0, 0)
            elseif killername then
                ESX.TriggerServerCallback('zsk:recogermensaje',function(cb)
                    TriggerEvent('show2DText', cb)
                end, killerId)
                TriggerServerEvent('987bf97b-600e-4632-ab98-72a1c21c2feb', killername, 1)
            else
                TriggerServerEvent('987bf97b-600e-4632-ab98-72a1c21c2feb', 0, 2)
            end
            alreadyDead = true
        end
        if not IsEntityDead(playerPed) then alreadyDead = false end
    end
end)
