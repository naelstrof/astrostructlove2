local Lobby = {
    gamemode = "test",
    players = {}
}

function Lobby:enter()
end

function Lobby:update( dt )
end

function Lobby:leave()
end

function Lobby:connect( peer )
    local player = {}
    player.peer = peer
    table.insert( players, player )
    local packet = {}
    packet.gamemode = self.gamemode
    packet.players = self.players
    peer:send( Tserial.pack( packet ), 1, "reliable" )
end

function Lobby:receive( peer )
end

return Lobby
