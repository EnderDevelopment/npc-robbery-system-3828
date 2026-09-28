local ESX = nil
local isRobbing = false
local eyeContactTimer = 0

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for _, model in ipairs(Config.NPCModels) do
            local handle, ped = FindFirstPed()
            local success

            repeat
                if DoesEntityExist(ped) and IsPedHuman(ped) and GetEntityModel(ped) == GetHashKey(model) then
                    local pedCoords = GetEntityCoords(ped)
                    local distance = #(playerCoords - pedCoords)

                    if distance < 2.0 then
                        if IsPedFacingPed(ped, playerPed, 90.0) and IsPedFacingPed(playerPed, ped, 90.0) then
                            eyeContactTimer = eyeContactTimer + 1

                            if eyeContactTimer >= Config.EyeContactTime * 10 then
                                TriggerServerEvent('npc_robbery:attemptRobbery', GetPlayerServerId(PlayerId()))
                                eyeContactTimer = 0
                            end
                        else
                            eyeContactTimer = 0
                        end
                    end
                end

                success, ped = FindNextPed(handle)
            until not success

            EndFindPed(handle)
        end
    end
end)

RegisterNetEvent('npc_robbery:startRobbery')
AddEventHandler('npc_robbery:startRobbery', function()
    isRobbing = true
    ESX.ShowNotification('Robbery in progress...')
end)

RegisterNetEvent('npc_robbery:endRobbery')
AddEventHandler('npc_robbery:endRobbery', function(success)
    isRobbing = false
    if success then
        ESX.ShowNotification('Robbery successful!')
    else
        ESX.ShowNotification('Robbery failed!')
    end
end)