-- Test file for Spline.lua
-- Author: Gilberto Camara

return{
	Spline = function(unitTest)
		local waterSurface = Spline { 
		    points = {  {x = 0, y = 0}, {x = 1000, y = 24.7}, 
		                {x = 2000, y = 35.3}, {x = 3000, y = 48.6}, 
		                {x = 4000, y = 54.3}, {x = 5000, y = 57.2}, 
		                {x = 6000, y = 61.6}, {x = 7000, y = 66.0}, 
		                {x = 8000, y = 69.9} }
		} 

		unitTest:assertType(waterSurface, "Spline")
	end,
	value = function(unitTest)
		local waterSurface = Spline { 
		    points = {  {x = 0, y = 0}, {x = 1000, y = 24.7}, 
		                {x = 2000, y = 35.3}, {x = 3000, y = 48.6}, 
		                {x = 4000, y = 54.3}, {x = 5000, y = 57.2}, 
		                {x = 6000, y = 61.6}, {x = 7000, y = 66.0}, 
		                {x = 8000, y = 69.9} }
		} 

		unitTest:assertEquals(waterSurface:value(1500), 30.7125, 0.0001)
	end,
}

