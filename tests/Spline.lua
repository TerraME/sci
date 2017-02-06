-- Test file for Spline.lua
-- Author: Gilberto Camara

return{
	Spline = function(unitTest)
		local waterSurface = Spline {
			points = DataFrame{
				x = {0, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000},
				y = {0, 24.7, 35.3, 48.6, 54.3, 57.2, 61.6, 66.0, 69.9}
			}
		}

		unitTest:assertType(waterSurface, "Spline")
	end,
	value = function(unitTest)
		local waterSurface = Spline {
			points = DataFrame{
				x = {0, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000},
				y = {0, 24.7, 35.3, 48.6, 54.3, 57.2, 61.6, 66.0, 69.9}
			}
		}

		unitTest:assertEquals(waterSurface:value(1500), 30.7125, 0.0001)
	end
}

