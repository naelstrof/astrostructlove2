local Test = {
    accumulator = 0,
    previousWorld = nil,
    currentWorld = nil,
    worldAlpha = 0,
    camera = Camera:new( 0, 0 ),
    timestep = 1/30
}

function Test:enter()
    local gamemode = require( PackLoader:getRequire( "gamemodes/test" ) )
    self.currentWorld = World:new()
    self.previousWorld = World:new()
    gamemode:init( self.currentWorld )
end

function Test:update( dt )
    self.accumulator = self.accumulator + dt
    self.previousWorld = deepcopy( self.currentWorld )
    while( self.accumulator >= self.timestep ) do
        self.currentWorld:update( self.timestep )
        self.accumulator = self.accumulator - self.timestep
    end
    self.worldAlpha = self.accumulator / self.timestep
end

function Test:draw()
    -- Interpolate
    Render:render( self.previousWorld * (1 - self.worldAlpha) + self.currentWorld * self.worldAlpha, self.camera )
end

return Test
