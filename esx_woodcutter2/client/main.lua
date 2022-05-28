--LUMBERJACK
local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
-- IMPOSTO IL LAVORO DEI PLAYER

local PlayerData = {}
ESX = nil
local dutyy = false
local JobBlips = {}

local vehicleout = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
	refreshBlips()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	refreshBlips()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	deleteBlips()
	refreshBlips()
	
	Citizen.Wait(5000)
end)




local marcalberi = {
	{-643.74, 5241.68, 75.19},
	{-647.27, 5269.43, 74.07},
    {-600.8, 5240.7, 71.48},
    {-664.78, 5277.26, 74.4},
}

local alreadyCut = {}

local processoAlb = {
	{-533.20031738281,5293.126953125,74.20}
}

local vendiAlb = {
	{497.32, -1973.12, 24.99 }
}


local staProcessando = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        for k,v in pairs(marcalberi) do
            local x,y,z = table.unpack(v)
            z = z-1
            local pCoords = GetEntityCoords(PlayerPedId())
            local distance = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, x, y, z, true)
            local alpha = math.floor(255 - (distance * 30))
			
			if PlayerData.job ~= nil and PlayerData.job.name == 'lumberjack' then
			
            if alreadyCut[k] ~= nil then
	 	
            	local timeDiff = GetTimeDifference(GetGameTimer(), alreadyCut[k])
            	if timeDiff < 60000 then
            		if distance < 2.0 then
		                local seconds = math.ceil(30 - timeDiff/1000)
		                DrawText3d(x, y, z+1.5, "~y~"..tostring(seconds).."~b~ sekundit jäänud.", alpha)
		            end
            	else
            		alreadyCut[k] = nil
            	end
            else
	            if distance < 2.0 then
	                DrawText3d(x, y, z+1.5, "~b~vajuta ~y~[E]~b~ et raiduda puitu.", alpha)
	            	if (IsControlJustPressed(1, 38)) then
	            		if alreadyCut[k] ~= nil then
	            			if GetTimeDifference(GetGameTimer(), alreadyCut[k]) > 60000 then
	            				alreadyCut[k] = GetGameTimer()
	                    		TriggerEvent('esx_woodcutter2:cutTree')
	            			end
	            		else
	            			alreadyCut[k] = GetGameTimer()
	                    	TriggerEvent('esx_woodcutter2:cutTree')
	            		end
	                end
	            elseif distance < 2.0 then
	                DrawText3d(x, y, z+1.5, "~b~Tule lähemale", alpha)
	            end
            end
		  end	
        end
    end
end)

local lastProcess = 0

Citizen.CreateThread(function()
    while true do
        if staProcessando then
        	if GetTimeDifference(GetGameTimer(), lastProcess) > 4000 then
        		lastProcess = GetGameTimer()
        		TriggerServerEvent('esx_wood:take')
			end 
        end
        Citizen.Wait(1)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
		
		if PlayerData.job ~= nil and PlayerData.job.name == 'lumberjack' then
		
        for k,v in pairs(processoAlb) do
            local x,y,z = table.unpack(v)
            local pCoords = GetEntityCoords(PlayerPedId())
            local distance = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, x, y, z, true)
            local alpha = math.floor(255 - (distance * 30))

            DrawMarker(23, x, y, z-1, 0, 0, 0, 0.0, 0, 0, 3.0, 3.0, 0.5001, 255, 255, 255, 255, 0, 0, 0, 0)

            if staProcessando then
            	if distance < 2.0 then
	                DrawText3d(x, y, z+1.8, "~b~vajuta ~r~[E]~b~ et peatada tootmine.", alpha)
	                if (IsControlJustPressed(1, 38)) then
	            		TriggerEvent('esx_woodcutter2:enableProcess')
	                end
	            elseif distance < 8.0 then
	                DrawText3d(x, y, z+1.8, "~b~Tule lähemale", alpha)
	            end
            else
	            if distance < 2.0 then
	            	DrawText3d(x, y, z+1.8, "~b~vajuta ~r~[E]~b~ et töödelda puitu.", alpha)
            		if (IsControlJustPressed(1, 38)) then
	            		TriggerEvent('esx_woodcutter2:enableProcess')
	                end
            	elseif distance < 8.0 then
	                DrawText3d(x, y, z+1.8, "~y~Tule lähemale.", alpha)
            	end
            end
        end
    end
  end	
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
		
		if PlayerData.job ~= nil and PlayerData.job.name == 'lumberjack' then
		
        for k,v in pairs(vendiAlb) do
            local x,y,z = table.unpack(v)
            local pCoords = GetEntityCoords(PlayerPedId())
            local distance = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, x, y, z, true)
            local alpha = math.floor(255 - (distance * 30))

            DrawMarker(23, x, y, z-1, 0, 0, 0, 0.0, 0, 0, 3.0, 3.0, 0.5001, 255, 255, 255, 255, 0, 0, 0, 0)

            if staProcessando then
            	if distance < 2.0 then
	                DrawText3d(x, y, z+1.8, "~b~vajuta ~b~[E]~b~ et peatada müümine", alpha)
	                if (IsControlJustPressed(1, 38)) then
	            		TriggerEvent('esx_woodcutter2:enableProcess')
	                end
	            elseif distance < 8.0 then
	                DrawText3d(x, y, z+1.8, "~b~tule lähemale.", alpha)
	            end
            else
	            if distance < 2.0 then
	            	DrawText3d(x, y, z+1.8, "~b~vajuta ~y~[E]~b~ et müüa puitu.", alpha)
            		if (IsControlJustPressed(1, 38)) then
	            		TriggerServerEvent('esx_woodcutter2:sell')
	                end
            	elseif distance < 8.0 then
	                DrawText3d(x, y, z+1.8, "~b~Tule Lähemale.", alpha)
            	end
            end
	      end	
        end
    end
end)


function truck()
	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'garage',
	  {
		  title    = 'Garage',
		  elements = {
			  {label = 'Väljasta sõiduk', value = 'uno'},
		  }
	  },
	  function(data, menu)
		  local val = data.current.value
		  
			if val == 'uno' then
			menu.close()
			local vehicle = GetHashKey('18f350ds')
			RequestModel(vehicle)
			while not HasModelLoaded(vehicle) do
			Wait(1)
			end
			spawned_car = CreateVehicle(vehicle,1188.206, -1286.56, 35.201,86.187, true, false)

		  end
	  end,
	  function(data, menu)
		  menu.close()
	  end
  )
  end

  function deleteBlips()
	if JobBlips[1] ~= nil then
		for i=1, #JobBlips, 1 do
			RemoveBlip(JobBlips[i])
			JobBlips[i] = nil
		end
	end
end



function refreshBlips()

	if PlayerData.job ~= nil and PlayerData.job.name == 'lumberjack'  then

        for k,v in pairs(Config.Zones) do
		  
		    for i = 1, #v.Pos, 1 do
		
			local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
		
			SetBlipSprite (blip, 237)
			SetBlipDisplay(blip, 4)
		    SetBlipScale  (blip, 1.0)
		    SetBlipColour (blip, 17)
		    SetBlipAsShortRange(blip, true)
		    BeginTextCommandSetBlipName("STRING")
		    AddTextComponentString(v.Pos[i].nome)
			EndTextCommandSetBlipName(blip)
			table.insert(JobBlips, blip)
		    end
		end
	end
end


Citizen.CreateThread(function()
	while true do

		Citizen.Wait(1)

		if PlayerData.job ~= nil and PlayerData.job.name == 'lumberjack'  then

			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			
			if GetDistanceBetweenCoords(coords, 1194.62, -1286.95, 34.12, true) < 15.0 and not vehicleout then
			    DrawMarker(39, 1194.62, -1286.95, 35.12, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.5, 2.5, 2.5, 255,0,0,0.3, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(coords, 1194.62, -1286.95, 34.12, true) < 1.75 then
				   DrawText3d(1194.62, -1286.95, 35.12+0.9, "~b~vajuta ~y~[E]~b~ et väljastada sõiduk", 255)
					if IsControlJustReleased(1, 51) then
						truck()
						vehicleout = true
					end
			    end
		    end
		
		end
	end
end)

Citizen.CreateThread(function()
	while true do

		Citizen.Wait(1)

		if PlayerData.job ~= nil and PlayerData.job.name == 'lumberjack' then

			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			
			if GetDistanceBetweenCoords(coords, 1216.89, -1229.23, 34.40, true) < 15.0  then
			    DrawMarker(39, 1216.89, -1229.23, 35.40, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.5, 2.5, 2.5, 255,0,0,0.3, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(coords, 1216.89, -1229.23, 34.40, true) < 1.75 then
					DrawText3d(1216.89, -1229.23, 35.40+0.9, "~b~vajuta ~y~[E]~b~ et tagastada sõiduk", 255)
					if IsControlJustReleased(1, 51) then
				     	vehicleout = false
						TriggerEvent('esx:deleteVehicle', "18f350ds")
					end
			    end
		    end
		
		end
	end
end)


function duty()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom',
	{
		title    = 'duty',
		elements = {
			{label = 'Tööriided',     value = 'job_wear'},
			{label = 'Tsiviil riided', value = 'citizen_wear'}
		}
	}, function(data, menu)
		if data.current.value == 'citizen_wear' then
			dutyy = false
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		elseif data.current.value == 'job_wear' then
			dutyy = true
				TriggerEvent('skinchanger:getSkin', function(skin)
  
					if skin.sex == 0 then
			
					  local clothesSkin = {
						['tshirt_1'] = 15, ['tshirt_2'] = 0, 
						['torso_1'] = 251, ['torso_2'] = 6,
						['helmet_1'] = 0, ['helmet_2'] = 5,
						['arms'] = 11,
						['pants_1'] = 97, ['pants_2'] = 6,
						['shoes_1'] = 25, ['shoes_2'] = 0,
					    ['glasses_1'] = 15, ['glasses_2'] = 8
					  }
					  TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					end
				end)
		end

		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end

Citizen.CreateThread(function()
	while true do

		Citizen.Wait(1)

		if PlayerData.job ~= nil and PlayerData.job.name == 'lumberjack' then

			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			
			if GetDistanceBetweenCoords(coords, 1218.62, -1267.23, 36.42, true) < 15.0 then
			    DrawMarker(20, 1218.62, -1267.23, 36.42, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 2.0, 0, 255, 0, 100, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(coords, 1218.62, -1267.23, 36.42, true) < 1.75 then
					DrawText3d(1218.62, -1267.23, 36.42+0.9, "~w~Press ~r~[E]~w~ for duty", 255)
					if IsControlJustReleased(1, 51) then
						duty()
					end
			    end
		    end
		
		end
	end
end)









RegisterNetEvent("esx_woodcutter2:cutTree")
AddEventHandler("esx_woodcutter2:cutTree", function(tree)
	if not IsAnimated then
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	while (not HasAnimDictLoaded("amb@world_human_hammering@male@base")) do 
		RequestAnimDict("amb@world_human_hammering@male@base")
		Citizen.Wait(5)
	end
	IsAnimated = true
	propaxe = CreateObject(GetHashKey("prop_tool_fireaxe"), x, y, z+0.2,  true,  true, true)
	AttachEntityToEntity(propaxe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.08, -0.4, -0.10, 80.0, -20.0, 175.0, true, true, false, true, 1, true)
	TaskPlayAnim(PlayerPedId(), "amb@world_human_hammering@male@base", "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
	FreezeEntityPosition(PlayerPedId(),true)
    Citizen.Wait(30000)
	IsAnimated = false
	DeleteObject(propaxe)
	FreezeEntityPosition(PlayerPedId(),false)
    ClearPedTasksImmediately(PlayerPedId())
    TriggerServerEvent('esx_woodcutter2:processo')
  end	
end)

RegisterNetEvent("esx_woodcutter2:enableProcess")
AddEventHandler("esx_woodcutter2:enableProcess", function()
	staProcessando = not staProcessando
	if staProcessando then
		TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_FIRE", 0, true)
		FreezeEntityPosition(PlayerPedId(),true)
	else
		FreezeEntityPosition(PlayerPedId(),false)
    	ClearPedTasksImmediately(PlayerPedId())
	end
end)

function DrawText3d(x,y,z, text, alpha)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    if onScreen then
        SetTextScale(0.5, 0.5)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, alpha)
        SetTextDropshadow(0, 0, 0, 0, alpha)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        SetDrawOrigin(x,y,z, 0)
        DrawText(0.0, 0.0)
        ClearDrawOrigin()
    end
end



