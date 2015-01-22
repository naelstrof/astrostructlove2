local PackLoader = {
    packlocation = "packs",
    packlocations = {}
}

function PackLoader:init()
    assert( love.filesystem.isDirectory( self.packlocation ), self.packlocation .. " not found." )
    self:load( love.filesystem.getDirectoryItems( self.packlocation ) )
    return self
end

function PackLoader:load( packs )
    for i,v in pairs( packs ) do
        local mountpoint = v
        if string.sub( mountpoint, string.len( mountpoint ) - 4 ) == ".zip" then
            mountpoint = string.sub( mountpoint, 0, string.len( mountpoint ) - 4 )
            assert( love.filesystem.mount( v, mountpoint ), "failed to mount folder/zip!" )
            table.insert( self.packlocations, mountpoint )
        else
            -- If it ain't a zip, we don't have to mount it :)
            table.insert( self.packlocations, self.packlocation .. "/" .. mountpoint )
        end
    end
end

function PackLoader:getFile( dir )
    for i,v in pairs( self.packlocations ) do
        if love.filesystem.isFile( v .. "/" .. dir ) then
            return v .. "/" .. dir
        end
    end
    return dir
end

-- FIXME: Use the real lua require search thingies instead of tacking on
-- .lua and hoping to find it.
function PackLoader:getRequire( dir )
    for i,v in pairs( self.packlocations ) do
        if love.filesystem.isFile( v .. "/" .. dir .. ".lua" ) then
            return v .. "/" .. dir
        end
    end
    return dir
end

return PackLoader
