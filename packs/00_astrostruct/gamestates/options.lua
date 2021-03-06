local OptionsMenu = {
    tweentime = 0.5
}

function OptionsMenu:switch( gamestate )
    self.tween = Tween.new( self.tweentime, self.position, self.outposition, "inQuad" )
    Timer:add( self.tweentime, function()
        GameState.switch( require( PackLoader:getRequire( gamestate ) ) )
    end )
end

function OptionsMenu:enter()
    self.frame = loveframes.Create( "frame" )
    self.frame:SetName( "Options" )
    self.frame:SetWidth( 512 )
    self.frame:SetHeight( 512 )
    self.frame:ShowCloseButton( false )
    self.center = Vector( love.window.getWidth() / 2, love.window.getHeight() / 2 )
    self.outposition = Vector( self.frame:GetWidth()/2 + self.center.x * 2, self.center.y )
    self.position = deepcopy( self.outposition )
    self.frame:SetPos( self.position.x, self.position.y, true )
    self.tween = Tween.new( self.tweentime, self.position, self.center, "outQuad" )

    local column1 = loveframes.Create( "text", self.frame )
    column1:SetText( "Option Name" )
    column1:SetPos( 15, 40 )

    local column2 = loveframes.Create( "text", self.frame )
    column2:SetText( "Option Value" )
    column2:SetPos( 512-column2:GetWidth()-15, 40 )

    local middle = loveframes.Create( "text", self.frame )
    middle:SetText( "Edit options to your liking" )
    middle:SetPos( 256-middle:GetWidth()/2, 40 )

    local list = loveframes.Create( "list", self.frame )
    list:SetSize( 512-10, 512-103 )
    list:SetPos( 5, 68 )
    list:SetPadding( 5 )
    list:SetSpacing( 5 )

    for i,v in pairs( Options.options ) do
        local t = type( v )
        local panel = loveframes.Create( "panel", list )
        panel:SetSize( 512-10-5, 40 )
        local text = loveframes.Create( "text", panel )
        text:SetPos( 5, 13 )
        text:SetText( tostring( i ) )
        if t == "string" then
            local edit = loveframes.Create( "textinput", panel )
            edit:SetWidth( 356 )
            edit:SetPos( 512-10-10-edit:GetWidth()-5, 7 )
            edit:SetText( v )
            edit.index = i
            edit.OnEnter = function( object, text )
                Options:set( object.index, object:GetText() )
            end
            edit.OnFocusLost = function( object )
                Options:set( object.index, object:GetText() )
            end
            edit.OnFocusGained = function( object )
                object:SelectAll()
            end
        elseif t == "boolean" then
            local edit = loveframes.Create( "checkbox", panel )
            edit:SetChecked( v )
            edit:SetPos( 512-40-edit:GetWidth()-5, 10 )
            edit.index = i
            edit.OnChanged = function( object, checked )
                Options:set( object.index, checked )
            end
        elseif t == "number" then
            local edit = loveframes.Create( "textinput", panel )
            edit:SetUsable( { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "." } )
            edit:SetWidth( 356 )
            edit:SetPos( 512-10-10-edit:GetWidth()-5, 7 )
            edit:SetText( v )
            edit.index = i
            edit.OnEnter = function( object, text )
                Options:set( object.index, tonumber( object:GetText() ) )
            end
            edit.OnFocusLost = function( object )
                Options:set( object.index, tonumber( object:GetText() ) )
            end
            edit.OnFocusGained = function( object )
                object:SelectAll()
            end
        end
        list:AddItem( panel )
    end

    local cancel = loveframes.Create( "button", self.frame )
    cancel:SetText( "Cancel" )
    cancel:SetPos( 5, 512 - 30 )
    cancel.OnClick = function( object, x, y )
        --We have to reset everything if we canceled
        Options:load()
        GameState.current():switch( "gamestates/menu" )
    end

    local save = loveframes.Create( "button", self.frame )
    save:SetText( "Save and Exit" )
    save:SetPos( 512 - save:GetWidth() - 5, 512 - 30 )
    save.OnClick = function( object, x, y )
        Options:save()
        GameState.current():switch( "gamestates/menu" )
    end

end

function OptionsMenu:leave()
    loveframes.util:RemoveAll()
end

function OptionsMenu:draw()
    loveframes.draw()
end

function OptionsMenu:update( dt )
    self.tween:update( dt )
    Timer:update( dt )
    self.frame:SetPos( self.position.x, self.position.y, true )
    loveframes.update( dt )
end

function OptionsMenu:mousepressed( x, y, button )
    loveframes.mousepressed( x, y, button )
end

function OptionsMenu:mousereleased( x, y, button )
    loveframes.mousereleased( x, y, button )
end

function OptionsMenu:keypressed( key, unicode )
    loveframes.keypressed( key, unicode )
end

function OptionsMenu:keyreleased( key )
    loveframes.keyreleased( key )
end

function OptionsMenu:textinput( text )
    loveframes.textinput( text )
end

function OptionsMenu:resize( w, h )
    self.center = Vector( love.window.getWidth() / 2, love.window.getHeight() / 2 )
    self.outposition = Vector( self.frame:GetWidth()/2 + self.center.x * 2, self.center.y )
    self.position = self.center
end

return OptionsMenu
