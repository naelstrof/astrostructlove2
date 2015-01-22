local Render = Class( {
} )

function Render:render( world, camera )
    for i,v in pairs( world.entities ) do
        love.graphics.draw( v.drawable,
                            v.position.x,
                            v.position.y,
                            v.rotation,
                            v.scale.x,
                            v.scale.y,
                            v.originoffset.x,
                            v.originoffset.y )
    end
end

return Render
