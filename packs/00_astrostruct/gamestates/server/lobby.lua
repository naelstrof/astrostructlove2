local Lobby = {
    gamemode = "test",
    players = {}
}

function Lobby:enter()
    Server:setCallbacks( self, receive, disconnect, self.connect )
end

function Lobby:update( dt )
end

function Lobby:leave()
end

function Lobby:disconnect( peer )
    for i,v in pairs( self.players ) do
        if v.peer == peer then
            self.players[i] = nil
            v = nil
            i = nil
            break
        end
    end
end

function Lobby:receive( peer )
end

function Lobby:connect( peer )
    local player = {}
    player.peer = peer
    table.insert( self.players, player )
    local packet = {}
    packet.gamemode = self.gamemode
    packet.players = self.players
    peer:send( Tserial.pack( packet ), 1, "reliable" )
end

function Lobby:receive( peer )
end

return Lobby
