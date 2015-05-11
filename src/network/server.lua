local Server = {
    host = nil,
    peers = {},
    callbackobject = nil,
    callbacks = {},
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

function Server:setCallbacks( object, receive, disconnect, connect )
    self.callbackobject = object
    self.callbacks.receive = receive
    self.callbacks.disconnect = disconnect
    self.callbacks.connect = connect
end

function Server:update()
    local event = self.host:service()
    while event do
        if event.type == "receive" then
            if self.callbacks.receive then
                self.callbacks.receive( self.callbackobject, event )
            end
        elseif event.type == "connect" then
            if self.callbacks.connect then
                self.callbacks.connect( self.callbackobject, event )
            end
        elseif event.type == "disconnect" then
            if self.callbacks.disconnect then
                self.callbacks.disconnect( self.callbackobject, event )
            end
        end
    end
end

function Server:send( message, channel, flag )
    flag = flag or "unreliable"
    channel = channel or 0
    self.host:broadcast( message, channel, flag )
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
