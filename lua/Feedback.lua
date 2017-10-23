
-- @header Some basic and useful functions for modeling feedbacks.

--- Return the decay of a rate given a time interval.
-- The returned value can be directly multipled to compute
-- the updated value applying the given decay.
-- @arg rate A decay rate per time unit. For example, a value of 0.2 means
-- that there will be a decrease of 20% each time step.
-- @arg dt A time interval or an Event. In the latter case, this function
-- will use the Event's period as a time interval. The returning value is
-- (1 - #1) ^ #2. For example, if the
-- time interval is equals to one, the returning value will be one
-- minus #1.
-- @usage import("sci")
--
-- decay(0.5, 1) -- 0.5 (decay of 50% in one time step)
-- decay(0.1, 1/12) -- 10% per year in one month will be 0.99125 (reducing 0.875% per month)
function decay(rate, dt)
	if type(dt) == "Event" then
		dt = dt:getPeriod()
	end

	return (1 - rate) ^ dt
end

--- Return the growth of a rate given a time interval.
-- The returned value can be directly multipled to compute
-- the updated value applying the given growth.
-- @arg rate A growth rate per time unit. For example, a value of 0.2 means
-- that there will be 20% of growth each time step.
-- @arg dt A time interval or an Event. In the latter case, this function
-- will use the Event's period as a time interval. The returning value is
-- (1 + #1) ^ #2. For example, if the
-- time interval is equals to one, the returning value will be one
-- plus #1.
-- @usage import("sci")
--
-- growth(0.5, 1) -- 1.5 (growth of 50% in one time step)
-- growth(0.1, 1/12) -- 10% per year in one month will be 1.00797 (increasing 0.797% per month)
function growth(rate, dt)
	if type(dt) == "Event" then
		dt = dt:getPeriod()
	end

	return (1 + rate) ^ dt
end

