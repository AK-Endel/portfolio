
RegisterNetEvent('bls-handlingswitch:client:downgrade')
AddEventHandler('bls-handlingswitch:client:downgrade', function()
    local ped = GetPlayerPed(-1)
    local veh = GetHashKey(GetVehiclePedIsIn(ped))
    if CheckVehicle() == true then
        --handling switch kood siia
    else
        print("Pole HSU masin")
    end

end)

function CheckVehicle()
    local ped = GetPlayerPed(-1)
    local veh = GetEntityModel(GetVehiclePedIsIn(ped))
    local hsu = false

    for i = 1, #Config.HsuVehicles, 1 do
        if veh == GetHashKey(Config.HsuVehicles[i].model) then
            hsu = true
        end
    end
    return hsu
end
