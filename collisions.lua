
collisions = {}

function collisions.AABB(r1x, r1y, r1w, r1h, r2x, r2y, r2w, r2h)
	return r1x + r1w >= r2x and r1x < r2x + r2w and r1y + r1h >= r2y and r1y < r2y + r2h 
end

function collisions.LL(line1, line2)
	
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