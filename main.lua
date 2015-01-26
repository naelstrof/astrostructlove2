require( "src/helper" )
loveframes = require( "src.LoveFrames" )
Tserial = require( "src/tserial" )
Class = require( "src/30log" )
Vector = require( "src/vector" )
Camera = require( "src/camera" )
Entity = require( "src/entity" )
Entities = require( "src/entities" )
World = require( "src/world" )
Render = require( "src/render" )
Timer = require( "src/timer" )
Options = require( "src/options" )
GameState = require( "src/gamestate" )
PackLoader = require( "src/packloader" ):init()

function love.load()
    love.math.setRandomSeed( love.timer.getTime() )
    Options:load()
    love.window.setMode( Options:get( "windowedWidth" ),
                         Options:get( "windowedHeight" ),
                         {
                             resizable = true,
                             vsync = true,
                             fullscreentype = "desktop",
                             fullscreen = Options:get( "fullscreen" )
                         } )
    GameState.registerEvents()
    GameState.switch( require( PackLoader:getRequire( "gamestates/loading" ) ) )
end
