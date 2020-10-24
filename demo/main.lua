require "levels"
require "assets.assets"
player = require "player"

HC = require "lib.HC"

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest", 1)

    canvas = love.graphics.newCanvas(400, 240)
    canvas:setFilter("nearest", "nearest")
    print('kek')

    for y, row in ipairs(level1) do
        for x, v in ipairs(row) do
            HC.rectangle((x - 1) * 16, (y - 1) * 16, 16, 16)
        end
    end
end


function love.update()
    player.update()

    for shape, delta in pairs(HC.collisions(player.body)) do
        text = string.format("Colliding. Separating vector = (%s,%s)",
                                      delta.x, delta.y)
        print(text)
    end

    canvas:renderTo(
        function()
            love.graphics.clear()
            love.graphics.setBackgroundColor(177 / 255, 174 / 255, 168 / 255, 1)

            for y, row in ipairs(level1) do
                for x, v in ipairs(row) do
                    if v ~= 0 then 
                        love.graphics.draw(assets.tiles[v],  (x - 1) * 16, (y - 1) * 16)
                    end
                end
            end

            player.draw()
        end
    )
end

function love.draw()
    love.graphics.setColor(1, 1, 1, 1) -- reset color before drawing to canvas
    love.graphics.setBlendMode("alpha")
    love.graphics.draw(canvas, 0, 0, 0, 2)
end