TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('gotoServerForVehicle')
AddEventHandler('gotoServerForVehicle', function(carName, priceCar)
	local player = ESX.GetPlayerFromId(source)
    if player.getMoney() >= priceCar then
	    player.removeMoney(priceCar)
        TriggerClientEvent('spawnduveh', source, carName)
    else
        TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez assez d'argent~s~")
    end
end)

