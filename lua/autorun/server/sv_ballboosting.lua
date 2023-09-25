CreateConVar("ballboosting_multiplier", 7, FCVAR_ARCHIVE + FCVAR_SERVER_CAN_EXECUTE, "", 0)
timer.Simple(1,function()
    hook.Add("OnEntityCreated", "DetectCombineBallSpawn", function(entity)
        if entity:GetClass() == "prop_combine_ball" then
            timer.Simple(0.0000000001, function()
                local combineBallPos = entity:GetPos()
                local nearestPlayer = nil
                local nearestDistSq = math.huge
                local angle
    
                for _, player in ipairs(player.GetAll()) do
                    local distSq = combineBallPos:DistToSqr(player:GetPos())
    
                    if distSq < nearestDistSq and distSq < 6400 then
                        nearestPlayer = player
                        angle = -player:EyeAngles():Forward()
                        nearestDistSq = distSq
                    end
                end
                if IsValid(nearestPlayer) then
                    local boost = Vector(angle.x, angle.y, angle.z)
                    nearestPlayer:SetVelocity((boost * 100 * GetConVar("ballboosting_multiplier"):GetFloat()))
                end
            end)
        end
    end)
end)