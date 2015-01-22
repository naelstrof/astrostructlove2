-- Keeps track of and updates the states of all entities.

local World = Class( "World", {
    entities = {},
    time = 0
} )

function World:__add( a )
    assert( Class.isInstance( a, World ), "Wrong type" )
    for i,v in pairs( self.entities ) do
        self.entities[i] = v + a[i]
    end
    return self
end

function World:__mul( a )
    assert( type(a) == "number", "Wrong type" )
    for i,v in pairs( self.entities ) do
        self.entities[i] = v * a
    end
    return self
end

function World:update( dt )
    for i,v in pairs( self.entities ) do
        v:update( dt )
    end
    self.time = self.time + dt
end

return World
