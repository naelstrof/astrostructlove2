local Loading = {
    font = love.graphics.newFont( PackLoader:getFile( "fonts/Lato-Thin.ttf"), 64 ),
    switchtarget = "gamestates/menu",
    tweentime = 2,
    loader = nil
}

function Loading:setSwitchTarget( target )
    self.switchtarget = target
end

function Loading:setLoadFunction( func )
    self.loader = func
end

function Loading:enter()
    self.offsets = -Vector( self.font:getWidth( "ASTROSTRUCT" ), self.font:getHeight() ) / 2
    self.color = { a = 0 }
    self.t = Tween.new( self.tweentime/2, self.color, { a = 255 }, "outQuart" )
    Timer:add( self.tweentime/2, function(obj)
        obj.t = Tween.new( self.tweentime/2, obj.color, { a = 0 }, "inQuart" )
    end, self )
    Timer:add( self.tweentime/2 , self.loader )
    Timer:add( self.tweentime, function()
        GameState.switch( require( PackLoader:getRequire( self.switchtarget ) ) )
    end )
end

function Loading:update( dt )
    -- During loading we're going to have HUGE dt's which will cause the animation to not smoothly finish
    -- So we cap it.
    if dt > 1/60 then
        dt = 1/60
    end
    self.position = Vector( love.window.getWidth() / 2, love.window.getHeight() / 2 )
    self.position = self.position + self.offsets
    self.t:update( dt )
    Timer:update( dt )
end

function Loading:draw()
    love.graphics.setColor( 255, 255, 255, self.color.a )
    love.graphics.setFont( self.font )
    love.graphics.print( "ASTROSTRUCT", self.position.x, self.position.y )
end

return Loading
