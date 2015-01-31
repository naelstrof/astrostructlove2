-- main.lua: prepares the game to be played
-- Loads what it can during the intro animation, instead of on init
Tween = require( "src/tween" )
Timer = require( "src/timer" )
Tserial = require( "src/tserial" )
GameState = require( "src/gamestate" )
Options = require( "src/options" )
Vector = require( "src/vector" )
PackLoader = require( "src/packloader" ):init()

function love.load()
    love.math.setRandomSeed( love.timer.getTime() )
    Options:load()
    love.window.setTitle( "Astrostruct" )
    love.window.setMode( Options:get( "windowedWidth" ),
                         Options:get( "windowedHeight" ),
                         {
                             resizable = true,
                             vsync = true,
                             fullscreentype = "desktop",
                             fullscreen = Options:get( "fullscreen" )
                         } )
    GameState.registerEvents()
    local loader = require( PackLoader:getRequire( "gamestates/loading" ) )
    loader:setLoadFunction( function()
        require( "src/helper" )
        Camera = require( "src/camera" )
        Class = require( "src/30log" )
        Render = require( "src/render" )
        World = require( "src/world" )
        Entity = require( "src/entity" )
        Entities = require( "src/entities" )
        loveframes = require( "src.LoveFrames" )
    end )
    loader:setSwitchTarget( "gamestates/menu" )
    GameState.switch( loader )
end

function love.threaderror( thread, errorstr )
    error( "Thread error!\n" .. errorstr )
end
