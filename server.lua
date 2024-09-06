local RSGCore = exports['rsg-core']:GetCoreObject()

local function hasRequiredJob(Player)
    return Player.PlayerData.job.name == Config.RepairJob
end

RegisterNetEvent('rsg-wagon:checkRepairRequirements')
AddEventHandler('rsg-wagon:checkRepairRequirements', function(wagon)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    
    if not Player then
        print("Player not found for source: " .. tostring(src))
        return
    end

    if not hasRequiredJob(Player) then
        TriggerClientEvent('RSGCore:Notify', src, Config.Texts.NoJob, "error")
        return
    end
    
    if not Player.Functions.GetItemByName(Config.RepairItem) then
        TriggerClientEvent('RSGCore:Notify', src, Config.Texts.NoKit, "error")
        return
    end
    
    
    TriggerClientEvent('rsg-wagon:startRepair', src, wagon)
    TriggerClientEvent('RSGCore:Notify', src, "Repair started", "success")
end)


RegisterNetEvent('rsg-wagon:finishRepair')
AddEventHandler('rsg-wagon:finishRepair', function(wagon)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    
    if Player then
        if Player.Functions.RemoveItem(Config.RepairItem, 1) then
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[Config.RepairItem], "remove")
            TriggerClientEvent('RSGCore:Notify', src, "Repair kit used", "success")
            
            TriggerClientEvent('rsg-wagon:completeRepair', src, wagon)
        else
            TriggerClientEvent('RSGCore:Notify', src, "Error: Repair kit not found", "error")
        end
    end
end)