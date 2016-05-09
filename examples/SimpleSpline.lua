-- @example Small example with spline.

import("sci")

-- relation btw 
waterSurface = Spline { 
	points = {  {x = 0, y = 0}, {x = 1000, y = 24.7}, 
				{x = 2000, y = 35.3}, {x = 3000, y = 48.6}, 
				{x = 4000, y = 54.3}, {x = 5000, y = 57.2}, 
				{x = 6000, y = 61.6}, {x = 7000, y = 66.0}, 
				{x = 8000, y = 69.9} },
	steps = 1
} 

spline = Model{
	data    = 0.0,
	surface = 0.0,
	finalTime     = 80,
	
	init = function(model)
		model.chart = Chart{
			target = model,
			select = {"surface", "data"}
		}


		model.timer = Timer{
			Event{action = function(ev)
				local time = ev:getTime()
				model.surface = waterSurface:value (100 * time)
				model.data    = waterSurface:value (1000 * math.floor (time/10))
			end},
			Event{action = model.chart}
		}
	end
}

spline:run()

