RSCore = nil
TriggerEvent('RSCore:GetObject', function(obj) RSCore = obj end)

RSCore.Commands.Add("setcryptoworth", "Määra krüpto väärtus", {{name="crypto", help="Krüptovaluuta nimi (dogecoin etc.)"}, {name="Väärtus", help="Uus krüpto hind"}}, false, function(source, args)
    local src = source
    local crypto = tostring(args[1])

    if crypto ~= nil then
        if Crypto.Worth[crypto] ~= nil then
            local NewWorth = math.ceil(tonumber(args[2]))

            if NewWorth ~= nil then
                local PercentageChange = math.ceil(((NewWorth - Crypto.Worth[crypto]) / Crypto.Worth[crypto]) * 100)
                local ChangeLabel = "+"
                if PercentageChange < 0 then
                    ChangeLabel = "-"
                    PercentageChange = (PercentageChange * -1)
                end
                if Crypto.Worth[crypto] == 0 then
                    PercentageChange = 0
                    ChangeLabel = ""
                end

                table.insert(Crypto.History[crypto], {
                    PreviousWorth = Crypto.Worth[crypto],
                    NewWorth = NewWorth
                })

                TriggerClientEvent('RSCore:Notify', src, "Määrasid uue hinna krüptole "..Crypto.Labels[crypto]..". Vana hind: (€"..Crypto.Worth[crypto].." uus hind: €"..NewWorth..") ("..ChangeLabel.." "..PercentageChange.."%)")
                Crypto.Worth[crypto] = NewWorth
                TriggerClientEvent('rs-crypto:client:UpdateCryptoWorth', -1, crypto, NewWorth)
                RSCore.Functions.ExecuteSql(false, "UPDATE `crypto` SET `worth` = '"..NewWorth.."', `history` = '"..json.encode(Crypto.History[crypto]).."' WHERE `crypto` = '"..crypto.."'")
            else
                TriggerClientEvent('RSCore:Notify', src, "Sa pole uut väärtust sisestanud.. Praegune väärtus: "..Crypto.Worth[crypto])
            end
        else
            TriggerClientEvent('RSCore:Notify', src, "Seda krüptot pole saadaval, hetkel saadaval: DogeCoin")
        end
    else
        TriggerClientEvent('RSCore:Notify', src, "Seda krüptot pole saadaval, hetkel saadaval: DogeCoin")
    end
end, "god")

RSCore.Commands.Add("checkcryptoworth", "", {}, false, function(source, args)
    local src = source
    TriggerClientEvent('RSCore:Notify', src, "DogeCoini hetkene väärtus on: €"..Crypto.Worth["dogecoin"])
end, "admin")

RSCore.Commands.Add("crypto", "", {}, false, function(source, args)
    local src = source
    local Player = RSCore.Functions.GetPlayer(src)
    local MyPocket = math.ceil(Player.PlayerData.money.crypto * Crypto.Worth["dogecoin"])

    TriggerClientEvent('RSCore:Notify', src, "Sul on: "..Player.PlayerData.money.crypto.." Dogecoin(i), mis on väärt: €"..MyPocket..",-")
end, "admin")

RSCore.Functions.CreateCallback('rs-crypto:server:FetchWorth', function(source, cb)
	for name,_ in pairs(Crypto.Worth) do
        RSCore.Functions.ExecuteSql(false, "SELECT * FROM `crypto` WHERE `crypto` = '"..name.."'", function(result)
            if result[1] ~= nil then
                Crypto.Worth[name] = result[1].worth
                if result[1].history ~= nil then
                    Crypto.History[name] = json.decode(result[1].history)
                    TriggerClientEvent('rs-crypto:client:UpdateCryptoWorth', -1, name, result[1].worth, json.decode(result[1].history))
                else
                    TriggerClientEvent('rs-crypto:client:UpdateCryptoWorth', -1, name, result[1].worth, nil)
                end
            end
        end)
    end
end)

RSCore.Functions.CreateCallback('rs-crypto:server:ExchangeFail', function(source, cb)
	local src = source
    local Player = RSCore.Functions.GetPlayer(src)
    local ItemData = Player.Functions.GetItemByName("cryptostick")

    if ItemData ~= nil then
        Player.Functions.RemoveItem("cryptostick", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, RSCore.Shared.Items["cryptostick"], "remove")
        TriggerClientEvent('RSCore:Notify', src, "Katse ebaõnnestus, USB lukustatud", 'error', 5000)
    end
end)

RSCore.Functions.CreateCallback('rs-crypto:server:Rebooting', function(source, cb, state, percentage)
	Crypto.Exchange.RebootInfo.state = state
    Crypto.Exchange.RebootInfo.percentage = percentage
end)

RSCore.Functions.CreateCallback('rs-crypto:server:GetRebootState', function(source, cb)
	local src = source
    TriggerClientEvent('rs-crypto:client:GetRebootState', src, Crypto.Exchange.RebootInfo)
end)

RSCore.Functions.CreateCallback('rs-crypto:server:SyncReboot', function(source, cb)
    TriggerClientEvent('rs-crypto:client:SyncReboot', -1)
end)

RSCore.Functions.CreateCallback('rs-crypto:server:ExchangeSuccess', function(source, cb)
    local src = source
    local Player = RSCore.Functions.GetPlayer(src)
    local ItemData = Player.Functions.GetItemByName("cryptostick")

    if ItemData ~= nil then
        local LuckyNumber = math.random(1, 10)
        local DeelNumber = 1000000
        local Amount = (math.random(611111, 1599999) / DeelNumber)
        if LuckChance == LuckyNumber then
            Amount = (math.random(1599999, 2599999) / DeelNumber)
        end

        Player.Functions.RemoveItem("cryptostick", 1)
        Player.Functions.AddMoney('crypto', Amount)
        TriggerClientEvent('RSCore:Notify', src, "Teenisite oma krüpto USBga "..Amount.." Dogecoin(i)", "success", 3500)
        TriggerClientEvent('inventory:client:ItemBox', src, RSCore.Shared.Items["cryptostick"], "remove")
        TriggerClientEvent('rs-phone_new:client:AddTransaction', src, Player, {}, "Sul on "..Amount.." Dogecoin(i) lisandunud!", "Krüpto")
    end
end)

RegisterServerEvent('rs-crypto:server:FetchWorth')
AddEventHandler('rs-crypto:server:FetchWorth', function()
    RSCore.Functions.BanInjection(source, 'rs-crypto (FetchWorth)')
end)

RegisterServerEvent('rs-crypto:server:ExchangeFail')
AddEventHandler('rs-crypto:server:ExchangeFail', function()
    RSCore.Functions.BanInjection(source, 'rs-crypto (ExchangeFail)')
end)

RegisterServerEvent('rs-crypto:server:Rebooting')
AddEventHandler('rs-crypto:server:Rebooting', function(state, percentage)
    RSCore.Functions.BanInjection(source, 'rs-crypto (Rebooting)')
end)

RegisterServerEvent('rs-crypto:server:GetRebootState')
AddEventHandler('rs-crypto:server:GetRebootState', function()
    RSCore.Functions.BanInjection(source, 'rs-crypto (GetRebootState)')
end)

RegisterServerEvent('rs-crypto:server:SyncReboot')
AddEventHandler('rs-crypto:server:SyncReboot', function()
    RSCore.Functions.BanInjection(source, 'rs-crypto (SyncReboot)')
end)

RegisterServerEvent('rs-crypto:server:ExchangeSuccess')
AddEventHandler('rs-crypto:server:ExchangeSuccess', function(LuckChance)
    RSCore.Functions.BanInjection(source, 'rs-crypto (ExchangeSuccess)')
end)

RSCore.Functions.CreateCallback('rs-crypto:server:HasSticky', function(source, cb)
    local Player = RSCore.Functions.GetPlayer(source)
    local Item = Player.Functions.GetItemByName("cryptostick")

    if Item ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

RSCore.Functions.CreateCallback('rs-crypto:server:GetCryptoData', function(source, cb, name)
    local Player = RSCore.Functions.GetPlayer(source)
    local CryptoData = {
        History = Crypto.History[name],
        Worth = Crypto.Worth[name],
        Portfolio = Player.PlayerData.money.crypto,
        WalletId = Player.PlayerData.metadata["walletid"],
    }

    cb(CryptoData)
end)

RSCore.Functions.CreateCallback('rs-crypto:server:BuyCrypto', function(source, cb, data)
    local Player = RSCore.Functions.GetPlayer(source)

    if Player.PlayerData.money.bank >= tonumber(data.Price) then
        local CryptoData = {
            History = Crypto.History["dogecoin"],
            Worth = Crypto.Worth["dogecoin"],
            Portfolio = Player.PlayerData.money.crypto + tonumber(data.Coins),
            WalletId = Player.PlayerData.metadata["walletid"],
        }
        Player.Functions.RemoveMoney('bank', tonumber(data.Price))
        TriggerClientEvent('rs-phone_new:client:AddTransaction', source, Player, data, "Edukalt "..tonumber(data.Coins).." Dogecoin(i) ostetud!", "Krüpto")
        Player.Functions.AddMoney('crypto', tonumber(data.Coins))
        cb(CryptoData)
    else
        cb(false)
    end
end)

RSCore.Functions.CreateCallback('rs-crypto:server:SellCrypto', function(source, cb, data)
    local Player = RSCore.Functions.GetPlayer(source)

    if Player.PlayerData.money.crypto >= tonumber(data.Coins) then
        local CryptoData = {
            History = Crypto.History["dogecoin"],
            Worth = Crypto.Worth["dogecoin"],
            Portfolio = Player.PlayerData.money.crypto - tonumber(data.Coins),
            WalletId = Player.PlayerData.metadata["walletid"],
        }
        Player.Functions.RemoveMoney('crypto', tonumber(data.Coins))
        TriggerClientEvent('rs-phone_new:client:AddTransaction', source, Player, data, "Edukalt "..tonumber(data.Coins).." Dogecoin(i) müüdud!", "Krüpto")
        Player.Functions.AddMoney('bank', tonumber(data.Price))
        cb(CryptoData)
    else
        cb(false)
    end
end)

RSCore.Functions.CreateCallback('rs-crypto:server:TransferCrypto', function(source, cb, data)
    local Player = RSCore.Functions.GetPlayer(source)

    if Player.PlayerData.money.crypto >= tonumber(data.Coins) then
        RSCore.Functions.ExecuteSql(false, "SELECT * FROM `players` WHERE `metadata` LIKE '%"..data.WalletId.."%'", function(result)
            if result[1] ~= nil then
                local CryptoData = {
                    History = Crypto.History["dogecoin"],
                    Worth = Crypto.Worth["dogecoin"],
                    Portfolio = Player.PlayerData.money.crypto - tonumber(data.Coins),
                    WalletId = Player.PlayerData.metadata["walletid"],
                }
                Player.Functions.RemoveMoney('crypto', tonumber(data.Coins))
                TriggerClientEvent('rs-phone_new:client:AddTransaction', source, Player, data, "Edukalt "..tonumber(data.Coins).." Dogecoin(i) üle kantud!", "Krüpto")
                local Target = RSCore.Functions.GetPlayerByCitizenId(result[1].citizenid)

                if Target ~= nil then
                    Target.Functions.AddMoney('crypto', tonumber(data.Coins))
                    TriggerClientEvent('rs-phone_new:client:AddTransaction', Target.PlayerData.source, Player, data, "Sulle on "..tonumber(data.Coins).." Dogecoin(i) juurde laekunud!", "Krüpto")
                else
                    MoneyData = json.decode(result[1].money)
                    MoneyData.crypto = MoneyData.crypto + tonumber(data.Coins)
                    RSCore.Functions.ExecuteSql(false, "UPDATE `players` SET `money` = '"..json.encode(MoneyData).."' WHERE `citizenid` = '"..result[1].citizenid.."'")
                end
                cb(CryptoData)
            else
                cb("notvalid")
            end
        end)
    else
        cb("notenough")
    end
end)