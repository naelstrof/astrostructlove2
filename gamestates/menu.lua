local Test = {
    accumulator = 0,
    previousWorld = nil,
    currentWorld = nil,
    worldAlpha = 0,
    camera = Camera:new( 0, 0 ),
    timestep = 1/60 -- 60 fps
}

function Test:enter()
    local gamemode = require( PackLoader:getRequire( "gamemodes/test" ) )
    self.currentWorld = World:new()
    gamemode:init( self.currentWorld )
    self.previousWorld = deepcopy( self.currentWorld )
end

function Test:update( dt )
    self.accumulator = self.accumulator + dt
    if ( self.accumulator >= self.timestep ) then
        self.previousWorld = deepcopy( self.currentWorld )
    end
    while( self.accumulator >= self.timestep ) do
        self.currentWorld:update( self.timestep )
        self.accumulator = self.accumulator - self.timestep
    end
    self.worldAlpha = self.accumulator / self.timestep
end

function Test:draw()
    -- Interpolate
    local interpolation = deepcopy( self.currentWorld )
    local interpolation2 = deepcopy( self.previousWorld )
    interpolation:mul( self.worldAlpha )
    interpolation2:mul( 1 - self.worldAlpha )
    interpolation:add( interpolation2 )
    Render:render( interpolation, self.camera )
end

return Test
