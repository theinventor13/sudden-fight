
function updateplayer(p)
	
	
end

function updateenemy(which)
	
	
end

function love.load()
	
	player = {}
	enemies = {}
	mapgrid = {}
	
	sw = 800
	sh = 600
	love.window.setMode(sw, sh, {centered = true})
	omx = 0
	omy = 0
	l1 = {}
	l1["p1x"] = 0
	l1["p1y"] = 0
	l1["p2x"] = sw
	l1["p2y"] = sh
	l2 = {}
	l2["p1x"] = sw
	l2["p1y"] = 0
	l2["p2x"] = 0
	l2["p2y"] = sh
	
end

function love.draw()
	
	love.graphics.setColor(255, 0, 0)
	love.graphics.line(l1.p1x, l1.p1y, l1.p2x, l1.p2y)
	love.graphics.setColor(0, 0, 255)
	love.graphics.line(l2.p1x, l2.p1y, l2.p2x, l2.p2y)
	
	if LLintersect(l1, l2) then
		love.graphics.setColor(0, 255, 0)
	else
		love.graphics.setColor(255, 255, 255)
	end
	
	love.graphics.rectangle("fill", 10, 10, 100, 100)
	
end

function love.update(dt)
	
	if love.keyboard.isDown('a') then
		l1.p1x = l1.p1x + (love.mouse.getX() - omx) 
		l1.p1y = l1.p1y + (love.mouse.getY() - omy) 
	end
	
	if love.keyboard.isDown('s') then
		l1.p2x = l1.p2x + (love.mouse.getX() - omx) 
		l1.p2y = l1.p2y + (love.mouse.getY() - omy) 
	end
	
	if love.keyboard.isDown('d') then
		l2.p1x = l2.p1x + (love.mouse.getX() - omx) 
		l2.p1y = l2.p1y + (love.mouse.getY() - omy) 
	end
	
	if love.keyboard.isDown('f') then
		l2.p2x = l2.p2x + (love.mouse.getX() - omx) 
		l2.p2y = l2.p2y + (love.mouse.getY() - omy) 
	end
	
	omx = love.mouse.getX()
	omy = love.mouse.getY()
	
end

function LLintersect(line1, line2)
	
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
	
	above = 0
	below = 0
	oops = 0
	
	if line1.p1y > m2 * line1.p1x + b2 then
		love.graphics.setColor(0, 255, 0)
		above = above + 1
	else
		love.graphics.setColor(255, 255, 0)
		below = below + 1
	end
	
	love.graphics.line(line1.p1x, line1.p1y, line1.p1x, m2 * line1.p1x + b2)
	
	if line1.p2y > m2 * line1.p2x + b2 then
		love.graphics.setColor(0, 255, 0)
		above = above + 1
	else
		love.graphics.setColor(255, 255, 0)
		below = below + 1
	end
	
	love.graphics.line(line1.p2x, line1.p2y, line1.p2x, m2 * line1.p2x + b2)
	
	if above ~= below then
		oops = oops + 1
	end
	
	above = 0
	below = 0
	
	if line2.p1y > m1 * line2.p1x + b1 then
		love.graphics.setColor(0, 255, 0)
		above = above + 1
	else
		love.graphics.setColor(255, 255, 0)
		below = below + 1
	end
	
	love.graphics.line(line2.p1x, line2.p1y, line2.p1x, m1 * line2.p1x + b1)
	
	if line2.p2y > m1 * line2.p2x + b1 then
		love.graphics.setColor(0, 255, 0)
		above = above + 1
	else
		love.graphics.setColor(255, 255, 0)
		below = below + 1
	end
	
	love.graphics.line(line2.p2x, line2.p2y, line2.p2x, m1 * line2.p2x + b1)
	
	if above ~= below then
		oops = oops + 1
	end
	
	return (oops == 0)
	
end