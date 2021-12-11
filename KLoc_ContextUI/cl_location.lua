CreateThread(function()
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	while ESX == nil do Wait(5) end
end)

local waitForSelectThis = false;
local context = ContextUI:CreateMenu(1, "Location") 

ContextUI:IsVisible(context, function(Entity)
    if Entity.Model == 0x50610C43 then
        ContextUI:Button("Vélo", "250 ~g~$", function(Selected)
            if (Selected) then
                ContextUI:OnClosed()
                if waitForSelectThis == false then
                    TriggerServerEvent('gotoServerForVehicle', "scorcher", 250)
                    waitForSelectThis = true;
                end
                SetTimeout(2500, function() waitForSelectThis = false; end)
            end
        end)

        ContextUI:Button("Scooter", "500 ~g~$", function(Selected)
            if (Selected) then
                ContextUI:OnClosed()
                if waitForSelectThis == false then
                    TriggerServerEvent('gotoServerForVehicle', "faggio", 500)
                    waitForSelectThis = true;
                end
                SetTimeout(2500, function() waitForSelectThis = false; end)
            end
        end)

        ContextUI:Button("Panto", "1000 ~g~$", function(Selected)
            if (Selected) then
                ContextUI:OnClosed()
                if waitForSelectThis == false then
                    TriggerServerEvent('gotoServerForVehicle', "panto", 1000)
                    waitForSelectThis = true;
                end
                SetTimeout(2500, function() waitForSelectThis = false; end)
            end
        end)

        ContextUI:Button("Blista", "2000 ~g~$", function(Selected)
            if (Selected) then
                ContextUI:OnClosed()
                if waitForSelectThis == false then
                    TriggerServerEvent('gotoServerForVehicle', "blista", 2000)
                    waitForSelectThis = true;
                end
                SetTimeout(2500, function() waitForSelectThis = false; end)
            end
        end)
    end
end)

RegisterNetEvent('spawnduveh')
AddEventHandler('spawnduveh', function(car)  
    if ESX.Game.IsSpawnPointClear(vector3(-1033.44, -2729.73, 19.86), 5.0) then
        ESX.Game.SpawnVehicle(car, vector3(-1033.44, -2729.73, 19.86), 239.45, function(vehicle) 
            DoScreenFadeOut(1000)
            Wait(5000)
            DoScreenFadeIn(5000)
            SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
            ESX.ShowNotification("Vous avez louer un ~b~"..car.. "~s~")
        end)
    else
        ESX.ShowNotification("Point de spawn bloquée")
    end
end)

CreateThread(function()
    local hash = GetHashKey("a_f_y_femaleagent")
    RequestModel(hash)
    while not HasModelLoaded(hash) do Wait(20) end
    local ped = CreatePed("PED_TYPE_CIVFEMALE", "a_f_y_femaleagent", -1037.15, -2736.75, 19.16, 148.95, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
end)

local v1 = vector3(-1037.43, -2737.38, 21.16)

function Draw3DText(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.0, 0.35)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

CreateThread(function()
	while true do
		local goSleepMan = 500;
        if Vdist2(GetEntityCoords(PlayerPedId(), false), v1) < 20.0 then
            goSleepMan = 0;
            Draw3DText(v1.x,v1.y,v1.z, "Appuyer sur le ped depuis le Mode Context | ~b~Maintenez ~s~[~b~ALT~s~]")
        end
        Wait(goSleepMan)
    end
    
end)

CreateThread(function()
    while true do
        Wait(0)
        if IsControlJustPressed(0, 19) then
            ContextUI.Focus = true
        end

        if IsDisabledControlReleased(0, 19) then
            ContextUI.Focus = false
        end
    end
end)