ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--> PROCESSO DEL LEGNA

RegisterServerEvent('esx_wood:take')
AddEventHandler('esx_wood:take', function()

	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('wood')

	 if xItem.count >=1 then
	
	xPlayer.removeInventoryItem('wood', 1)	
	xPlayer.addInventoryItem('cutted_wood', 1)
	else
	
	TriggerClientEvent('esx:showNotification', source, ' sa vajad puitu ')
   end
end)

-- RACCOLTA DEL LEGNA

RegisterServerEvent('esx_woodcutter2:processo')
AddEventHandler('esx_woodcutter2:processo', function()

	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('wood')
	
	if xItem.limit ~= 1000 and (xItem.count + 1) > xItem.limit then
		xPlayer.addInventoryItem('wood', 0)
		TriggerClientEvent('esx:showNotification', source, 'Seljakott on täis')
	else
		xPlayer.addInventoryItem(xItem.name, 2)
	end
end)
	
-- VENDERE LEGNA

RegisterServerEvent('esx_woodcutter2:sell')
AddEventHandler('esx_woodcutter2:sell', function()

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xItem = xPlayer.getInventoryItem('cutted_wood')

	if xItem.count >=1 then	
	
	xPlayer.removeInventoryItem('cutted_wood', 1)
	xPlayer.addMoney(60)
	
	else
	
	TriggerClientEvent('esx:showNotification', source, ' sa vajad lõigatud puitu ')
	end
end)