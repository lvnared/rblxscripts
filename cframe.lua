local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local rootPart = char:WaitForChild("HumanoidRootPart")
local camera = game.Workspace.CurrentCamera
local UIS = game:GetService("UserInputService")
local speed = 0.5
local moveDirections = {}

UIS.InputBegan:Connect(function(input, gameProcessedEvent)
	if gameProcessedEvent then return end
	if input.KeyCode == Enum.KeyCode.W or 
		input.KeyCode == Enum.KeyCode.S or 
		input.KeyCode == Enum.KeyCode.A or 
		input.KeyCode == Enum.KeyCode.D then
		moveDirections[input.KeyCode] = true
	end
end)

UIS.InputEnded:Connect(function(input, gameProcessedEvent)
	if gameProcessedEvent then return end
	if input.KeyCode == Enum.KeyCode.W or 
		input.KeyCode == Enum.KeyCode.S or 
		input.KeyCode == Enum.KeyCode.A or 
		input.KeyCode == Enum.KeyCode.D then
		moveDirections[input.KeyCode] = nil
	end
end)

while true do
	local moveVector = Vector3.new(0, 0, 0)
	if moveDirections[Enum.KeyCode.W] then
		moveVector = moveVector + camera.CFrame.LookVector
	end
	if moveDirections[Enum.KeyCode.S] then
		moveVector = moveVector - camera.CFrame.LookVector
	end
	if moveDirections[Enum.KeyCode.A] then
		moveVector = moveVector - camera.CFrame.RightVector
	end
	if moveDirections[Enum.KeyCode.D] then
		moveVector = moveVector + camera.CFrame.RightVector
	end
	if moveVector.Magnitude > 0 then
		moveVector = moveVector.Unit -- Normalize the vector
	end
	rootPart.CFrame = rootPart.CFrame + moveVector * speed
	task.wait(0.01)
end
