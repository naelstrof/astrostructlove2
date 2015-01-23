-- Entity, an empty shell of attributes. Gets its metadata from its components.

local Entity = Class( "Entity", {
    components = {},
    mixed = false,
    chains = {}
} )

function Entity:__addrecurse( t, a )
    for i,v in pairs( t ) do
        if type(v) == "number" then
            t[i] = t[i] + a[i]
        elseif type( v ) == "table" and i ~= "__index" then
            self:__addrecurse( v, a[i] )
        end
    end
    return t
end

function Entity:__add( a )
    self:__addrecurse( self, a )
    return self
end

function Entity:__mulrecurse( t, a )
    for i,v in pairs( t ) do
        if type( v ) == "number" then
            t[i] = v * a
        elseif type( v ) == "table" and i ~= "__index" then
            self:__mulrecurse( v, a )
        end
    end
    return t
end

function Entity:__mul( a )
    assert( type( a ) == "number", "Wrong type" )
    self:__mulrecurse( self, a )
    return self
end

function Entity:startChain( i, args )
    for i,v in pairs( chains[i] ) do
        self:v( unpack( args ) )
    end
end

function Entity:chainFunction( i, v )
    assert( type( v ) == "function", "Wrong type" )
    if chains[i] == nil and type( self[i] ) == "function" then
        chains[i] = { self[i] }
        self[i] = function( ... )
            self:startChain( i, { ... } )
        end
    end
    table.insert( chains[i], v )
end

function Entity:override( attributes )
    for i,v in pairs( attributes ) do
        self[i] = deepcopy( v )
    end
    return self
end

function Entity:mix( component )
    for i,v in pairs( component ) do
        if self[i] == nil then
            self[i] = deepcopy( v )
        elseif type( self[i] ) == "function" and type( v ) == "function" then
            self:chainFunction( i, v )
        end
    end
    return self
end

function Entity:init( attributes )
    if attributes ~= nil then
        self:mix( attributes )
    end
    -- We really don't want to mix twice
    -- it would double chain up functions
    -- and cause LOTS of unecessary processing.
    if self.mixed then
        return
    end
    for i,v in pairs( self.components ) do
        self:mix( v )
    end
    self.mixed = true
end

function Entity:tostring()
    return "Entity"
end

return Entity
