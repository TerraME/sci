
local function buildSpline(self)
	-- build a Catmull-Roll spline
	local points = self.points
	local steps  = self.steps or 10

	local values = {}

	if #points < 3 then
		return points
	end
	local count = #points - 1
	local p0, p1, p2, p3

	for i = 1, count do
		if i == 1 then
			p0, p1, p2, p3 = points[i], points[i], points[i + 1], points[i + 2]
		elseif i == count then
			p0, p1, p2, p3 = points[#points - 2], points[#points - 1], points[#points], points[#points]
		else
			p0, p1, p2, p3 = points[i - 1], points[i], points[i + 1], points[i + 2]
		end
		-- interpolate "step" new points btw two data points
		for t = 0, 1, 1 / steps do
			local x = 0.5 * ((2 * p1.x) + (p2.x - p0.x) * t + (2 * p0.x - 5 * p1.x + 4 * p2.x - p3.x) * t * t + (3 * p1.x - p0.x - 3 * p2.x + p3.x) * t * t * t)
			local y = 0.5 * (( 2 * p1.y) + (p2.y - p0.y) * t + (2 * p0.y - 5 * p1.y + 4 * p2.y - p3.y) * t * t + (3 * p1.y - p0.y - 3 * p2.y + p3.y) * t * t * t)

			--prevent duplicate entries
			if next(values) == nil then  -- table is empty, insert first point
				table.insert(values, {x = x , y = y})
			elseif values[#values].x ~= x and values[#values].y ~= y then
				table.insert(values, {x = x , y = y})
			end
		end
	end

	return values
end

Spline_ = {
	type_ = "Spline",
	--- Returns the value of the spline for a given value.
	-- @arg t A number value.
	-- @usage import("sci")
	--
	-- waterSurface = Spline{
	--     points = DataFrame{
	--         x = {0, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000},
	--         y = {0, 24.7, 35.3, 48.6, 54.3, 57.2, 61.6, 66.0, 69.9}
	--     }
	-- }
	--
	-- print(waterSurface:value(1500))
	value = function(self, t)
		local iStart, iEnd = 1, #self.values
		local iMid

		verify(self.values[iEnd].x >= t, " values outside range - last value is smaller that requested")
		verify(self.values[iStart].x  <= t, " values outside range - first value is bigger than requested")

		while true do
			iMid = math.floor((iStart + iEnd) / 2)
			if self.values[iMid].x == t then 
				return self.values[iMid].y
			else if self.values[iMid].x < t then
					if self.values[iMid + 1].x < t then
						iStart = iMid
					else
						local w = (t - self.values[iMid].x) / (self.values[iMid + 1].x - self.values[iMid].x)
						return (1 - w) * self.values[iMid].y + w * self.values[iMid + 1].y
					end
				else -- self.values[iMid].x > t
					iEnd = iMid
				end
			end
		end
	end
}

metaTableSpline_ = {__index = Spline_}

--- Build a Catmull-Roll spline from a set of points and returns interpolated value.
-- @arg argv.points the set of x-ordered points in format { { x = x0, y = y0 }, { x = x1, y = y1 }, ....}.
-- @arg argv.steps  how many points to interpolate btw two data points. Default is 10.
-- @usage import("sci")
--
-- waterSurface = Spline{
--     points = DataFrame{
--         x = {0, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000},
--         y = {0, 24.7, 35.3, 48.6, 54.3, 57.2, 61.6, 66.0, 69.9}
--     }
-- } 
function Spline(argv)
	mandatoryTableArgument(argv, "points", "DataFrame")
	defaultTableValue(argv, "steps", 10)

	setmetatable(argv, metaTableSpline_)

	argv.values = buildSpline(argv)

	return argv
end

