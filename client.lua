local revealed = false

local function RevealFullMap()
    -- SET_MINIMAP_HIDE_FOW (0x4B8F743A4A6D2FF8) : true = plus de brouillard
    Citizen.InvokeNative(0x4B8F743A4A6D2FF8, true)
end

AddEventHandler('playerSpawned', function()
    RevealFullMap()
    revealed = true
end)

CreateThread(function()
    while not revealed do
        Wait(500)
        if NetworkIsPlayerActive(PlayerId()) then
            RevealFullMap()
            revealed = true
        end
    end
end)
