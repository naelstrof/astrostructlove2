local Server = {
    host = nil,
    peers = {},
    players = {}
}

function Server:start( ip, port )
    assert( type( ip ) == "string", "Argument #1 needs to be a string!" )
    assert( type( port ) == "string", "Argument #2 needs to be a string!" )
    if self.host then
        error( "Error. Host is already started!" )
    end
    self.host = enet.host_create( ip .. ":" .. port )
    if not self.host then
        error( "Failed to bind to address " .. ip .. ":" .. port .. "! It's probably in use already." )
    end
    self.peers = {}
    print( "Created a listen server on " .. self.host:get_socket_address() )
end

function Server:update()
    local event = sef.host:service()
    while event do
        if event.type == "receive" then
        elseif event.type == "connect" then
        elseif event.type == "disconnect" then
        end
    end
end

function Server:stop()
    for i,v in pairs( self.peers ) do
        v:disconnect_now()
    end
    self.peers = {}
    self.host:destroy()
    self.host = nil
end

return Server
