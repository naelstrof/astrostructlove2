local Timer = {
    timers = {},
    accumulator = 0
}

function Timer:add( delay, callback )
    table.insert( self.timers, { when = self.accumulator + delay, callback = callback} )
end

function Timer:update( dt )
    for i,v in pairs ( self.timers ) do
        if self.accumulator > v.when then
            v.callback()
            table.remove(self.timers, i)
        end
    end
    self.accumulator = self.accumulator + dt
end

return Timer
