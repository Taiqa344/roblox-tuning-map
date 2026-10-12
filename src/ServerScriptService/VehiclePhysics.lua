-- VehiclePhysics.lua
-- ServerScriptService/VehiclePhysics.lua
-- Komplettes Fahrzeug-Physik-System mit Geschwindigkeit, Handling und Animationen

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local vehiclePhysics = {}

local function createVehiclePhysics(vehicleModel)
    if not vehicleModel then return nil end
    
    local physics = {
        Model = vehicleModel,
        MaxSpeed = 250,
        Acceleration = 5,
        Friction = 0.95,
        Velocity = Vector3.new(0, 0, 0),
        EngineRunning = false,
        IsInGarage = true,
        TireSmoke = nil,
        LastPosition = vehicleModel:GetPivot().Position,
    }
    
    local mainPart = vehicleModel:FindFirstChild("Seat") or vehicleModel:FindFirstChildOfClass("Part")
    if mainPart then
        mainPart:SetNetworkOwner(nil)
    end
    
    function physics:Update(deltaTime)
        if self.IsInGarage then return end
        
        local mainPart = self.Model:FindFirstChild("Seat") or self.Model:FindFirstChildOfClass("Part")
        if not mainPart then return end
        
        local currentVelocity = mainPart.AssemblyLinearVelocity
        local speed = currentVelocity.Magnitude
        
        if speed > 0.5 then
            local direction = currentVelocity.Unit
            mainPart.AssemblyLinearVelocity = direction * math.min(speed, self.MaxSpeed)
            
            self:CreateTireParticles(mainPart)
        end
        
        self:UpdateWheelRotation(mainPart)
        self:UpdateEngineSound(mainPart)
    end
    
    function physics:CreateTireParticles(mainPart)
        local speed = mainPart.AssemblyLinearVelocity.Magnitude
        if speed > 50 then
            local wheels = self.Model:FindFirstChild("WheelFL") or self.Model:FindFirstChild("Wheel")
            if wheels then
                local particle = Instance.new("Part")
                particle.Shape = Enum.PartType.Ball
                particle.Size = Vector3.new(0.1, 0.1, 0.1)
                particle.Color = Color3.fromRGB(100, 100, 100)
                particle.CanCollide = false
                particle.CFrame = wheels.CFrame
                particle.Parent = Workspace
                
                game:GetService("Debris"):AddItem(particle, 0.3)
            end
        end
    end
    
    function physics:UpdateWheelRotation(mainPart)
        local speed = mainPart.AssemblyLinearVelocity.Magnitude
        local rotationSpeed = (speed / self.MaxSpeed) * 30
        
        for _, wheel in ipairs(self.Model:GetDescendants()) do
            if wheel.Name:match("Wheel") then
                wheel.RotVelocity = Vector3.new(rotationSpeed, 0, 0)
            end
        end
    end
    
    function physics:UpdateEngineSound(mainPart)
        local sound = mainPart:FindFirstChildOfClass("Sound")
        if sound then
            local speed = mainPart.AssemblyLinearVelocity.Magnitude
            local volume = math.min(speed / self.MaxSpeed, 1)
            sound.Volume = volume * 0.7
            
            if volume > 0.1 and not sound.Playing then
                sound:Play()
            elseif volume < 0.1 and sound.Playing then
                sound:Stop()
            end
        end
    end
    
    function physics:ApplyUpgrades(upgrades)
        if upgrades.Turbo then
            self.MaxSpeed = 280
            self.Acceleration = 7
        end
        if upgrades.Engine then
            self.MaxSpeed = self.MaxSpeed + 50
            self.Acceleration = self.Acceleration + 2
        end
        if upgrades.Downpipe then
            self.Acceleration = self.Acceleration + 1.5
        end
    end
    
    function physics:Destroy()
        if self.Model and self.Model.Parent then
            self.Model:Destroy()
        end
    end
    
    return physics
end

return {
    CreateVehiclePhysics = createVehiclePhysics,
}
