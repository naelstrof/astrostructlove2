local Lobby = {
    ip = "*",
    isHost = false,
    port = "27020"
}

function Lobby:enter()
    Client:start( self.ip, self.port )
    if self.ip == "*" then
        self.isHost = true
    end

    if self.isHost == true then
        self:spawnHostPanel()
    else
        self:spawnClientPanel()
    end
end

function Lobby:leave()
    loveframes.util:RemoveAll()
end

function Lobby:update( dt )
    loveframes.update( dt )
end

function Lobby:mousepressed( x, y, button )
    loveframes.mousepressed( x, y, button )
end

function Lobby:mousereleased( x, y, button )
    loveframes.mousereleased( x, y, button )
end

function Lobby:keypressed( key, unicode )
    loveframes.keypressed( key, unicode )
end

function Lobby:keyreleased( key )
    loveframes.keyreleased( key )
end

function Lobby:textinput( text )
    loveframes.textinput( text )
end

function Lobby:draw()
    loveframes.draw()
end

function Lobby:spawnHostPanel()
    self.frame = loveframes.Create( "frame" )
    self.frame:SetName( "Game Lobby" )
    self.frame:ShowCloseButton( false )
    self.frame:SetHeight( 250 )
end

return Lobby
