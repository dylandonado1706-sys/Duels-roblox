local Rayfield = loadstring(game:HttpGet('https://githubusercontent.com'))()

local Window = Rayfield:CreateWindow({
   Name = "Duels Hub ⚔️",
   LoadingTitle = "Loading Duel Functions...",
   LoadingSubtitle = "by espantaviejasV2x",
   ConfigurationSaving = { Enabled = false }
})

-- Creación de Pestañas
local CombatTab = Window:CreateTab("Combat", 4483362458)
local VisualsTab = Window:CreateTab("Visuals", 4483362458)
local FarmTab = Window:CreateTab("Auto-Farm", 4483362458)

-- =======================================================
-- LÓGICA DE COMBATE (AIMBOT & DUPE)
-- =======================================================
CombatTab:CreateSection("Main Exploits")

CombatTab:CreateToggle({
   Name = "Camera Aimbot",
   CurrentValue = false,
   Flag = "Aimbot",
   Callback = function(Value)
      _G.Aimbot = Value
      local Camera = workspace.CurrentCamera
      local Players = game:GetService("Players")
      local LocalPlayer = Players.LocalPlayer

      game:GetService("RunService").RenderStepped:Connect(function()
         if _G.Aimbot then
            local Target = nil
            local ShortestDistance = math.huge
            for _, player in pairs(Players:GetPlayers()) do
               if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                  local Pos, OnScreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
                  if OnScreen then
                     local Distance = (Vector2.new(Pos.X, Pos.Y) - Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)).Magnitude
                     if Distance < ShortestDistance then
                        ShortestDistance = Distance
                        Target = player
                     end
                  end
               end
            end
            if Target and Target.Character:FindFirstChild("Head") then
               Camera.CFrame = CFrame.new(Camera.CFrame.Position, Target.Character.Head.Position)
            end
         end
      end)
   end
})

CombatTab:CreateButton({
   Name = "Trigger Dupe (Sim)",
   Callback = function()
      Rayfield:Notify({
         Title = "Dupe Activated",
         Content = "Attempting to glitch server storage tools...",
         Duration = 3,
         Image = 4483362458
      })
      pcall(function()
         local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") or game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
         if tool then
            tool.Parent = workspace
            task.wait(0.1)
            tool.Parent = game.Players.LocalPlayer.Backpack
         end
      end)
   end
})

CombatTab:CreateSection("Assistance")

CombatTab:CreateToggle({
   Name = "Auto-Equip Weapon",
   CurrentValue = false,
   Flag = "AutoEquip", 
   Callback = function(Value)
      _G.AutoEquip = Value
      while _G.AutoEquip do
         task.wait(0.5)
         local p = game.Players.LocalPlayer
         if p.Backpack:FindFirstChildOfClass("Tool") and p.Character:FindFirstChild("Humanoid") then
            p.Character.Humanoid:EquipTool(p.Backpack:FindFirstChildOfClass("Tool"))
         end
      end
   end
})

CombatTab:CreateToggle({
   Name = "Auto-Clicker",
   CurrentValue = false,
   Flag = "AutoClick",
   Callback = function(Value)
      _G.AutoClicker = Value
      while _G.AutoClicker do
         task.wait(0.01)
         game:GetService('VirtualUser'):CaptureController()
         game:GetService('VirtualUser'):ClickButton1(Vector2.new(0, 0))
      end
   end
})

-- =======================================================
-- LÓGICA DE VISUALES (ESP BOXES)
-- =======================================================
VisualsTab:CreateSection("ESP Options")

VisualsTab:CreateToggle({
   Name = "Enable ESP Boxes",
   CurrentValue = false,
   Flag = "EspBoxes",
   Callback = function(Value)
      _G.ESP = Value
      local Players = game:GetService("Players")
      local LocalPlayer = Players.LocalPlayer
      local Camera = workspace.CurrentCamera

      local function CreateESP(Player)
         local Box = Drawing.new("Square")
         Box.Visible = false
         Box.Color = Color3.fromRGB(255, 0, 0)
         Box.Thickness = 2
         Box.Filled = false

         game:GetService("RunService").RenderStepped:Connect(function()
            if _G.ESP and Player and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and Player ~= LocalPlayer and Player.Character:FindFirstChild("Humanoid") and Player.Character.Humanoid.Health > 0 then
               local RootPart = Player.Character.HumanoidRootPart
               local Position, OnScreen = Camera:WorldToViewportPoint(RootPart.Position)
               
               if OnScreen then
                  local SizeX = 2000 / Position.Z
                  local SizeY = 3000 / Position.Z
                  Box.Size = Vector2.new(SizeX, SizeY)
                  Box.Position = Vector2.new(Position.X - SizeX / 2, Position.Y - SizeY / 2)
                  Box.Visible = true
               else
                  Box.Visible = false
               end
            else
               Box.Visible = false
            end
         end)
      end

      if _G.ESP then
         for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then CreateESP(player) end
         end
         Players.PlayerAdded:Connect(function(player)
            if player ~= LocalPlayer then CreateESP(player) end
         end)
      end
   end
})

-- =======================================================
-- PESTAÑA AUTO-FARM
-- =======================================================
FarmTab:CreateSection("Automation")

FarmTab:CreateButton({
   Name = "Auto-Accept Duel",
   Callback = function()
      Rayfield:Notify({
         Title = "Queue",
         Content = "Joining matchmaking queue...",
         Duration = 3,
         Image = 4483362458
      })
      pcall(function()
         game:GetService("ReplicatedStorage").Events.AcceptDuel:FireServer()
      end)
   end
})

-- =======================================================
-- BOTÓN FLOTANTE CIRCULAR (BACON LOGO)
-- =======================================================
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("ImageButton")
local UICorner = Instance.new("UICorner")

ScreenGui.Name = "BaconToggleGui"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

ToggleButton.Name = "BaconButton"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleButton.Position = UDim2.new(0, 10, 0, 150)
ToggleButton.Size = UDim2.new(0, 60, 0, 60)
ToggleButton.Image = "rbxassetid://13414240751" -- ID de Imagen de la cabeza de Tocino
ToggleButton.Active = true
ToggleButton.Draggable = true

UICorner.CornerRadius = UDim.new(1, 0) -- Lo vuelve completamente circular
UICorner.Parent = ToggleButton

ToggleButton.MouseButton1Click:Connect(function()
   -- Minimiza o maximiza el menú de Rayfield usando su propia función interna
   pcall(function()
      game:GetService("VirtualInputUser"):SendKeyEvent(true, Enum.KeyCode.RightControl, false, game)
   end)
end)

Rayfield:Notify({
   Title = "Script Loaded",
   Content = "Created by espantaviejasV2x",
   Duration = 3,
   Image = 4483362458
})
