local Loading = {
    accumulator = 0,
    font = love.graphics.newFont( PackLoader:getFile( "fonts/Lato-Thin.ttf"), 64 )
}

function Loading:menu()
    GameState.switch( require( PackLoader:getRequire( "gamestates/menu" ) ) )
end

function Loading:enter()
    self.offsets = { x = self.font:getWidth( "ASTROSTRUCT" ), y = self.font:getHeight() }
    self.window = { x = love.window.getWidth(), y = love.window.getHeight() }
    Timer:add( 5, self.menu )
end

function Loading:update( dt )
    self.accumulator = self.accumulator + dt
    Timer:update( dt )
end

function Loading:draw()
    love.graphics.setColor( 255, 255, 255, math.abs( math.sin( 1.05 * self.accumulator ) ) * 255)
    love.graphics.setFont(self.font)
    love.graphics.print("ASTROSTRUCT", self.window.x / 2 - self.offsets.x / 2, self.window.y / 2 - self.offsets.y / 2)
end

return Loading
