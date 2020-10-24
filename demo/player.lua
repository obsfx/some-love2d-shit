require "assets.assets"
HC = require "lib.HC"

local player = {
    x = 64,
    y = 64,
    dx = 2,
    dy = 0,
    body = HC.rectangle(64, 64, 16, 16),
    frame = 1,
    tick = 0,
    flip = 1
}

function player.update()
    player.tick = player.tick + 1
    print(player.dx)

    if player.tick % 10 == 0 then
        player.frame = (player.frame + 1) % 6 + 1
    end

    if love.keyboard.isDown('d', 'right') then
        player.flip = 1
        player.x = player.x + player.dx
    end

    if love.keyboard.isDown('a', 'left') then
        player.flip = 2
        player.x = player.x - player.dx
    end
end

function player.draw()
    love.graphics.draw(assets.player.idle[player.flip][player.frame], player.x, player.y)
end

return player