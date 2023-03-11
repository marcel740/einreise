ESX = nil
local einreiseduty = false


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
        Citizen.Wait(10)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()

end)



RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer 
end)


function notify(msg, color)
    TriggerEvent(Config.Notify.trigger, color, "EINREISE", msg)
end

RegisterNetEvent('massins_einreise:notify')
AddEventHandler('massins_einreise:notify', function(msg, color)
    notify(msg, color)
end)

function setDimension(dimension)
    TriggerServerEvent('massins_einreise:setDimension', dimension)
end

RegisterNetEvent('massins_einreise:setPlayerInEinreise')
AddEventHandler('massins_einreise:setPlayerInEinreise', function()
    local ped = PlayerPedId()
    SetEntityCoords(ped, Config.Positions.einreise_anflug)
    notify(Config.Messages.neu, Config.Notify.standart_color)
    setDimension(Config.Dimension)
end)

RegisterNetEvent('massins_einreise:eingereist')
AddEventHandler('massins_einreise:eingereist', function()
    local ped = PlayerPedId()
    SetEntityCoords(ped, Config.Positions.einreise_raus)
    setDimension(0)
end)

RegisterCommand("eduty", function(source, args, rawCommand)
    einreiseDuty()
end)

RegisterKeyMapping('eduty', 'Einreise Dienst', 'keyboard', '-')


function einreiseDuty()
    ESX.TriggerServerCallback('massins_einreise:getGroup', function(group)
        for k,v in pairs(Config.AllowedGroups) do
            if v == group then
                local ped = PlayerPedId()
                if einreiseduty == false then
                    SetEntityCoords(ped, Config.Positions.einreise_rein)
                    TriggerEvent('skinchanger:getSkin', function(skin)
                        if skin.sex == 0 then
                            TriggerEvent("skinchanger:loadClothes", skin, Config.Kleidung.maenlich)
                        else
                            TriggerEvent("skinchanger:loadClothes", skin, Config.Kleidung.weiblich)
                        end
                    end)
                    notify(Config.Messages.einreisedienst_an, Config.Notify.standart_color)
                    einreiseduty = true
                    setDimension(Config.Dimension)
                else
                    SetEntityCoords(ped, Config.Positions.einreise_raus)
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadSkin', skin)
                    end)
                    notify(Config.Messages.einreisedienst_aus, Config.Notify.standart_color)
                    einreiseduty = false
                    setDimension(0)
                end
            end
        end 
    end)

        


end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        DrawMarker(Config.Marker.type, Config.Positions.einreise_klingel, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, Config.Marker.color.r, Config.Marker.color.g, Config.Marker.color.b, true, true, 2, false, nil, nil, false)
        if #(GetEntityCoords(PlayerPedId()) - Config.Positions.einreise_klingel) < 1.5 then
            --TriggerEvent(Config.Notify.trigger, Config.Notify.standart_color, "INFORMATION", Config.Marker.helpnotify)
            if IsControlJustReleased(0, 38) then
                klingelEinreise()
            end
        end
    end
end)

local geklingelt = false

function klingelEinreise()
    if geklingelt == false then
        TriggerServerEvent('massins_einreise:klingelEinreise')
        geklingelt = true
    else
        notify("Du kannst nicht mehr klingeln.", "red")
    end
end



