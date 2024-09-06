local RSGCore = exports['rsg-core']:GetCoreObject()
local Config = Config or {}



Citizen.CreateThread(function()
    while not exports['rsg-target'] do
        Citizen.Wait(500)
    end

    exports['rsg-target']:AddTargetModel(Config.WagonModels, {
        options = {
            {
                label = 'Repair Wagon',
                icon = 'fa-solid fa-wrench',
                action = function(entity)
                    
                    TriggerEvent('rsg-wagon:repair', entity)
                end,
                canInteract = function(entity)
                    
                    return DoesEntityExist(entity) and IsEntityAVehicle(entity)
                end
            },
            {
                label = 'Delete Wagon',
                icon = 'fa-solid fa-trash',
                action = function(entity)
                    
                    TriggerEvent('rsg-wagon:deleteVehicle', entity)
                end,
                canInteract = function(entity)
                    
                    return DoesEntityExist(entity) and IsEntityAVehicle(entity)
                end
            }
        },
        distance = Config.InteractionDistance
    })
end)


RegisterNetEvent('rsg-wagon:deleteVehicle')
AddEventHandler('rsg-wagon:deleteVehicle', function(vehicle)
    local PlayerData = RSGCore.Functions.GetPlayerData()
    local playerJob = PlayerData.job.name

    
    local allowedJobs = {'wagonmechanic', 'vallaw'} 

    
    if DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
        if table.contains(allowedJobs, playerJob) then
            -- Delete the vehicle
            DeleteEntity(vehicle)
            
            
            RSGCore.Functions.Notify("Vehicle deleted successfully", "success")

            
            
        else
            
            RSGCore.Functions.Notify("You do not have permission to delete this vehicle", "error")
           
        end
    else
        
        RSGCore.Functions.Notify("Error: Invalid vehicle", "error")

        
        
    end
end)


function table.contains(table, element)
    for _, value in ipairs(table) do
        if value == element then
            return true
        end
    end
    return false
end




RegisterNetEvent('rsg-wagon:repair')
AddEventHandler('rsg-wagon:repair', function(wagon)
    if not wagon or not DoesEntityExist(wagon) or not IsEntityAVehicle(wagon) then
        RSGCore.Functions.Notify(Config.Texts.InvalidWagon, "error")
        return
    end
    
    
    TriggerServerEvent('rsg-wagon:checkRepairRequirements', wagon)
end)

RegisterNetEvent('rsg-wagon:startRepair')
AddEventHandler('rsg-wagon:startRepair', function(wagon)
    local playerPed = PlayerPedId()
    
    RSGCore.Functions.Progressbar("repairing_wagon", Config.Texts.Repairing, Config.RepairTime, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "script_rc@cldn@ig@rsc2_ig1_questionshopkeeper",
        anim = "inspectfloor_player",
        flags = 1,
    }, {}, {}, function() 
        ClearPedTasks(playerPed)
        TriggerServerEvent('rsg-wagon:finishRepair', wagon)
    end, function() 
        ClearPedTasks(playerPed)
        RSGCore.Functions.Notify("Repair cancelled", "error")
    end)
end)

RegisterNetEvent('rsg-wagon:completeRepair')
AddEventHandler('rsg-wagon:completeRepair', function(wagon)
    if DoesEntityExist(wagon) and IsEntityAVehicle(wagon) then
        
        local bodyHealth = GetVehicleBodyHealth(wagon)
        if bodyHealth <= 0.0 then
            
            local coords = GetEntityCoords(wagon)
            local heading = GetEntityHeading(wagon)
            local model = GetEntityModel(wagon)

            
            DeleteEntity(wagon)

            
            RequestModel(model)
            while not HasModelLoaded(model) do
                Wait(500)
            end

            
            local newVehicle = CreateVehicle(model, coords.x, coords.y, coords.z, heading, true, false)
            
           
            SetVehicleFixed(newVehicle)
            SetVehicleDirtLevel(newVehicle, 0.0)
            SetVehicleBodyHealth(newVehicle, 1000.0)
            SetVehicleEngineHealth(newVehicle, 1000.0)
            SetVehiclePetrolTankHealth(newVehicle, 1000.0)
            SetVehicleLights(newVehicle, 0)
            SetVehicleEngineOn(newVehicle, true, true)

            
            SetVehicleDoorsLocked(newVehicle, 1) -- 1 means unlocked
            SetVehicleDoorsLockedForPlayer(newVehicle, PlayerPedId(), false) 

            
            

            
            RSGCore.Functions.Notify(Config.Texts.ReplaceSuccess, "success")

            
            Citizen.Wait(1000) 
            local playerPed = PlayerPedId()
            
        else
            
            SetVehicleFixed(wagon)
            SetVehicleDirtLevel(wagon, 0.0)
            SetVehicleBodyHealth(wagon, 1000.0)
            SetVehicleEngineHealth(wagon, 1000.0)
            SetVehiclePetrolTankHealth(wagon, 1000.0)
            SetVehicleLights(wagon, 0)
            SetVehicleEngineOn(wagon, true, true)

            
            SetVehicleDoorsLocked(wagon, 1) -- 1 means unlocked
            SetVehicleDoorsLockedForPlayer(wagon, PlayerPedId(), false) -- Unlock for player

           

            
            RSGCore.Functions.Notify(Config.Texts.RepairSuccess, "success")

            
            Citizen.Wait(1000) 
            local playerPed = PlayerPedId()
            
        end
    else
        
        RSGCore.Functions.Notify("Error: Invalid wagon", "error")

        
        
    end
end)




