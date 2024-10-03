Config = Config or {}

local restrictedSpeed = Config.RestrictedSpeed
local bypassPermission = Config.BypassPermission
local shootingAllowed = true
local bypassEnabled = false

local function CheckBypassPermission()
    TriggerServerEvent('Kratos:ShootingRestrictions:CheckBypass')
end

local function disableControls()
    local playerPed = PlayerPedId()
    DisablePlayerFiring(playerPed, true)
    DisableControlAction(0, 24, true) -- Attack
    DisableControlAction(0, 25, true) -- Aim
    DisableControlAction(0, 47, true) -- Weapon
    DisableControlAction(0, 58, true) -- Weapon
    DisableControlAction(1, 37, true) -- Change Weapon
    DisableControlAction(0, 140, true) -- Melee
    DisableControlAction(0, 141, true) -- Melee
    DisableControlAction(0, 142, true) -- Melee
    DisableControlAction(0, 143, true) -- Melee
    DisableControlAction(0, 263, true) -- Melee
    DisableControlAction(0, 264, true) -- Melee
    DisableControlAction(0, 257, true) -- Melee
    SetCurrentPedWeapon(playerPed, "WEAPON_UNARMED", true)
end

local function enableControls()
    EnableControlAction(0, 24)   -- Attack
    EnableControlAction(0, 25)   -- Aim
    EnableControlAction(0, 47)   -- Weapon
    EnableControlAction(0, 58)   -- Weapon
    EnableControlAction(1, 37)   -- Change Weapon
    EnableControlAction(0, 140)  -- Melee
    EnableControlAction(0, 141)  -- Melee
    EnableControlAction(0, 142)  -- Melee
    EnableControlAction(0, 143)  -- Melee
    EnableControlAction(0, 263)  -- Melee
    EnableControlAction(0, 264)  -- Melee
    EnableControlAction(0, 257)  -- Melee
end

Citizen.CreateThread(function()
    CheckBypassPermission()
    while true do
        Citizen.Wait(100)

        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        if vehicle and vehicle ~= 0 then
            local speed = GetEntitySpeed(vehicle) * 2.23694 
            shootingAllowed = speed <= restrictedSpeed

            if not bypassEnabled then
                if not shootingAllowed then
                    disableControls()
                else
                    enableControls()
                end
            end
        else
            if not bypassEnabled then
                enableControls()
                shootingAllowed = true
            end
        end
    end
end)

RegisterNetEvent('Kratos:ShootingRestrictions:AllowBypass')
AddEventHandler('Kratos:ShootingRestrictions:AllowBypass', function()
    bypassEnabled = true
end)

RegisterNetEvent('Kratos:ShootingRestrictions:DenyBypass')
AddEventHandler('Kratos:ShootingRestrictions:DenyBypass', function()
    bypassEnabled = false
end)
