local Test = Entity:extend( "Test", {
    components = {
        require( PackLoader:getRequire( "components/default" ) ),
        require( PackLoader:getRequire( "components/drawable" ) ),
        require( PackLoader:getRequire( "components/movesright" ) )
    }
} )

return Test
