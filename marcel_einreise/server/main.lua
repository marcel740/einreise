ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('onResourceStart', function(ressourceName)
 
    if(GetCurrentResourceName() ~= ressourceName) then
        return
    end
    print("Einreise wurde gestartet.")

 
end)

ESX.RegisterServerCallback('marcel_einreise:getGroup', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    cb(xPlayer.getGroup())
end)

RegisterCommand("einreise", function(source, args, rawCommand)
    local _source = source
    local _target = args[1]
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xTarget = ESX.GetPlayerFromId(_target)
    local hatRechte = false
    for k,v in pairs(Config.AllowedGroups) do
        if v == xPlayer.getGroup() then
            hatRechte = true
            break
        end
    end
    if hatRechte == true then
        MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @id', {['id'] = xTarget.identifier}, function(result)
            if result[1] then
                local status = result[1].neu
                if status == "0" then
                    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @id', {['id'] = xPlayer.identifier}, function(result2)
                        local tname = result[1].firstname .. "_" .. result[1].lastname
                        local pname = result2[1].firstname .. "_" .. result2[1].lastname
                        TriggerClientEvent('marcel_einreise:notify', _source, "Du hast " .. tname .. " eingereist.", "green")
                        TriggerClientEvent('marcel_einreise:notify', _target, "Du wurdest von " .. pname .. " eingereist.", "green")
                        MySQL.Sync.execute("UPDATE users SET neu = @status WHERE identifier = @id", { ['@id'] = xTarget.identifier, ['@status'] = "1" })
                        TriggerClientEvent('marcel_einreise:eingereist', _target)
                    end)
                else
                    TriggerClientEvent('marcel_einreise:notify', _source, Config.Messages.bereits_eingereist, "red")
                end
            end
        end)
    else
        TriggerClientEvent('marcel_einreise:notify', _source, Config.Messages.no_perms, "red")
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @id', {['id'] = xPlayer.identifier}, function(result)
        if result[1] then
            local status = result[1].neu
            if status == 0 then
                TriggerClientEvent('marcel_einreise:setPlayerInEinreise', _source)
            end
        end
    end)
end)


RegisterNetEvent('marcel_einreise:setDimension')
AddEventHandler('marcel_einreise:setDimension', function(dimension)
    local _source = source
    local dim = tonumber(dimension)
    SetPlayerRoutingBucket(_source, dim)
    print('NEUE DIMENSION: ' .. GetPlayerRoutingBucket(_source))
end)

RegisterNetEvent('marcel_einreise:klingelEinreise')
AddEventHandler('marcel_einreise:klingelEinreise', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @id', {['id'] = xPlayer.getIdentifier()}, function(result)
        if result[1] then
            local name = result[1].firstname .. "_" .. result[1].lastname
            TriggerClientEvent('marcel_einreise:notify', _source, "Du hast an der Einreise geklingelt.", "green")
            for i=1, #xPlayers, 1 do
                local zPlayer = ESX.GetPlayerFromId(xPlayers[i])
                for k,v in pairs(Config.AllowedGroups) do
                    if v == zPlayer.getGroup() then
                        TriggerClientEvent('marcel_einreise:notify', zPlayer.source, name .. " hat an der Klingel in der Einreise geklingelt.", "green")
                        break
                    end
                end
            end
        end
    end)
end)
