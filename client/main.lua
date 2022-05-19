local duty = false
ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

-- CLOTHES
function setUniform(playerPed)
    local playerPed = PlayerPedId()
    
    TriggerEvent('skinchanger:getSkin', function(skin)
		ESX.TriggerServerCallback("lama_admin:getRankFromPlayer", function(group)
			if skin.sex == 0 then
				if group == "superadmin" then
                    TriggerEvent("skinchanger:loadClothes", skin, Config.Ranks.superadmin.male)						
				elseif group == "admin" then
					TriggerEvent("skinchanger:loadClothes", skin, Config.Ranks.admin.male)						
				elseif group == "mod" then
					TriggerEvent("skinchanger:loadClothes", skin, Config.Ranks.mod.male)				
				elseif group == "dev" then
					TriggerEvent("skinchanger:loadClothes", skin, Config.Ranks.dev.male)					
				elseif group == "support" then
					TriggerEvent("skinchanger:loadClothes", skin, Config.Ranks.support.male)		
                end
            else
				if group == "superadmin" then
                    TriggerEvent("skinchanger:loadClothes", skin, Config.Ranks.superadmin.female)						
				elseif group == "admin" then
					TriggerEvent("skinchanger:loadClothes", skin, Config.Ranks.admin.female)						
				elseif group == "mod" then 
					TriggerEvent("skinchanger:loadClothes", skin, Config.Ranks.mod.female)					
				elseif group == "dev" then
					TriggerEvent("skinchanger:loadClothes", skin, Config.Ranks.dev.female)
				elseif group == "support" then
					TriggerEvent("skinchanger:loadClothes", skin, Config.Ranks.support.female)
                end
			end
        end)
    end)
end

-- CLOTHES
RegisterCommand(Config.DutyCommand, function(source, args)
	TriggerClientEvent("lama_admin:toggleDuty", source)
end, false) 

RegisterNetEvent("lama_admin:toggleDuty")
AddEventHandler("lama_admin:toggleDuty", function(source)
    local playerPed = PlayerPedId()
    if duty then
        duty = false
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            TriggerEvent('skinchanger:loadSkin', skin)
        end)
		if Config.GodMode then SetEntityInvincible(playerPed, false) end 
    else
        duty = true
        setUniform()
		if Config.GodMode then SetEntityInvincible(playerPed, true) end
    end 
end) 

-- CALL ADMIN
RegisterCommand(Config.CallHelpCommand, function(source, args, rawCommand)
    local message = ""
    for i=1, #args, 1 do 
        message = message .. ' ' ..args[i]
    end
    if message == "" or message == " " then 
        message = _U('noMessage')
    end
    TriggerServerEvent("lama_admin:callAdmin", message)
end)

RegisterNetEvent("lama_admin:showNotify")
AddEventHandler("lama_admin:showNotify", function(name, id, message)
    
    if Config.NotifySystem  == 'chat' then
        if Config.UseSound == true then TriggerServerEvent('InteractSound_SV:PlayOnSource', Config.SoundName, Config.SoundVolume) end
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {_U('title'), _U('notifyMessage', name, id, message)}  
          })
          
    elseif Config.NotifySystem == 'esx' then
        if Config.UseSound == true then TriggerServerEvent('InteractSound_SV:PlayOnSource', Config.SoundName, Config.SoundVolume) end
        ESX.ShowNotification(_U('notifyMessage', name, id, message))

    elseif Config.NotifySystem == 'pNotify' or Config.NotifySystem == 'pnotify' then
        if Config.UseSound == true then TriggerServerEvent('InteractSound_SV:PlayOnSource', Config.SoundName, Config.SoundVolume) end
        TriggerEvent("pNotify:SendNotification", {
            text = _U('notifyMessage', name, id, message),
            type = "warning",
            timeout = math.random(1000, 10000), 
            layout = "centerLeft",
            queue = "left"
        })

    elseif Config.NotifySystem == 'okokChatV2' then
        if Config.UseSound == true then TriggerServerEvent('InteractSound_SV:PlayOnSource', Config.SoundName, Config.SoundVolume) end

    else
        print("Invalid Notify System")
    end
end)