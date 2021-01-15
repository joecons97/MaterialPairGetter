class 'MaterialPairGetterClient'

local isKeyDown = false

function MaterialPairGetterClient:__init()
	Events:Subscribe('Client:UpdateInput', self, self.OnUpdateInput)
	Events:Subscribe('UpdateManager:Update', self, self.OnUpdateManager)
end

function MaterialPairGetterClient:OnUpdateInput(p_Cache, p_DeltaTime)
    isKeyDown = InputManager:IsKeyDown(InputDeviceKeys.IDK_T)
end

function MaterialPairGetterClient:OnUpdateManager(p_Delta, p_Pass)
    if(p_Pass == UpdatePass.UpdatePass_PreSim and isKeyDown) then
        local start = ClientUtils:GetCameraTransform().trans:Clone()
        start.y = start.y + 0.5
      
        local endPos = start:Clone()
        endPos = endPos + ClientUtils:GetCameraTransform().forward * -5
      
        local hit = RaycastManager:Raycast(start, endPos, RayCastFlags.CheckDetailMesh)
        if(hit ~= nil) then
          print(hit.material.instanceGuid)
        else
          print("hit is nil :(")
        end
    end
end

g_MaterialPairGetterClient = MaterialPairGetterClient()
return g_MaterialPairGetterClient