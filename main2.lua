-- REEEEEEEEEEEEEEEEE


function makeBul(x, y, vx, vy, damage)
  local bul = {}
  bul.x = x
  bul.y = y
  bul.vx = vx
  bul.vy = vy
  bul.damage = damage
  return bul
end

function makeEnemy(x, y, g, hp, maxhp, imToPl, damage, ImFram)
  local enemy = {}
  enemy.x = x
  enemy.y = y
  enemy.g = g
  enemy.hp = hp
  enemy.maxhp = maxhp
  enemy.imToPl = imToPl
  enemy.damage = damage
  enemy.ImFram = ImFram
  return enemy
end

-- 800, 600
function intersects(r1x, r1y, r1w, r1h, r2x, r2y, r2w, r2h)
    if r1x + r1w >= r2x and r1x < r2x + r2w and r1y + r1h >= r2y and r1y < r2y + r2h then
        return true
    else
        return false
    end
end

function love.load()
  g = 700.0
  ply = 0.0
  pyv = 0.0
  plx = 700.0
  cooldown = 0
  grounded = false
  bulletsPl = {}
  bulletsEn = {}
  hp = 100
  maxHp = 100
  immunityFrames = 0
  damage = 5
  enemy = makeEnemy(100, 0, 0, 100, 100, 1, 1, 30)
end

function love.draw()
  love.graphics.print(g , 2, 30)
  love.graphics.print(pyv , 2, 60)
  love.graphics.print(ply , 2, 90)
  love.graphics.setColor(255, 0, 0)
  love.graphics.rectangle("fill", plx, ply, 10, 20)
  love.graphics.setColor(10, 10, 10, 0.5)
  love.graphics.rectangle("fill", 0, 500, 800, 100)
  love.graphics.setColor(255, 0, 0)
  for i = 1, #bulletsPl do
    love.graphics.ellipse("fill", bulletsPl[i].x, bulletsPl[i].y, 2, 2)
  end
  love.graphics.setColor(255, 0, 0)
  love.graphics.rectangle("fill", 450, 20, 300, 20)
  love.graphics.setColor(255, 255, 0)
  love.graphics.rectangle("fill", 450, 20, 300 * (hp / maxHp), 20)
  if enemy ~= nil then
    love.graphics.setColor(0, 255, 0)
    love.graphics.rectangle("fill", enemy.x, enemy.y, 10, 20)
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle("fill", 50, 20, 300, 20)
    love.graphics.setColor(255, 255, 0)
    love.graphics.rectangle("fill", 50, 20, 300 * (enemy.hp / enemy.maxhp), 20)
  end
end

function love.update(dt)
  if enemy ~= nil then
    enemy.g = enemy.g + dt * 600
    if intersects(enemy.x, enemy.y, 10, 20, 0, 500, 800, 100) then
      enemy.g = 0
      enemy.y = 500 - 20
    else
      enemy.y = enemy.y + enemy.g * dt
    end
  end
  immunityFrames = immunityFrames + dt
  cooldown = cooldown + dt
  if enemy ~= nil and intersects(plx, ply, 10, 20, enemy.x, enemy.y, 10, 20) and immunityFrames > enemy.imToPl * dt and hp >= enemy.damage then
    hp = hp - enemy.damage
    immunityFrames = 0
  end
  if enemy ~= nil then
    enemy.ImFram = enemy.ImFram + dt
  end
  for i = 1, #bulletsPl do
    if enemy ~= nil and intersects(bulletsPl[i].x, bulletsPl[i].y, 2, 2, enemy.x, enemy.y, 10, 20) and enemy.hp >= bulletsPl[i].damage and enemy.ImFram > 5 * dt then
      enemy.hp = enemy.hp - damage
      enemy.ImFram = 0
    end
    bulletsPl[i].x = bulletsPl[i].x + bulletsPl[i].vx * dt
    bulletsPl[i].y = bulletsPl[i].y + bulletsPl[i].vy * dt
    if bulletsPl[i].x > 800 or bulletsPl[i].x < 0 or bulletsPl[i].y > 600 or bulletsPl[i].y < 0 then
      table.remove(bulletsPl, i)
      break
    end
  end
  if enemy ~= nil and enemy.hp <= 0 then
    enemy = makeEnemy(100, 0, 0, 100, 100, 1, 1, 30) 
  end
  
  if (love.keyboard.isDown("left") or love.keyboard.isDown("a")) and plx > 0 then
    if grounded then
      plx = plx - 5 * dt * 60
    else
      plx = plx - 5 * dt * 50
    end
  elseif (love.keyboard.isDown("right") or love.keyboard.isDown("d")) and plx < 790 then
    if grounded then
      plx = plx + 5 * dt * 60
    else
      plx = plx + 5 * dt * 50
    end
  end
  
  pyv = pyv + g * dt
  ply = ply + pyv * dt
 
  if ply > 500 - 20 then
      ply = 500 - 20
      pyv = 0
      grounded = true
  end
  
  if love.mouse.isDown(1) and cooldown > 10 * dt then
    table.insert(bulletsPl, makeBul(plx + 2, ply + 2, math.sin(math.atan2(love.mouse.getX() - plx + 2, love.mouse.getY() - ply + 2) ) * 500, math.cos(math.atan2(love.mouse.getX() - plx + 2, love.mouse.getY() - ply + 2)) * 500, 5))
    cooldown = 0
  end
end

function love.keypressed(key, scancode, isrepeat)
  if key == "w" and isrepeat == false and grounded then
    pyv = -200.0
    grounded = false
  end
end


