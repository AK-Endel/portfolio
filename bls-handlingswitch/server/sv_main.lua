
RegisterCommand("tester", function(source, args, rawCommand)
	--police faction check vahele
	TriggerClientEvent('bls-handlingswitch:client:downgrade', source, 0)
end)