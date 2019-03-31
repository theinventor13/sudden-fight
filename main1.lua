
ys = 0.0
ys = 0.0
x = 0.0
b1x = 400
b1y = 300
b1w = 300
b1h = 200
b2w = 200
b2h = 200

function love.draw()
    ys = (ys + .01) % (2.0 * math.pi)
    y = math.sin(ys) * 100.0 + 300.0
    x = (x + 1.0) % 800.0
    local mx, my = love.mouse.getPosition()
    love.graphics.print(tostring(math.sin(ys)), x, y)
    love.graphics.line(0, 300, 800, 300)
    if ethyl_aabb(mx, my, b2w, b2h, b1x, b1y, b1w, b1h) then
        love.graphics.setColor(255, 0, 0)
    else
        love.graphics.setColor(0, 255, 0)
    end
    love.graphics.rectangle("line", b1x, b1y, b1w, b1h)
    love.graphics.rectangle("line", mx, my, b2w, b2h)
end

function ethyl_aabb(r1x, r1y, r1w, r1h, r2x, r2y, r2w, r2h)
    if r1x + r1w >= r2x and r1x < r2x + r2w and r1y + r1h >= r2y and r1y < r2y + r2h then
        return true
    else
        return false
    end
end