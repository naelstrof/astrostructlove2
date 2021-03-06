require( "love.filesystem" )
require( "love.math" )
require( "love.audio" )
require( "love.timer" )
require( "enet" )
require( "src/helper" )
Tserial = require( "src/tserial" )
Class = require( "src/30log" )
Vector = require( "src/vector" )
Camera = require( "src/camera" )
Entity = require( "src/entity" )
Entities = require( "src/entities" )
World = require( "src/world" )
Render = require( "src/render" )
-- Options = require( "src/options" )
GameState = require( "src/gamestate" )
PackLoader = require( "src/packloader" ):init()
Server = require( "src/network/server" )

love.math.setRandomSeed( love.timer.getTime() )
Server:start( "*", "27020" )
GameState.registerEvents()
GameState.switch( require( PackLoader:getRequire( "gamestates/server/lobby" ) ) )

while( true ) do
    GameState.update( love.timer.getDelta() )
end
