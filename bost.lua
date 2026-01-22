-- DRAG DRIVE MOTOR AUTO BOOST
-- Android Executor Friendly
-- Anti Crash System

pcall(function()

    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local player = Players.LocalPlayer

    local seat = nil
    local vehicle = nil

    -- cari VehicleSeat saat duduk
    local function findSeat()
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("VehicleSeat") and v.Occupant then
                local hum = v.Occupant.Parent
                if hum and hum:IsDescendantOf(player.Character) then
                    return v
                end
            end
        end
        return nil
    end

    -- loop utama
    RunService.Heartbeat:Connect(function()
        pcall(function()
            if not player.Character then return end

            seat = findSeat()
            if not seat then return end

            vehicle = seat.Parent

            -- AUTO GAS (tanpa tombol)
            seat.Throttle = 1
            seat.Steer = 0

            -- SPEED & RPM BOOST
            seat.MaxSpeed = 1000            -- kecepatan tinggi
            seat.Torque = 100000            -- akselerasi brutal
            seat.TurnSpeed = 0.5
            seat.HeadsUpDisplay = false

            -- SIMULASI RPM 300++
            if seat:FindFirstChild("RPM") then
                seat.RPM.Value = 350
            end

            -- BRAKE SUPER KUAT
            seat.BrakeTorque = 9999999
            seat.BrakeForce = 9999999

            -- ANTI TERBALIK / STABIL
            if vehicle:FindFirstChild("BodyGyro") == nil then
                local bg = Instance.new("BodyGyro")
                bg.MaxTorque = Vector3.new(1e7,1e7,1e7)
                bg.P = 1e6
                bg.CFrame = vehicle.PrimaryPart.CFrame
                bg.Parent = vehicle.PrimaryPart
            end
        end)
    end)

end)
