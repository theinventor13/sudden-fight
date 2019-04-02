collision = {}
function collision.AABB(r1x, r1y, r1w, r1h, r2x, r2y, r2w, r2h)
	return r1x + r1w >= r2x and r1x < r2x + r2w and r1y + r1h >= r2y and r1y < r2y + r2h 
end

function collision.LL(line1, line2)
	if line1.p1x < line1.p2x then
		m1 = (line1.p2y - line1.p1y) / (line1.p2x - line1.p1x)
	else
		m1 = (line1.p1y - line1.p2y) / (line1.p1x - line1.p2x)
	end
	if line2.p1x < line2.p2x then
		m2 = (line2.p2y - line2.p1y) / (line2.p2x - line2.p1x)
	else
		m2 = (line2.p1y - line2.p2y) / (line2.p1x - line2.p2x) 
	end
	b1 = -m1 * line1.p1x + line1.p1y
	b2 = -m2 * line2.p1x + line2.p1y
	if (line1.p1y > m2 * line1.p1x + b2) == (line1.p2y > m2 * line1.p2x + b2) then
		return false
	end
	if (line2.p1y > m1 * line2.p1x + b1) == (line2.p2y > m1 * line2.p2x + b1) then
		return false
	end
end

vector = {}
function vector.normalize(vec)
	local mag = math.sqrt(vec.x * vec.x + vec.y * vec.y)
	if mag ~= 0 then
		vec.x = vec.x / mag
		vec.y = vec.y / mag
	end
end

function vector.scale(vec, scale)
	vec.x = vec.x * scale
	vec.y = vec.y * scale
end

function vector.rotate(vec)
	local newx = cos(vec.x) - sin(vec.y)
	vec.y = sin(vec.x) + cos(vec.y)
	vec.x = newx
end

function vector.translate(vec, vec2)
	vec.x = vec.x + vec2.x
	vec.y = vec.y + vec2.y
end

function vector.translate(vec, dx, dy)
	vec.x = vec.x + dx
	vec.y = vec.y + dy
end

function vector.lerp(vec, vec2, factor)
	vec.x = vec.x + (vec2.x - vec.x) * factor
	vec.y = vec.y + (vec2.y - vec.y) * factor
end

function vector.create(dx, dy)
	vec = {}
	vec.x = dx
	vec.y = dy
	return vec
end

game = {}
function initgame(sw, sh)
	game.sw = sw
	game.sh = sh
	game.swd2 = game.sw / 2
	game.shd2 = game.sh / 2
	game.quit = false
	game.fps = "0"
	game.fpstimer = 0
	game.fpsinterval = 1/5
	game.timer = 0
	game.tick = false
	game.mouse = {}
	game.mouse.v = {}
	game.mouse.v.x = 0
	game.mouse.v.y = 0
	game.mouse.sens = 1
	love.mouse.setVisible(false)
	love.mouse.setGrabbed(true)
	love.mouse.setRelativeMode(true)
	--read this and other config shit from file
	game.fullscreen = false
	game.vsync = false
	love.window.setMode(game.sw, game.sh, {centered = true, vsync = game.vsync, fullscreen = game.fullscreen})
end

function initmap()
	local map = {}
	map.tiles = love.graphics.newImage("tiles.png")
	map.batch = love.graphics.newSpriteBatch(map.tiles, 256)
	map.ts = 16, 16
	map.gw = 32
	map.gh = 32
	map.w = map.gw * map.ts
	map.h = map.gh * map.ts
	map.grid = {}
	
	local quad = {}
	quad[1] = love.graphics.newQuad(0, 0, 16, 16, map.tiles:getDimensions())
	quad[2] = love.graphics.newQuad(47, 0, 16, 16, map.tiles:getDimensions())
	
	local my, mx
	for my = 0, map.gh - 1 do
		map.grid[my] = {}
		for mx = 0, map.gw - 1 do
			if love.math.random(100) > 80 then
				map.grid[my][mx] = 1
			else
				map.grid[my][mx] = 2
			end
			map.batch:add(quad[(map.grid[my][mx])], mx * 16, my * 16)
		end
	end
	
	
	return map
end
--create local functions for all this shit
function initplayer()
	local player = {}
	player.x = 16 * 16
	player.y = 16 * 16
	player.speed = {}
	player.speed.float = 8
	player.speed.dash = 12
	player.v = {}
	player.v = vector.create(player.speed.float, player.speed.float)
	player.sprite = {}
	player.sprite.dir = 0
	player.sprite.current = "run"
	player.sprite.frame = 0
	player.sprite.timer = 0
	player.sprite.delay = .2
	player.sprite.anim = {}
	--player.sprite.anim["idle"].image = love.graphics.newImage("sprites/spirit of vengeance/idle.png")
	--player.sprite.anim["idle"].frames = 4
	player.sprite.anim["run"] = {}
	player.sprite.anim["run"].image = love.graphics.newImage("sprites/spirit of vengeance/run.png")
	player.sprite.anim["run"].frames = 4
	player.sprite.anim["run"].w = player.sprite.anim["run"].image:getWidth() / (player.sprite.anim["run"].frames * 8)
	player.sprite.anim["run"].h = player.sprite.anim["run"].image:getHeight()
	player.sprite.anim["run"].quad = {}
	for i = 0,  player.sprite.anim["run"].frames * 8 do
		player.sprite.anim["run"].quad[i] = 
		love.graphics.newQuad(i * player.sprite.anim["run"].w , 0, 
			player.sprite.anim["run"].w,
			player.sprite.anim["run"].image:getHeight(),
			player.sprite.anim["run"].image:getDimensions())
	end
	player.w = player.sprite.anim[player.sprite.current].w
	player.h = player.sprite.anim[player.sprite.current].h
	player.wd2 = player.w / 2
	player.hd2 = player.h / 2
	player.moving = false
	player.angle = {}
	player.angle.aim = 0
	player.angle.move = 0
	player.timetoshoot = 0
	player.aimfudge = .05
	player.particle = {}
	
	--implement rotating fireballs
	return player
end

function initbullet()
	local bullet = {}
	bullet.list = {}
	bullet.sprite = love.graphics.newImage("sprites/spirit of vengeance/bullet.png")
	bullet.speed = 16
	bullet.friction = .8
	return bullet
end

function initcursor()
	local cursor = {}
	cursor = vector.create(love.mouse.getX(), love.mouse.getX())
	cursor.sprite = love.graphics.newImage("crosshair.png")
	cursor.w, cursor.h = cursor.sprite:getDimensions()
	return cursor
end 

function addbullet(state, x, y, ang)
	state.bullet.list[#state.bullet.list+1] = {}
	state.bullet.list[#state.bullet.list] = vector.create(x, y)
	state.bullet.list[#state.bullet.list].v = {}
	state.bullet.list[#state.bullet.list].v = vector.create(math.cos(ang) * state.bullet.speed * state.map.ts, math.sin(ang) * state.bullet.speed * state.map.ts)
end

function updateplayer(state, dt)
	--joystick distance from center
	local joymag = 1 
	
	local dir = {}
	dir.x = (love.keyboard.isDown('a') and -1 or 0) + (love.keyboard.isDown('d') and 1 or 0)
	dir.y = (love.keyboard.isDown('w') and -1 or 0) + (love.keyboard.isDown('s') and 1 or 0)
	
	if dir.x == 0 and dir.y == 0 then
		state.player.moving = false
	else
		state.player.moving = true
		vector.normalize(dir)
		vector.scale(dir, joymag)
		state.player.angle.move = math.atan2(dir.y, dir.x)
		
		if state.player.angle.move < 0 then
			state.player.angle.move = state.player.angle.move + 2 * math.pi
		end
		state.player.angle.move  = state.player.angle.move % (2 * math.pi)
		state.player.sprite.dir = (((7 - math.floor((state.player.angle.move / (2 * math.pi)) * 8)) + 3) % 8) * 
											  state.player.sprite.anim[state.player.sprite.current].frames
		state.player.sprite.timer = state.player.sprite.timer + dt
		if state.player.sprite.timer >= state.player.sprite.delay then
			state.player.sprite.frame = (state.player.sprite.frame + 1) % 4
			state.player.sprite.timer = 0
		end
		state.player.v = vector.create(love.keyboard.isDown("lshift") and state.player.speed.dash or state.player.speed.float,
									   love.keyboard.isDown("lshift") and state.player.speed.dash or state.player.speed.float)
		
		local dx = state.player.v.x * dir.x * state.map.ts * dt
		local dy = state.player.v.x * dir.y * state.map.ts * dt
		vector.translate(state.player, dx, dy)
		
		if state.player.x < state.player.wd2 then
			state.player.x = state.player.wd2
		end
		if state.player.y < 0 then
			state.player.y = 0
		end
		if state.player.x > state.map.w - state.player.wd2 then
			state.player.x = state.map.w - state.player.wd2
		end
		if state.player.y > state.map.h then
			state.player.y = state.map.h 
		end
	end
	
	--implement wall collision
	
	if state.player.timetoshoot >= 0 then
		state.player.timetoshoot = state.player.timetoshoot - dt
	end
	
	if love.mouse.isDown(1) and state.player.timetoshoot <= 0 then
		local ang = math.atan2(state.cursor.y - state.player.y, state.cursor.x - state.player.x)
		ang = ang + (state.player.aimfudge * math.pi) * (math.random() - .5)
		addbullet(state, state.player.x, state.player.y - 16, ang)
		state.player.timetoshoot = .01
	end
	
end

function drawplayer(state)
	love.graphics.draw(state.player.sprite.anim[state.player.sprite.current].image,
						state.player.sprite.anim[state.player.sprite.current]
						.quad[state.player.sprite.dir + state.player.sprite.frame],
						math.floor(state.player.x + .5), 
						math.floor(state.player.y + .5), 
						0, 1, 1, state.player.wd2, state.player.h)
end

function updatebullet(state, dt)
	local i
	for i = #state.bullet.list, 1, -1 do
		vector.translate(state.bullet.list[i], 
						 state.bullet.list[i].v.x * dt,
						 state.bullet.list[i].v.y * dt)
		if collision.AABB(state.bullet.list[i].x, state.bullet.list[i].y, 0, 0, 0, 0, state.map.w, state.map.h) == false then
			table.remove(state.bullet.list, i)
			if #state.bullet.list == 0 then
				break
			end
		end
	end
end

function drawbullet(state)
	for i = 1, #state.bullet.list do
		love.graphics.draw(state.bullet.sprite, state.bullet.list[i].x, state.bullet.list[i].y)
	end
end

function updatemap(state, dt)
	
end

function drawmap(state)
	love.graphics.draw(state.map.batch, 0, 0)
end

function updatecursor(state)
	vector.translate(state.cursor, game.mouse.v.x * game.mouse.sens, game.mouse.v.y * game.mouse.sens)
	if state.cursor.x < state.player.x - game.swd2 then
		state.cursor.x = state.player.x - game.swd2 
	elseif state.cursor.x > state.player.x + game.swd2 - state.cursor.w then
		state.cursor.x = state.player.x + game.swd2 - state.cursor.w
	end
	if state.cursor.y < state.player.y - game.shd2 then
		state.cursor.y = state.player.y - game.shd2 
	elseif state.cursor.y > state.player.y + game.shd2 - state.cursor.h then
		state.cursor.y = state.player.y + game.shd2 - state.cursor.h
	end
end

function drawcursor(state)
	love.graphics.draw(state.cursor.sprite, math.floor(state.cursor.x + .5), math.floor(state.cursor.y + .5))
end

function debuginfo(state)
	love.graphics.print("SUDDEN FIGHT V0.1", 20, 20)
	game.fpstimer = game.fpstimer + love.timer.getDelta()
	if game.fpstimer >= game.fpsinterval then 
		game.fpstimer = 0
		game.fps = tostring(math.floor(1 / love.timer.getDelta()))
	end
	love.graphics.print("FPS: "..game.fps, 20, 40)
	love.graphics.print("Bullets: "..tostring(#state.bullet.list), 20, 60)
end

function adjustview(state)
	love.graphics.translate(math.floor(game.swd2 - gamestate.state.player.x + .5), math.floor(game.shd2 - gamestate.state.player.y + .5))
end

function game.update()
	game.mouse.v = vector.create(0,0)
	game.timer = game.timer + love.timer.getDelta()
	if game.timer >= 1 then
		game.timer = 0
		game.tick = true
	else 
		game.tick = false
	end
end
 
gamestate = {}
function gamestate.load()
	local state = {}
	state.map = initmap()
	state.player = initplayer()
	state.bullet = initbullet()
	state.cursor = initcursor()
	gamestate.state = state
end 

function gamestate.update(dt)
	if love.keyboard.isScancodeDown("escape") and gamestate.state.debounce then
		--love.event.push("quit")
		gamestate.state.debounce = false
		statelist.current = "pause"
	elseif love.keyboard.isScancodeDown("escape") == false then
		gamestate.state.debounce = true
	end
	updatebullet(gamestate.state, dt)
	updateplayer(gamestate.state, dt)
	updatecursor(gamestate.state, dt)
end 

function gamestate.draw()
	debuginfo(gamestate.state)
	adjustview(gamestate.state)
	drawmap(gamestate.state)
	drawcursor(gamestate.state)
	drawplayer(gamestate.state)
	drawbullet(gamestate.state)
end 

pausestate = {}
function pausestate.load()
	local state = {}
	state.debounce = false
	pausestate.state = state
end 

function pausestate.update(dt)
	if love.keyboard.isScancodeDown("escape") and pausestate.state.debounce then
		--love.event.push("quit")
		pausestate.state.debounce = false
		statelist.current = "game"
	elseif love.keyboard.isScancodeDown("escape") == false then
		pausestate.state.debounce = true
	end
end 

function pausestate.draw()
	love.graphics.print("PAUSED", game.swd2, game.shd2)
end 

--fix cursor problem
function love.load()
	initgame(800, 800)
	gamestate.load()
	pausestate.load()
	statelist = {}
	statelist["game"] = gamestate
	statelist["pause"] = pausestate
	statelist.current = "game"
end

function love.draw()
	statelist[statelist.current].draw()
end

function love.update(dt)
	statelist[statelist.current].update(dt)
	game.update()
end

function love.quit()
    return false
end

function love.mousemoved(x, y, dx, dy)
	game.mouse.v = vector.create(dx, dy)
end

function love.run()
	--this is default love.run with fps cap removed
	if love.load then love.load(love.arg.parseGameArguments(arg), arg) end
	if love.timer then love.timer.step() end
	local dt = 0
	return function()
		if love.event then
			love.event.pump()
			for name, a,b,c,d,e,f in love.event.poll() do
				if name == "quit" then
					if not love.quit or not love.quit() then
						return a or 0
					end
				end
				love.handlers[name](a,b,c,d,e,f)
			end
		end
		if love.timer then dt = love.timer.step() end
		if love.update then love.update(dt) end 
		if love.graphics and love.graphics.isActive() then
			love.graphics.origin()
			love.graphics.clear(love.graphics.getBackgroundColor())
 
			if love.draw then love.draw() end
 
			love.graphics.present()
		end
	end
end