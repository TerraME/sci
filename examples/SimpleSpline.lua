if not isLoaded("sci") then
	import("sci")
end

if not isLoaded("sysdyn") then
	import("sysdyn")
end


-- relation btw 
waterSurface = Spline { 
    points = {  {x = 0, y = 0}, {x = 1000, y = 24.7}, 
                {x = 2000, y = 35.3}, {x = 3000, y = 48.6}, 
                {x = 4000, y = 54.3}, {x = 5000, y = 57.2}, 
                {x = 6000, y = 61.6}, {x = 7000, y = 66.0}, 
                {x = 8000, y = 69.9} },
    steps = 1
} 

spline = SysDynModel {
    data    = 0.0,
    surface = 0.0,
    finalTime     = 80,
    
    changes = function (model, time)
        model.surface = waterSurface:value (100*time)
        model.data    = waterSurface:value (1000*math.floor (time/10))
    end,
    
    graphics =  { timeseries = { {"surface", "data"}}}
}
        
spline:execute()
