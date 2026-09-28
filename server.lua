local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('npc_robbery:checkCooldown', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerId = xPlayer.identifier

    MySQL.Async.fetchScalar('SELECT last_robbery FROM robbery_data WHERE player_id = @playerId', {
        ['@playerId'] = playerId
    }, function(lastRobbery)
        if lastRobbery then
            local currentTime = os.time()
            local cooldownTime = os.time({year=lastRobbery.year, month=lastRobbery.month, day=lastRobbery.day, hour=lastRobbery.hour, min=lastRobbery.min, sec=lastRobbery.sec}) + Config.RobberyCooldown

            if currentTime < cooldownTime then
                cb(false)
            else
                cb(true)
            end
        else
            cb(true)
        end
    end)
end)

RegisterServerEvent('npc_robbery:attemptRobbery')
AddEventHandler('npc_robbery:attemptRobbery', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerId = xPlayer.identifier

    ESX.TriggerServerCallback('npc_robbery:checkCooldown', source, function(canRob)
        if canRob then
            local success = math.random() < 0.5
            local reward = math.random(Config.RewardMin, Config.RewardMax)

            if success then
                xPlayer.addMoney(reward)
                TriggerClientEvent('npc_robbery:endRobbery', source, true)

                MySQL.Async.execute('UPDATE robbery_data SET last_robbery = NOW(), successful_robberies = successful_robberies + 1 WHERE player_id = @playerId', {
                    ['@playerId'] = playerId
                })
            else
                TriggerClientEvent('npc_robbery:endRobbery', source, false)

                MySQL.Async.execute('UPDATE robbery_data SET last_robbery = NOW(), failed_robberies = failed_robberies + 1 WHERE player_id = @playerId', {
                    ['@playerId'] = playerId
                })
            end
        else
            TriggerClientEvent('esx:showNotification', source, 'You must wait before attempting another robbery.')
        end
    end)
end)