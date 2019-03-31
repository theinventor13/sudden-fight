
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
	
	if (line1.p1y > m2 * line1.p1x + b2) == (line1.p2y > m2 * line1.p2x + b2) then
		return false
	end
	
	
	if (line2.p1y > m1 * line2.p1x + b1) == (line2.p2y > m1 * line2.p2x + b1) then
		return false
	end
	
end