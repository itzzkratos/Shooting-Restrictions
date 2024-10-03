RegisterServerEvent('Kratos:ShootingRestrictions:CheckBypass')
AddEventHandler('Kratos:ShootingRestrictions:CheckBypass', function()
    local src = source
    local hasPermission = IsPlayerAceAllowed(src, Config.BypassPermission)
    if hasPermission then
        TriggerClientEvent('Kratos:ShootingRestrictions:AllowBypass', src)
    else
        TriggerClientEvent('Kratos:ShootingRestrictions:DenyBypass', src)
    end
end)
