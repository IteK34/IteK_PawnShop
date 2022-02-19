-- ESX
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(5000)
    end
end)

-- Création Menu
local PawnShop = RageUI.CreateMenu("PawnShop", "BON ACHAT !")
local open = false

-- Glare
PawnShop.Display.Glare = true

PawnShop.Closed = function() open = false end

function pawnshop()
    if open then 
        open = false 
            RageUI.Visible(PawnShop, false)
        return 
    else 
        open = true 
            RageUI.Visible(PawnShop, true)
        Citizen.CreateThread(function()
            while open do
                RageUI.IsVisible(PawnShop, function()
                    RageUI.Button("Kit de réparation", nil, {RightLabel = config.PrixKit}, true, {
                        onSelected = function()
                            TriggerServerEvent('{ IteK#0905 }:AchatKit')
                        end
                    })
                    RageUI.Button("Bandage", nil, {RightLabel = config.PrixBandage}, true, {
                        onSelected = function()
                            TriggerServerEvent('{ IteK#0905 }:AchatBandage')
                        end
                    })
                end)
                Wait(0)
            end
        end)
    end
end

-- Si tu es dans la zone
Citizen.CreateThread(function()
    while true do
      local wait = 1000
        for k,v in pairs(Config.position) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.x, v.y, v.z)
            if dist <= 1.6 then
                wait = 1
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour parler au vendeur")
                if IsControlJustPressed(1, 51) then
                    pawnshop()
                end
            end 
        end
    Citizen.Wait(wait)
    end
end)

-- Blips
Citizen.CreateThread(function() 
    for k, v in pairs(Config.position) do 
        local blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite  (blip, config.blipsprite)
        SetBlipDisplay (blip, config.blipdisplay)
        SetBlipScale   (blip, config.blipscale)
        SetBlipColour  (blip, config.blipcolour)
        SetBlipAsShortRange(blip, true) 
        BeginTextCommandSetBlipName('STRING') 
        AddTextComponentSubstringPlayerName(config.blipname)
        EndTextCommandSetBlipName(blip) 
    end 
end)

-- Ped
Citizen.CreateThread(function()
    local hash = GetHashKey("g_m_m_korboss_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "g_m_m_korboss_01", -689.0842, -945.4600, 19.4560, 179.0589, false, true)
    SetBlockingOfNonTemporaryEvents(ped, 1)
    FreezeEntityPosition(ped, 1)
    SetEntityInvincible(ped, 1)
end)