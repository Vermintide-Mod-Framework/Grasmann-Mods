local mod = get_mod("i_dare_you")
--[[
	I dare you! - Reverse camera

    Forces victim to use reverse camera.
--]]

local angle = 0
local direction = 0

-- --mod:hook(CameraManager, "post_update", function(func, self, dt, t_, viewport_name)
-- --mod:hook_safe(CameraManager, "_update_camera", function(self, dt, t, viewport_name)
-- mod:hook(CameraManager, "_update_camera_properties", function(self, camera, shadow_cull_camera, current_node, camera_data, viewport_name)
--     --local viewport = ScriptWorld.viewport(self._world, viewport_name)
--     --local camera = ScriptViewport.camera(viewport)
--     --local shadow_cull_camera = ScriptViewport.shadow_cull_camera(viewport)
--     --local camera_nodes = self._camera_nodes[viewport_name]
--     --local current_node = self:_current_node(camera_nodes)
--     --local camera_data = self:_update_transition(viewport_name, camera_nodes, dt)
--     if camera_data.rotation then
--         --local rotation = {yaw = Quaternion.yaw(camera_data.rotation), pitch = Quaternion.pitch(camera_data.rotation), roll = Quaternion.roll(camera_data.rotation) + angle}
--         local x, y, z = Quaternion.to_euler_angles_xyz(camera_data.rotation)
--     --camera_data.rotation = self:_calculate_sequence_event_rotation(camera_data, rotation)
--         camera_data.rotation = Quaternion.from_euler_angles_xyz(x, y, z)
--     end

--     func(self, camera, shadow_cull_camera, current_node, camera_data, viewport_name)

--     --self:_update_camera_properties(camera, shadow_cull_camera, current_node, camera_data, viewport_name)
--     --ScriptCamera.force_update(self._world, camera)

--     --return func(self, dt, t_, viewport_name)
--     --return func(self, camera, shadow_cull_camera, current_node, camera_data, viewport_name)
-- end)
mod:hook_safe(CameraManager, "_update_camera_properties", function(self, camera, shadow_cull_camera, current_node, camera_data, viewport_name)
    local viewport = ScriptWorld.viewport(self._world, viewport_name)
    local camera = ScriptViewport.camera(viewport)
    local camera_rotation = ScriptCamera.rotation(camera)
    local x, y, z = Quaternion.to_euler_angles_xyz(camera_rotation)
    camera_rotation = Quaternion.from_euler_angles_xyz(x + 180, y, z)
    ScriptCamera.set_local_rotation(camera, camera_rotation)
end)
mod:hook_disable(CameraManager, "_update_camera_properties")

-- mod:hook(CameraManager, "_update_camera_properties", function(func, self, camera, shadow_cull_camera, current_node, camera_data, viewport_name)
--     local x, y, z = Quaternion.to_euler_angles_xyz(camera_data.rotation)
--     x = x + angle
--     camera_data.rotation = Quaternion.from_euler_angles_xyz(x, y, z)
--     return func(self, camera, shadow_cull_camera, current_node, camera_data, viewport_name)
-- end)
-- mod:hook_disable(CameraManager, "_update_camera_properties")

local reverse_camera = mod:get_template()
reverse_camera.id = "reverse_camera"
reverse_camera.text = mod:localize("reverse_camera_text")
reverse_camera.start = function(self)
    angle = 0
    direction = math.random(1, 2)
    mod:hook_enable(CameraManager, "_update_camera_properties")
end
reverse_camera.update = function(self, dt)
    if direction == 1 then
        angle = angle + dt * 100
        if angle > 180 then
            angle = 180
        end
    else
        angle = angle - dt * 100
        if angle < -180 then
            angle = -180
        end
    end
end
reverse_camera.finish = function(self)
    mod:hook_disable(CameraManager, "_update_camera_properties")
end

return reverse_camera