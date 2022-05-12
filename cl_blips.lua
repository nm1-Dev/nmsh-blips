local blips = {
    -- {id = "Blip Id / ايدي العلامة", name = "Blip Name / اسم العلامة", scale = 0.75, color = 2, sprite = 61, x = 0.0, y = 0.0, z = 0.0},
    {id = "hospital", name = "ﻰﻔﺸﺘﺴﻣ", scale = 0.75, color = 2, sprite = 61, x = -449.67, y = -340.83, z= 34.50},
}

local circles = {
    { id = "hunting", name = "ﺔﻴﻧﻮﻧﺎﻘﻟﺍ ﺪﻴﺼﻟﺍ ﺔﻘﻄﻨﻣ", opacity = 80, radius = 1000.0, color = 1, sprite = 9, x = -838.5, y = 4176.4, z= 192.5 },
}


local circleBlips = {}


Citizen.CreateThread(function()
    for k,v in ipairs(blips) do
        Nmsh.BlipManager:CreateBlip(v.id, v)
    end
    for k,v in ipairs(circles) do
        local blip = AddBlipForRadius(v.x,v.y,v.z,v.radius)
        SetBlipColour(blip,v.color)
        SetBlipAlpha(blip,v.opacity)
        SetBlipSprite(blip,9)
        circleBlips[#circleBlips+1] = {
            blip = blip,
            data = v
        }
    end
end)


AddEventHandler('nmsh-blips:hideAllBlips', function(pState)
    for k,v in ipairs(blips) do
        Nmsh.BlipManager:HideBlip(v.id, pState)
    end
    for _,blipData in ipairs(circleBlips) do
        if pState then
            SetBlipAlpha(blipData.blip, 0)
        else
            SetBlipAlpha(blipData.blip, blipData.data.opacity)
        end
    end
end)

-- registercommand to hide all blips
RegisterCommand('hideblips', function(source, args, raw)
    if args[1] == 'true' then
        TriggerEvent('nmsh-blips:hideAllBlips', true)
    elseif args[1] == 'false' then
        TriggerEvent('nmsh-blips:hideAllBlips', false)
    end
end, false)