
return{
	decay = function(unitTest)
		unitTest:assertEquals(decay(0.2, 1), 0.8)
		unitTest:assertEquals(decay(1, 1), 0)
		unitTest:assertEquals(decay(0.1, 1/12), 0.99125, 0.0001)

		local Flowers = Model{
			step = 0.05,
			finalTime = 10,
			area = 10,
			execute = function(self, ev)
				self.area = self.area * decay(0.2, ev)
			end,
			init = function(self)
				if self.step == 1 then self.step = nil end

				self.timer = Timer{
					Event{action = self, period = self.step}
				}
			end
		}

		local env = Environment{
			f200 = Flowers{step = 2},
			f100 = Flowers{step = 1},
			f050 = Flowers{step = 0.5},
			f010 = Flowers{step = 0.1}
		}

		env:run()

		forEachModel(env, function(model)
			unitTest:assertEquals(model.area, 1.07374, 0.001)
		end)
	end,
	growth = function(unitTest)
		unitTest:assertEquals(growth(0.5, 1), 1.5)
		unitTest:assertEquals(growth(1, 1), 2)
		unitTest:assertEquals(growth(0.2, 0.5), 1.09544, 0.0001)
		unitTest:assertEquals(growth(0.1, 1/12), 1.00797, 0.0001)

		local Flowers = Model{
			step = 0.05,
			finalTime = 10,
			area = 10,
			execute = function(self, ev)
				self.area = self.area * growth(0.2, ev)
			end,
			init = function(self)
				if self.step == 1 then self.step = nil end

				self.timer = Timer{
					Event{action = self, period = self.step}
				}
			end
		}

		local env = Environment{
			f200 = Flowers{step = 2},
			f100 = Flowers{step = 1},
			f050 = Flowers{step = 0.5},
			f010 = Flowers{step = 0.1}
		}

		env:run()

		forEachModel(env, function(model)
			unitTest:assertEquals(model.area, 61.9173, 0.001)
		end)
	end
}

