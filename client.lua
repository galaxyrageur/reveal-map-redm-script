local revealed = false

local function RevealFullMap()
    -- SET_MINIMAP_HIDE_FOW (0x4B8F743A4A6D2FF8) : true = plus de brouillard
    Citizen.InvokeNative(0x4B8F743A4A6D2FF8, true)
end

-- Quand le joueur apparaît réellement dans le monde
AddEventHandler('playerSpawned', function()
    RevealFullMap()
    revealed = true
end)

-- Sécurité : au cas où playerSpawned ne se déclenche pas tout de suite
CreateThread(function()
    while not revealed do
        Wait(500)
        if NetworkIsPlayerActive(PlayerId()) then
            RevealFullMap()
            revealed = true
        end
    end
end)