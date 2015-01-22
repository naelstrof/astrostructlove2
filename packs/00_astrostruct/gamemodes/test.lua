local Test = {}

function Test:init( world )
    self.ent = Entities:spawn( "test" )
    table.insert( world.entities, self.ent )
end

return Test
