local Menu = {
    menuItems = {},
    buttonHeight = 24,
    count = 0
}

function Menu:addItem( item )
    self.count = self.count + 1
    table.insert( Menu.menuItems, item )
end

local play = { name="Play", click=function( object, x, y )
    GameState.switch( require( PackLoader:getRequire( "gamestates/test" ) ) )
end }

local options = { name="Options", click=function( object, x, y )
    GameState.switch( require( PackLoader:getRequire( "gamestates/options" ) ) )
end }

local quit = { name="Quit", click=function( object, x, y )
    love.event.quit()
end }

Menu:addItem( play )
Menu:addItem( options )
Menu:addItem( quit )

function Menu:enter()
    -- We use this in Menu:resize() too, so we don't use a
    -- local variable
    self.frame = loveframes.Create( "frame" )
    self.frame:SetName( "Main Menu" )
    self.frame:ShowCloseButton( false )
    self.frame:SetHeight( 250 )
    self.frame:Center() self.frame = loveframes.Create( "frame" )
    self.frame:SetName( "Main Menu" )
    self.frame:ShowCloseButton( false )
    self.frame:SetHeight( 250 )
    self.frame:Center()

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
end

function Menu:leave()
    loveframes.util:RemoveAll()
end

function Menu:draw()
    loveframes.draw()
end

function Menu:update( dt )
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
    self.frame:Center()
end

return Menu
