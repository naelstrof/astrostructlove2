local Drawable = {
    drawable = love.graphics.newImage( PackLoader:getFile( "textures/null.png" ) ),
    originoffset = Vector( 0, 0 ),
    scale = Vector( 1, 1 ),
    color = { 255, 255, 255, 255 }
}

function Drawable:setDrawable( object )
    if self.originoffset == nil then
        self.originoffset = Vector( self.drawable:getWidth() / 2, self.drawable:getHeight() / 2 )
    end
    self.drawable = object
end

function Drawable:getDrawable()
    return self.drawable
end

function Drawable:setScale( t )
    assert( Vector.isvector( t ), "Wrong argument types (<vector> expected)" )
    self.scale = t
end

function Drawable:getScale()
    return self.scale
end

return Drawable
