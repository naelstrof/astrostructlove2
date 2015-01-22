local Default = {
    position = Vector( 0, 0 ),
    depth = 0,
    rotation = 0
}

function Default:getPos()
    return self.position
end

function Default:setPos( t )
    assert( Vector.isvector( t ), "Wrong argument types (<vector> expected)" )
    self.position = t
end

function Default:setRot( r )
    self.rotation = r
end

function Default:getRot()
    return self.rot
end

return Default
