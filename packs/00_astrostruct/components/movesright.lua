local MovesRight = {
}

function MovesRight:update( dt )
    -- 100 pixels per second
    self.position.x = self.position.x + dt * 100
end

return MovesRight
