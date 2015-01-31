local Client = {
    host = nil,
    server = nil,
    callbacks = {},
}

function Client:start( ip, port )
    assert( type( ip ) == "string", "Argument #1 needs to be a string!" )
    assert( type( port ) == "string", "Argument #2 needs to be a string!" )
    if self.host then
        error( "Error. Host is already started!" )
    end
    self.host = enet.host_create()
    if not self.host then
        error( "Enet failed to create a generic host! I had no idea this was possible to be honest." )
    end
    self.server = self.host:connect( ip .. ":" .. port )
    if not self.server then
        error( "Enet failed to create a peer, this shouldn't ever happen either..." )
    end
end

function Client:setCallbacks( object, receive, disconnect, connect )
    self.callbackobject = object
    self.callbacks.receive = receive
    self.callbacks.disconnect = disconnect
    self.callbacks.connect = connect
end

function Client:update()
    local event = self.host:service()
    while event do
        if event.type == "receive" then
            if self.callbacks.receive then
                self.callbacks.receive( object, event )
            end
        elseif event.type == "connect" then
            if self.callbacks.connect then
                self.callbacks.connect( object, event )
            end
        elseif event.type == "disconnect" then
            if self.callbacks.disconnect then
                self.callbacks.disconnect( object, event )
            end
        end
    end
end

function Client:send( message, channel, flag )
    flag = flag or "unreliable"
    channel = channel or 0
    if self.server then
        self.server:send( message, channel, flag )
    end
end

function Client:stop()
    for i,v in pairs( self.peers ) do
        v:disconnect_now()
    end
    self.peers = {}
    self.host:destroy()
    self.host = nil
end

return Client
