
local shadows = {}

minetest.register_entity("shadow:shadow", {
	automatic_rotate = false,
	makes_footstep_sound = false,
	physical = false,
	textures = {
		"shadow.png"
	},
	visual = "upright_sprite",
	visual_size = {
		x = 1,
		y = 1
	}
})

minetest.register_on_joinplayer(function(player)
	local surrounding_objects = minetest.get_objects_inside_radius(player:getpos(), 0.5)
	
	for index, object in ipairs(surrounding_objects) do
		if object.name == "shadow:shadow" then
			object:remove()
		end
	end
	
	local shadow = minetest.add_entity(player:getpos(), "shadow:shadow")
	
	shadows[player:get_player_name()] = shadow
	
	shadow:set_attach(
		player,
		nil,
		{
			x = 0,
			y = -9.99,
			z = 0
		},
		{
			x = -90,
			y = 0,
			z = 0
		})
end)

minetest.register_on_leaveplayer(function(player)
	local shadow = shadows[player:get_player_name()]
	print("leave")
	
	if shadow ~= nil then
		print("leave2")
		shadow:remove()
	end
end)

minetest.register_on_shutdown(function()
	print("shutdown")
	
	for player_name, shadow in pairs(shadows) do
		if shadow ~= nil then
			print("remove")
			shadow:remove()
		end
	end
end)

