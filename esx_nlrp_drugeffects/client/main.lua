Keys = {
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

ESX = nil
local menuOpen = false
local wasOpen = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        if menuOpen then
            ESX.UI.Menu.CloseAll()
        end
    end
end)

RegisterNetEvent('esx_nlrp_drugeffects:useItem')
AddEventHandler('esx_nlrp_drugeffects:useItem', function(itemName)
    ESX.UI.Menu.CloseAll()

    if itemName == 'weed_pooch' then
        local lib, anim = 'amb@world_human_smoking_pot@male@base', 'base'
        local playerPed = PlayerPedId()

        ESX.ShowNotification(_U('weed_use'))
        ESX.Streaming.RequestAnimDict(lib, function()
            TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 32, 0, false, false, false)

            Citizen.Wait(500)
            while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
                Citizen.Wait(0)
                DisableAllControlActions(0)
            end

            TriggerEvent('esx_nlrp_drugeffects:onPot')
        end)

    elseif itemName == 'drugtest' then
        local lib, anim = 'misscarsteal2peeing', 'peeing_intro'
        local playerPed = PlayerPedId()

        ESX.ShowNotification(_U('drug_test'))
        ESX.Streaming.RequestAnimDict(lib, function()
            TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 32, 0, false, false, false)

            Citizen.Wait(500)
            while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
                Citizen.Wait(0)
                DisableAllControlActions(0)
            end

            TriggerEvent('esx_nlrp_drugeffects:testing')
        end)

    elseif itemName == 'snus' then
        local lib, anim = 'anim@mp_player_intcelebrationmale@face_palm', 'face_palm' -- TODO better animations
        local playerPed = PlayerPedId()

        ESX.ShowNotification(_U('snus_use'))
        ESX.Streaming.RequestAnimDict(lib, function()
            TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 32, 0, false, false, false)

            Citizen.Wait(500)
            while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
                Citizen.Wait(0)
                DisableAllControlActions(0)
            end

            TriggerEvent('esx_jk_drugs:cokedOut')
        end)

    elseif itemName == 'puskar' then
        local lib, anim = 'amb@world_human_drinking@beer@male@idle_a', 'idle_a'
        local playerPed = PlayerPedId()

        ESX.ShowNotification(_U('puskar'))
        ESX.Streaming.RequestAnimDict(lib, function()
            TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, 5000, 32, 0, false, false, false)

            Citizen.Wait(500)
            while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
                Citizen.Wait(0)
                DisableAllControlActions(0)
            end

            TriggerEvent('esx_nlrp_drugeffects:buzzin')
        end)

    elseif itemName == 'vodka' then
        local lib, anim = 'amb@world_human_drinking@beer@male@idle_a', 'idle_a'
        local playerPed = PlayerPedId()

        ESX.ShowNotification(_U('vodka'))
        ESX.Streaming.RequestAnimDict(lib, function()
            TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, 5000, 32, 0, false, false, false)

            Citizen.Wait(500)
            while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
                Citizen.Wait(0)
                DisableAllControlActions(0)
            end

            TriggerEvent('esx_nlrp_drugeffects:buzzin')
        end)

    elseif itemName == 'tequila' then
        local lib, anim = 'amb@world_human_drinking@beer@male@idle_a', 'idle_a'
        local playerPed = PlayerPedId()

        ESX.ShowNotification(_U('tequila'))
        ESX.Streaming.RequestAnimDict(lib, function()
            TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, 5000, 32, 0, false, false, false)

            Citizen.Wait(500)
            while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
                Citizen.Wait(0)
                DisableAllControlActions(0)
            end

            TriggerEvent('esx_nlrp_drugeffects:buzzin')
        end)

    elseif itemName == 'beer' then
        local lib, anim = 'amb@world_human_drinking@beer@male@idle_a', 'idle_a'
        local playerPed = PlayerPedId()

        ESX.ShowNotification(_U('beer'))
        ESX.Streaming.RequestAnimDict(lib, function()
            TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, 5000, 32, 0, false, false, false)

            Citizen.Wait(500)
            while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
                Citizen.Wait(0)
                DisableAllControlActions(0)
            end

            TriggerEvent('esx_nlrp_drugeffects:buzzin')
        end)


    elseif itemName == 'fakepee' then

        ESX.ShowNotification(_U('fake_pee'))
        TriggerEvent('esx_nlrp_drugeffects:fakePee')





    elseif itemName == 'opium_pooch' then
        local lib, anim = 'anim@mp_player_intcelebrationmale@face_palm', 'face_palm' -- TODO better animations
        local playerPed = PlayerPedId()

        ESX.ShowNotification(_U('opium_pooch_use'))
        ESX.Streaming.RequestAnimDict(lib, function()
            TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 32, 0, false, false, false)

            Citizen.Wait(500)
            while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
                Citizen.Wait(0)
                DisableAllControlActions(0)
            end

            TriggerEvent('esx_nlrp_drugeffects:icedOut')
        end)






    elseif itemName == 'coke_pooch' then
        local lib, anim = 'anim@mp_player_intcelebrationmale@face_palm', 'face_palm' -- TODO better animations
        local playerPed = PlayerPedId()

        ESX.ShowNotification(_U('coke_pooch_use'))
        ESX.Streaming.RequestAnimDict(lib, function()
            TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 32, 0, false, false, false)

            Citizen.Wait(500)
            while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
                Citizen.Wait(0)
                DisableAllControlActions(0)
            end

            TriggerEvent('esx_nlrp_drugeffects:noddinOut')
        end)

    elseif itemName == 'whiskey' then
        local lib, anim = 'amb@world_human_drinking@beer@male@idle_a', 'idle_a'
        local playerPed = PlayerPedId()

        ESX.ShowNotification(_U('whiskey'))
        ESX.Streaming.RequestAnimDict(lib, function()
            TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, 5000, 32, 0, false, false, false)

            Citizen.Wait(500)
            while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
                Citizen.Wait(0)
                DisableAllControlActions(0)
            end

            TriggerEvent('esx_nlrp_drugeffects:drunk')
        end)
    elseif itemName == 'breathalyzer' then

        ESX.ShowNotification(_U('forced'))
        TriggerEvent('esx_nlrp_drugeffects:breathalyzer')
    end
end)

-- Joint effect
RegisterNetEvent('esx_nlrp_drugeffects:onPot')
AddEventHandler('esx_nlrp_drugeffects:onPot', function()
    RequestAnimSet("MOVE_M@DRUNK@SLIGHTLYDRUNK")
    while not HasAnimSetLoaded("MOVE_M@DRUNK@SLIGHTLYDRUNK") do
        Citizen.Wait(0)
    end
    onDrugs = true
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    SetTimecycleModifier("spectator9")
    SetPedMotionBlur(GetPlayerPed(-1), true)
    SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
    SetPedIsDrunk(GetPlayerPed(-1), true)
    DoScreenFadeIn(1000)
    Citizen.Wait(600000)
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    DoScreenFadeIn(1000)
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(GetPlayerPed(-1), 0)
    SetPedIsDrunk(GetPlayerPed(-1), false)
    SetPedMotionBlur(GetPlayerPed(-1), false)
    ESX.ShowNotification(_U('comin_down'))
    onDrugs = false

end)





-- opium_pooch effect
RegisterNetEvent('esx_nlrp_drugeffects:icedOut')
AddEventHandler('esx_nlrp_drugeffects:icedOut', function()
    RequestAnimSet("move_m@hurry_butch@b")
    while not HasAnimSetLoaded("move_m@hurry_butch@b") do
        Citizen.Wait(0)
    end
    onDrugs = true
	count = 0
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    SetPedMotionBlur(GetPlayerPed(-1), true)
    SetTimecycleModifier("spectator8")
    SetPedMovementClipset(GetPlayerPed(-1), "move_m@hurry_butch@b", true)
	SetRunSprintMultiplierForPlayer(PlayerId(),1.29)
    DoScreenFadeIn(1000)
	repeat
		ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.1)
		TaskJump(GetPlayerPed(-1), false, true, false)
		Citizen.Wait(10000)
		count = count  + 1
	until count == 6
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    DoScreenFadeIn(1000)
    ClearTimecycleModifier()
    ResetPedMovementClipset(GetPlayerPed(-1), 0)
	SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
    ClearAllPedProps(GetPlayerPed(-1), true)
    SetPedMotionBlur(GetPlayerPed(-1), false)
    ESX.ShowNotification(_U('comin_down'))
    onDrugs = false

end)


-- coke_pooch effect
RegisterNetEvent('esx_nlrp_drugeffects:noddinOut')
AddEventHandler('esx_nlrp_drugeffects:noddinOut', function()
    RequestAnimSet("move_m@hurry_butch@b")
    while not HasAnimSetLoaded("move_m@hurry_butch@b") do
        Citizen.Wait(0)
    end
    onDrugs = true
	count = 0
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    SetPedMotionBlur(GetPlayerPed(-1), true)
    SetTimecycleModifier("spectator5")
    SetPedMovementClipset(GetPlayerPed(-1), "move_m@hurry_butch@b", true)
	SetRunSprintMultiplierForPlayer(PlayerId(),1.29)
    DoScreenFadeIn(1000)
	repeat
		ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.5)
		TaskJump(GetPlayerPed(-1), false, true, false)
		Citizen.Wait(10000)
		count = count  + 1
	until count == 30
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    DoScreenFadeIn(1000)
    ClearTimecycleModifier()
    ResetPedMovementClipset(GetPlayerPed(-1), 0)
	SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
    ClearAllPedProps(GetPlayerPed(-1), true)
    SetPedMotionBlur(GetPlayerPed(-1), false)
    ESX.ShowNotification(_U('done_down'))
    onDrugs = false

end)

RegisterNetEvent('esx_nlrp_drugeffects:buzzin')
AddEventHandler('esx_nlrp_drugeffects:buzzin', function()
    RequestAnimSet("move_m@buzzed")
    while not HasAnimSetLoaded("move_m@buzzed") do
        Citizen.Wait(0)
    end
    onBeer = true
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    SetPedMotionBlur(GetPlayerPed(-1), true)
    SetPedMovementClipset(GetPlayerPed(-1), "move_m@buzzed", true)
    DoScreenFadeIn(1000)
    Citizen.Wait(150000)
    ClearTimecycleModifier()
    ResetPedMovementClipset(GetPlayerPed(-1), 0)
    SetPedMotionBlur(GetPlayerPed(-1), false)
    ESX.ShowNotification(_U('wearin_off'))
    onBeer = false

end)

RegisterNetEvent('esx_nlrp_drugeffects:drunk')
AddEventHandler('esx_nlrp_drugeffects:drunk', function()
    RequestAnimSet("move_m@drunk@moderatedrunk")
    while not HasAnimSetLoaded("move_m@drunk@moderatedrunk") do
        Citizen.Wait(0)
    end
    onLiquor = true
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(GetPlayerPed(-1), true)
    SetPedMovementClipset(GetPlayerPed(-1), "move_m@drunk@moderatedrunk", true)
    SetPedIsDrunk(GetPlayerPed(-1), true)
    DoScreenFadeIn(1000)
    Citizen.Wait(600000)
    ClearTimecycleModifier()
    ResetPedMovementClipset(GetPlayerPed(-1), 0)
    SetPedMotionBlur(GetPlayerPed(-1), false)
    SetPedIsDrunk(GetPlayerPed(-1), false)
    ClearTimecycleModifier()
    ESX.ShowNotification(_U('wearin_off'))
    onLiquor = false

end)

RegisterNetEvent('esx_nlrp_drugeffects:testing')
AddEventHandler('esx_nlrp_drugeffects:testing', function()
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    DoScreenFadeIn(1000)
    if onDrugs then
        ESX.ShowNotification(_U('drug_fail'))
        TriggerServerEvent('esx_nlrp_drugeffects:testResultsFail')
    else
        ESX.ShowNotification(_U('drug_pass'))
        TriggerServerEvent('esx_nlrp_drugeffects:testResultsPass')
    end
end)

RegisterNetEvent('esx_nlrp_drugeffects:fakePee')
AddEventHandler('esx_nlrp_drugeffects:fakePee', function()
    local wasDrugged = false
    if onDrugs then
        ESX.ShowNotification(_U('fake_clean'))
        wasDrugged = true
        onDrugs = false
    else
        ESX.ShowNotification(_U('not_needed'))
    end
    Citizen.Wait(60000)
    if wasDrugged then
        onDrugs = true
    end
end)

RegisterNetEvent('esx_nlrp_drugeffects:breathalyzer')
AddEventHandler('esx_nlrp_drugeffects:breathalyzer', function()

    if onBeer then
        ESX.ShowNotification(_U('fail_tipsy'))
        TriggerServerEvent('esx_nlrp_drugeffects:testResultsFailTipsy')
    elseif onLiquor then
        ESX.ShowNotification(_U('fail_drunk'))
        TriggerServerEvent('esx_nlrp_drugeffects:testResultsFailDrunk')
    else
        ESX.ShowNotification(_U('bca_pass'))
        TriggerServerEvent('esx_nlrp_drugeffects:testResultsPassBCA')
    end
end)

RegisterNetEvent('esx_nlrp_drugeffects:coke_poochedOut')
AddEventHandler('esx_nlrp_drugeffects:coke_poochedOut', function()
    RequestAnimSet("move_m@hurry_butch@a")
    while not HasAnimSetLoaded("move_m@hurry_butch@a") do
        Citizen.Wait(0)
    end
    onDrugs = true
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    SetPedMotionBlur(GetPlayerPed(-1), true)
    SetPedMovementClipset(GetPlayerPed(-1), "move_m@hurry_butch@a", true)
    SetPedRandomProps(GetPlayerPed(-1), true)
    SetRunSprintMultiplierForPlayer(GetPlayerPed(-1), 1.49)
    DoScreenFadeIn(1000)
   repeat
		TaskJump(GetPlayerPed(-1), false, true, false)
		Citizen.Wait(60000)
		count = count  + 1
	until count == 5
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    DoScreenFadeIn(1000)
    ClearTimecycleModifier()
    ResetPedMovementClipset(GetPlayerPed(-1), 0)
    SetPedRandomProps(GetPlayerPed(-1), false)
    ClearAllPedProps(GetPlayerPed(-1), true)
    SetRunSprintMultiplierForPlayer(GetPlayerPed(-1), 1.0)
    SetPedMotionBlur(GetPlayerPed(-1), false)
    ESX.ShowNotification(_U('comin_down'))
    onDrugs = false

end)