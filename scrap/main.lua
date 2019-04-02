
function love.load()
	sw = 800
	sh = 600
	love.window.setMode(sw, sh)
	oldmouse = {}
	oldmouse.x = love.mouse.getX()
	oldmouse.y = love.mouse.getY()
	cube = {}
	cube.points = {}
	cube.points[1] = {x = -1,  y =  1,  z =  1}
	cube.points[2] = {x = -1,  y = -1,  z =  1}
	cube.points[3] = {x =  1,  y = -1,  z =  1}
	cube.points[4] = {x =  1,  y =  1,  z =  1}
	cube.points[5] = {x =  1,  y =  1,  z = -1}
	cube.points[6] = {x =  1,  y = -1,  z = -1}
	cube.points[7] = {x = -1,  y = -1,  z = -1}
	cube.points[8] = {x = -1,  y =  1,  z = -1}
	cube.links = {}
	cube.links[1]  = {p1 = 1, p2 = 2}
	cube.links[2]  = {p1 = 2, p2 = 3}
	cube.links[3]  = {p1 = 3, p2 = 4}
	cube.links[4]  = {p1 = 4, p2 = 1}
	cube.links[5]  = {p1 = 1, p2 = 8}
	cube.links[6]  = {p1 = 2, p2 = 7}
	cube.links[7]  = {p1 = 3, p2 = 6}
	cube.links[8]  = {p1 = 4, p2 = 5}
	cube.links[9]  = {p1 = 5, p2 = 6}
	cube.links[10] = {p1 = 6, p2 = 7}
	cube.links[11] = {p1 = 7, p2 = 8}
	cube.links[12] = {p1 = 8, p2 = 5}
	cube.scale = {}
	cube.scale.x, cube.scale.y, cube.scale.z = 200, 200, 200
	cube.rotate = {}
	cube.rotate.x, cube.rotate.y, cube.rotate.z = 0, 0, 0
	cube.translate = {}
	cube.translate.x, cube.translate.y, cube.translate.z = 0, 0, 0
	cube.renderpoints = {}
	for i = 1, 8 do
		cube.renderpoints[i] = {}
	end
end

function love.update(dt)
	if love.mouse.isDown(1) then
		cube.rotate.y = (cube.rotate.y + 
						((love.mouse.getX() - oldmouse.x) / sw)) 
						% math.pi
		cube.rotate.x = (cube.rotate.x + 
						((love.mouse.getY() - oldmouse.y) / sh)) 
						% math.pi
	end
	oldmouse.x = love.mouse.getX()
	oldmouse.y = love.mouse.getY()
	local tx, ty, tz
	for i = 1, 8 do
		cube.renderpoints[i].x = cube.points[i].x * cube.scale.x
		cube.renderpoints[i].y = cube.points[i].y * cube.scale.y
		cube.renderpoints[i].z = cube.points[i].z * cube.scale.z
		
		tx = math.cos(cube.rotate.z) * cube.renderpoints[i].x -
			 math.sin(cube.rotate.z) * cube.renderpoints[i].y
		ty = math.sin(cube.rotate.z) * cube.renderpoints[i].x +
			 math.cos(cube.rotate.z) * cube.renderpoints[i].y 
		cube.renderpoints[i].x = tx	 
		cube.renderpoints[i].y = ty
		
		ty = math.cos(cube.rotate.x) * cube.renderpoints[i].y -
			 math.sin(cube.rotate.x) * cube.renderpoints[i].z
		tz = math.sin(cube.rotate.x) * cube.renderpoints[i].y +
			 math.cos(cube.rotate.x) * cube.renderpoints[i].z  
		cube.renderpoints[i].y = ty	 
		cube.renderpoints[i].z = tz
		
		tx = math.cos(cube.rotate.y) * cube.renderpoints[i].x -
			 math.sin(cube.rotate.y) * cube.renderpoints[i].z
		tz = math.sin(cube.rotate.y) * cube.renderpoints[i].x +
			 math.cos(cube.rotate.y) * cube.renderpoints[i].z  
		cube.renderpoints[i].x = tx	 
		cube.renderpoints[i].z = tz
		
		cube.renderpoints[i].x = cube.renderpoints[i].x + 								  cube.translate.x 
		cube.renderpoints[i].y = cube.renderpoints[i].y +
								 cube.translate.y 
		cube.renderpoints[i].z = cube.renderpoints[i].z +
								 cube.translate.z 
		
		cube.renderpoints[i].x = cube.renderpoints[i].x 
		cube.renderpoints[i].y = cube.renderpoints[i].y
	end						 
end

function love.draw()
	love.graphics.translate(sw / 2, sh / 2)
	love.graphics.setLineStyle('rough')
	for i = 1, 12 do
		love.graphics.line(cube.renderpoints[cube.links[i].p1].x, 
						   cube.renderpoints[cube.links[i].p1].y,
						   cube.renderpoints[cube.links[i].p2].x,
						   cube.renderpoints[cube.links[i].p2].y)
	end
end