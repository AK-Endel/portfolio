ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



RegisterServerEvent('esx_nlrp_drugeffects:testResultsFail')
AddEventHandler('esx_nlrp_drugeffects:testResultsFail', function()
	local _source = source
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], (_U('drug_fail')))
		end
	end
end)

RegisterServerEvent('esx_nlrp_drugeffects:testResultsFailTipsy')
AddEventHandler('esx_nlrp_drugeffects:testResultsFailTipsy', function()
	local _source = source
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], (_U('fail_tipsy')))
		end
	end
end)

RegisterServerEvent('esx_nlrp_drugeffects:testResultsFailDrunk')
AddEventHandler('esx_nlrp_drugeffects:testResultsFailDrunk', function()
	local _source = source
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], (_U('fail_drunk')))
		end
	end
end)

RegisterServerEvent('esx_nlrp_drugeffects:testResultsPass')
AddEventHandler('esx_nlrp_drugeffects:testResultsPass', function()
	local _source = source
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], (_U('drug_pass')))
		end
	end
end)

RegisterServerEvent('esx_nlrp_drugeffects:testResultsPassBCA')
AddEventHandler('esx_nlrp_drugeffects:testResultsPassBCA', function()
	local _source = source
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], (_U('bca_pass')))
		end
	end
end)

ESX.RegisterServerCallback('esx_nlrp_drugeffects:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

RegisterServerEvent('esx_nlrp_drugeffects:removeItem')
AddEventHandler('esx_nlrp_drugeffects:removeItem', function(item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem(item, 1)
end)

ESX.RegisterUsableItem('weed_pooch', function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('weed_pooch', 1)
	
		TriggerClientEvent('esx_nlrp_drugeffects:useItem', source, 'weed_pooch')

		Citizen.Wait(1000)
end)

ESX.RegisterUsableItem('drugtest', function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('drugtest', 1)
	
		TriggerClientEvent('esx_nlrp_drugeffects:useItem', source, 'drugtest')

		Citizen.Wait(1000)
end)

ESX.RegisterUsableItem('fakepee', function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('fakepee', 1)
	
		TriggerClientEvent('esx_nlrp_drugeffects:useItem', source, 'fakepee')

		Citizen.Wait(1000)
end)

ESX.RegisterUsableItem('beer', function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('beer', 1)
	
		TriggerClientEvent('esx_nlrp_drugeffects:useItem', source, 'beer')

		Citizen.Wait(1000)
end)

ESX.RegisterUsableItem('tequila', function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('tequila', 1)
	
		TriggerClientEvent('esx_nlrp_drugeffects:useItem', source, 'tequila')

		Citizen.Wait(1000)
end)

ESX.RegisterUsableItem('vodka', function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('vodka', 1)
	
		TriggerClientEvent('esx_nlrp_drugeffects:useItem', source, 'vodka')

		Citizen.Wait(1000)
end)

ESX.RegisterUsableItem('puskar', function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('puskar', 1)
	
		TriggerClientEvent('esx_nlrp_drugeffects:useItem', source, 'puskar')

		Citizen.Wait(1000)
end)

ESX.RegisterUsableItem('whiskey', function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('whiskey', 1)
	
		TriggerClientEvent('esx_nlrp_drugeffects:useItem', source, 'whiskey')

		Citizen.Wait(1000)
end)

ESX.RegisterUsableItem('breathalyzer', function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('breathalyzer', 1)
	
		TriggerClientEvent('esx_nlrp_drugeffects:useItem', source, 'breathalyzer')

		Citizen.Wait(1000)
end)

ESX.RegisterUsableItem('snus', function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('snus', 1)
	
		TriggerClientEvent('esx_nlrp_drugeffects:useItem', source, 'snus')

		Citizen.Wait(1000)
end)

ESX.RegisterUsableItem('puskar', function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('puskar', 1)
	
		TriggerClientEvent('esx_nlrp_drugeffects:useItem', source, 'puskar')

		Citizen.Wait(1000)
end)

ESX.RegisterUsableItem('opium_pooch', function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('opium_pooch', 1)
	
		TriggerClientEvent('esx_nlrp_drugeffects:useItem', source, 'opium_pooch')

		Citizen.Wait(1000)
end)

ESX.RegisterUsableItem('coke_pooch', function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('coke_pooch', 1)
	
		TriggerClientEvent('esx_nlrp_drugeffects:useItem', source, 'coke_pooch')

		Citizen.Wait(1000)
end)