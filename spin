-- Initialize global variables
_G.Spiny = false
_G.SpinySpeed = 100  -- Default spinning speed (degrees per second)

-- Create and configure BodyAngularVelocity for spinning
local function setupBodyAngularVelocity(character)
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        local bodyAngularVelocity = humanoidRootPart:FindFirstChild("BodyAngularVelocity")
        if not bodyAngularVelocity then
            bodyAngularVelocity = Instance.new("BodyAngularVelocity")
            bodyAngularVelocity.Name = "BodyAngularVelocity"
            bodyAngularVelocity.P = 3000  -- Adjust this value for responsiveness
            bodyAngularVelocity.MaxTorque = Vector3.new(4000, 4000, 4000)  -- Adjust as needed
            bodyAngularVelocity.Parent = humanoidRootPart
        end
        return bodyAngularVelocity
    end
end

-- Update spinning mechanics based on the global variables
local function onSpin()
    local player = game.Players.LocalPlayer
    local character = player.Character
    local bodyAngularVelocity = setupBodyAngularVelocity(character)

    if character and bodyAngularVelocity then
        if _G.Spiny then
            -- Apply rotational velocity
            local spinSpeed = _G.SpinySpeed * math.pi / 180  -- Convert degrees to radians
            bodyAngularVelocity.AngularVelocity = Vector3.new(0, spinSpeed, 0)
        else
            -- Stop spinning by setting angular velocity to zero
            bodyAngularVelocity.AngularVelocity = Vector3.zero
        end
    end
end

-- Toggle spinning on and off
function toggleSpin()
    _G.Spiny = not _G.Spiny
    print("Spin mode is now " .. (_G.Spiny and "enabled" or "disabled"))
end

-- Listen for input to toggle spinning
function setupSpinEvent()
    local userInputService = game:GetService("UserInputService")

    userInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.E then
            toggleSpin()
        end
    end)
end

-- Main loop to continuously apply spinning mechanics
function mainLoop()
    while true do
        wait(0.1)  -- Adjust the wait time for smoothness
        onSpin()
    end
end

-- Start the setup and loop
setupSpinEvent()
mainLoop()
