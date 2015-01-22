local Entities = {
    entities = {}
}

function Entities:spawn( name, attributes )
    if self.entities[name] == nil then
        self.entities[name] = ( require( PackLoader:getRequire( "entities/" .. name ) ) )
    end
    return self.entities[name]:new( attributes )
end

return Entities
