ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
 
RegisterNetEvent('{ IteK#0905 }:AchatKit')
AddEventHandler('{ IteK#0905 }:AchatKit', function()
  local xPlayer = ESX.GetPlayerFromId(source)  
  local prix = 500
  local money = xPlayer.getMoney()
    if money >= prix then
      xPlayer.removeMoney(prix)
      xPlayer.addInventoryItem('fixtool', 1)
    else
      TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez d\'argent")
    end
end)

RegisterNetEvent('{ IteK#0905 }:AchatBandage')
AddEventHandler('{ IteK#0905 }:AchatBandage', function()
  local xPlayer = ESX.GetPlayerFromId(source)  
  local prix = 15
  local money = xPlayer.getMoney()
    if money >= prix then
      xPlayer.removeMoney(prix)
      xPlayer.addInventoryItem('bandage', 1)
    else
      TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez d\'argent")
    end
end)