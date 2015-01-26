local Menu = {
    menuItems = {},
    buttonHeight = 24,
    entered = false,
    tweentime = 0.5,
    count = 0
}

function Menu:addItem( item )
    self.count = self.count + 1
    table.insert( Menu.menuItems, item )
end

local play = { name="Play", click=function( object, x, y )
    GameState.current():switch( "gamestates/test" )
end }

local options = { name="Options", click=function( object, x, y )
    GameState.current():switch( "gamestates/options" )
end }

local quit = { name="Quit", click=function( object, x, y )
    love.event.quit()
end }

Menu:addItem( play )
Menu:addItem( options )
Menu:addItem( quit )

function Menu:switch( gamestate )
    self.tween = Tween.new( self.tweentime, self.position, self.outposition, "inQuad" )
    Timer:add( self.tweentime, function()
        GameState.switch( require( PackLoader:getRequire( gamestate ) ) )
    end )
end

function Menu:enter()
    -- We use this in Menu:resize() too, so we don't use a
    -- local variable
    self.frame = loveframes.Create( "frame" )
    self.frame:SetName( "Main Menu" )
    self.frame:ShowCloseButton( false )
    self.frame:SetHeight( 250 )
    self.center = Vector( love.window.getWidth() / 2, love.window.getHeight() / 2 )
    self.outposition = Vector( -self.frame:GetWidth()/2 - self.center.x, self.center.y )
    self.position = deepcopy( self.outposition )
    self.frame:SetPos( self.position.x, self.position.y, true )
    self.tween = Tween.new( self.tweentime, self.position, self.center, "outQuad" )

    local list = loveframes.Create( "list", self.frame )
    list:SetPos( 0, 26 )
    list:SetHeight( 224 )
    list:SetPadding( 4 )
    list:SetSpacing( 4 )
    for i,v in pairs( self.menuItems ) do
        local button = loveframes.Create( "button" )
        button:SetText( v.name, self.frame )
        button.OnClick = v.click
        list:AddItem( button )
    end
    self.entered = true
end

function Menu:leave()
    self.entered = false
    loveframes.util:RemoveAll()
end

function Menu:draw()
    if self.entered then
        loveframes.draw()
    end
end

function Menu:update( dt )
    self.tween:update( dt )
    Timer:update( dt )
    self.frame:SetPos( self.position.x, self.position.y, true )
    loveframes.update( dt )
end

function Menu:mousepressed( x, y, button )
    loveframes.mousepressed( x, y, button )
end

function Menu:mousereleased( x, y, button )
    loveframes.mousereleased( x, y, button )
end

function Menu:keypressed( key, unicode )
    loveframes.keypressed( key, unicode )
end

function Menu:keyreleased( key )
    loveframes.keyreleased( key )
end

function Menu:textinput( text )
    loveframes.textinput( text )
end

function Menu:resize( w, h )
    self.center = Vector( love.window.getWidth() / 2, love.window.getHeight() / 2 )
    self.outposition = Vector( self.frame:GetWidth()/2 + self.center.x * 2, self.center.y )
    self.position = self.center
end

return Menu
