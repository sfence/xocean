
-- Let the server console know the initialization is beginning.
core.log("[Xocean] Initialization begins...")

local modpath = minetest.get_modpath(minetest.get_current_modname())

minetest.register_node("hades_xocean:ocean_cobble", {
	description = "Ocean Cobblestone",
	tiles = {"xocean_cobble.png"},
	groups = {cracky=3},
})

minetest.register_node("hades_xocean:ocean_stone", {
	description = "Ocean Stone",
	tiles = {"xocean_stone.png"},
	groups = {cracky=3},
	drop= "hades_xocean:ocean_cobble",
})

minetest.register_craft({
	type = "cooking",
	output = "hades_xocean:ocean_stone",
	recipe = "hades_xocean:ocean_cobble",
})

-- have to be do, after ocean stone node is registered
dofile(modpath.."/hades.lua")

--[[
---Spawn the stone
minetest.register_ore({
		ore_type        = "blob",
		ore             = "hades_xocean:ocean_stone",
		wherein         = {"default:sand"},
		clust_scarcity  = 32 * 32 * 32,
		clust_size      = 8,
		y_min           = -15,
		y_max           = 0,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 8, y = 5, z = 8},
			seed = -316,
			octaves = 1,
			persist = 0.0
		},
	})
--]]

minetest.register_node("hades_xocean:ocean_carved", {
	description = "Carved Ocean Stone",
	tiles = {"xocean_carved.png"},
	groups = {cracky=2},
})

minetest.register_craft({
	output = '"hades_xocean:ocean_carved" 4',
	recipe = {
		{'hades_xocean:ocean_stone', 'hades_xocean:ocean_stone',},
		{'hades_xocean:ocean_stone', 'hades_xocean:ocean_stone',},
		},
})

minetest.register_node("hades_xocean:ocean_circular", {
	description = "Circular Ocean Stone",
	tiles = {"xocean_circular.png"},
	groups = {cracky=2},
})

minetest.register_craft({
	output = '"hades_xocean:ocean_circular" 4',
	recipe = {
		{'hades_xocean:ocean_carved', 'hades_xocean:ocean_carved',},
		{'hades_xocean:ocean_carved', 'hades_xocean:ocean_carved',},
		},
})

minetest.register_node("hades_xocean:ocean_pillar", {
	description = "Ocean Pillar",
	tiles = {"xocean_pillar.png"},
	groups = {cracky=2},
})

minetest.register_craft({
	output = '"hades_xocean:ocean_pillar" 4',
	recipe = {
		{'hades_xocean:ocean_brick', 'hades_xocean:ocean_brick',},
		{'hades_xocean:ocean_brick', 'hades_xocean:ocean_brick',},
		},
})

minetest.register_node("hades_xocean:ocean_brick", {
	description = "Ocean Brick",
	tiles = {"xocean_brick.png"},
	groups = {cracky=2},
})

minetest.register_craft({
	output = '"hades_xocean:ocean_brick" 4',
	recipe = {
		{'hades_xocean:ocean_cobble', 'hades_xocean:ocean_cobble',},
		{'hades_xocean:ocean_cobble', 'hades_xocean:ocean_cobble',},
		},
})

minetest.register_node("hades_xocean:sea_lantern", {
    description = "Sea Lantern",
    drawtype = "glasslike",
	light_source = 14,
    tiles = {"xocean_lantern.png"},
    paramtype = "light",
    is_ground_content = true,
    sunlight_propagates = true,
    sounds = hades_sounds.node_sound_glass_defaults(),
    groups = {cracky=3,oddly_breakable_by_hand=3},
})

minetest.register_craft({
	output = '"hades_xocean:sea_lantern" 4',
	recipe = {
		{'hades_core:torch', 'hades_core:glass', 'hades_core:torch', },
		{'hades_core:glass', 'hades_bucket:bucket_water', 'hades_core:glass', },
		{'hades_core:torch', 'hades_core:glass', 'hades_core:torch', },
		},
		replacements = {{ "hades_bucket:bucket_water", "hades_bucket:bucket_empty"}}
})
---Sea stuff
minetest.register_node("hades_xocean:kelp_block", {
	description = "Dried Kelp Block",
	tiles = {"xocean_kelp_block.png"},
	groups = {snappy=3},
	drop= "hades_xocean:kelp 9",
})
minetest.register_craft({
	output = '"hades_xocean:kelp_block" 1',
	recipe = {
		{'hades_xocean:kelp', 'hades_xocean:kelp', 'hades_xocean:kelp', },
		{'hades_xocean:kelp', 'hades_xocean:kelp', 'hades_xocean:kelp', },
		{'hades_xocean:kelp', 'hades_xocean:kelp', 'hades_xocean:kelp', },
		},
})
--minetest.override_item("default:sand_with_kelp", {
minetest.register_node("hades_xocean:sand_with_kelp", {
	description = "Kelp",
	_tt_help = "Need underwater sand (no volcanic, fertilize, silver or desert) to grow",
	drawtype = "plantlike_rooted",
	waving = 1,
	tiles = {"default_sand.png"},
	special_tiles = {{name = "default_kelp.png", tileable_vertical = true}},
	inventory_image = "xocean_kelp.png",
	wield_image = "xocean_kelp.png",
	paramtype = "light",
	paramtype2 = "leveled",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-2/16, 0.5, -2/16, 2/16, 3.5, 2/16},
		},
	},
	node_dig_prediction = "hades_default:sand",
	node_placement_prediction = "",
	sounds = hades_sounds.node_sound_sand_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),

	on_place = function(itemstack, placer, pointed_thing)
		-- Call on_rightclick if the pointed node defines it
		if pointed_thing.type == "node" and placer and
				not placer:get_player_control().sneak then
			local node_ptu = minetest.get_node(pointed_thing.under)
			local def_ptu = minetest.registered_nodes[node_ptu.name]
			if def_ptu and def_ptu.on_rightclick then
				return def_ptu.on_rightclick(pointed_thing.under, node_ptu, placer,
					itemstack, pointed_thing)
			end
		end

		local pos = pointed_thing.under
		if minetest.get_node(pos).name ~= "hades_default:sand" then
			return itemstack
		end

    -- have to grow?
		local height = 1--math.random(4, 6)*16
		local pos_top = {x = pos.x, y = pos.y + math.ceil(height/16), z = pos.z}
		local node_top = minetest.get_node(pos_top)
		local def_top = minetest.registered_nodes[node_top.name]
		local player_name = placer:get_player_name()

		if def_top and def_top.liquidtype == "source" and
				minetest.get_item_group(node_top.name, "water") > 0 then
			if not minetest.is_protected(pos, player_name) and
					not minetest.is_protected(pos_top, player_name) then
				minetest.set_node(pos, {name = "hades_xocean:sand_with_kelp",
					param2 = height})
				if not (minetest.is_creative_enabled(player_name)) then
					itemstack:take_item()
				end
			else
				minetest.chat_send_player(player_name, "Node is protected")
				minetest.record_protection_violation(pos, player_name)
			end
    else
			minetest.chat_send_player(player_name, "Missing water source above sand.")
		end

		return itemstack
	end,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "hades_default:sand"})
	end
})
minetest.register_craft({
	type = "cooking",
	output = "hades_xocean:kelp",
	recipe = "hades_xocean:sand_with_kelp",
})
minetest.register_craftitem("hades_xocean:kelp", {
	description = "Dried Kelp",
	on_use = minetest.item_eat(1),
	inventory_image = "xocean_dried_kelp.png",
})
minetest.register_craftitem("hades_xocean:sushi", {
	description = "Sushi",
	on_use = minetest.item_eat(6),
	inventory_image = "xocean_sushi.png",
})
minetest.register_craft({
	output = '"hades_xocean:sushi" 1',
	recipe = {
		{'hades_xocean:fish_edible'},
		{'hades_xocean:kelp' },
		},
})
minetest.register_node("hades_xocean:seagrass", {
	description = "Seagrass",
	_tt_help = "Need underwater sand (no volcanic, fertilize, silver or desert) to grow",
	drawtype = "plantlike_rooted",
	waving = 1,
	paramtype = "light",
	tiles = {"default_sand.png"},
	special_tiles = {{name = "xocean_grass.png", tileable_vertical = true}},
	inventory_image = "xocean_grass.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "default_default:sand",
	node_placement_prediction = "",
	sounds = hades_sounds.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" or not placer then
			return itemstack
		end

		local player_name = placer:get_player_name()
		local pos_under = pointed_thing.under
		local pos_above = pointed_thing.above

		if minetest.get_node(pos_under).name ~= "hades_default:sand" or
				minetest.get_node(pos_above).name ~= "hades_core:water_source" then
			minetest.chat_send_player(player_name, "Missing water source above sand.")
			return itemstack
		end

		if minetest.is_protected(pos_under, player_name) or
				minetest.is_protected(pos_above, player_name) then
			minetest.chat_send_player(player_name, "Node is protected")
			minetest.record_protection_violation(pos_under, player_name)
			return itemstack
		end

		minetest.set_node(pos_under, {name = "hades_xocean:seagrass"})
		if not (minetest.is_creative_enabled(player_name)) then
			itemstack:take_item()
		end

		return itemstack
	end,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "hades_default:sand"})
	end,
})
minetest.register_craftitem("hades_xocean:fish_edible", {
	description = "Tropical Fish",
	on_use = minetest.item_eat(3),
	inventory_image = "xocean_fish_edible.png",
})
minetest.register_node("hades_xocean:pickle", {
	description = "Sea Pickle",
	drawtype = "plantlike_rooted",
	waving = 1,
	paramtype = "light",
	tiles = {"default_sand.png"},
	special_tiles = {{name = "xocean_pickle.png", tileable_vertical = true}},
	inventory_image = "xocean_pickle.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	light_source = 3,
	node_dig_prediction = "default:sand",
	node_placement_prediction = "",
	sounds = hades_sounds.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" or not placer then
			return itemstack
		end

		local player_name = placer:get_player_name()
		local pos_under = pointed_thing.under
		local pos_above = pointed_thing.above

		if minetest.get_node(pos_under).name ~= "default:sand" or
				minetest.get_node(pos_above).name ~= "hades_core:water_source" then
			return itemstack
		end

		if minetest.is_protected(pos_under, player_name) or
				minetest.is_protected(pos_above, player_name) then
			minetest.chat_send_player(player_name, "Node is protected")
			minetest.record_protection_violation(pos_under, player_name)
			return itemstack
		end

		minetest.set_node(pos_under, {name = "hades_xocean:pickle"})
		if not (minetest.is_creative_enabled(player_name)) then
			itemstack:take_item()
		end

		return itemstack
	end,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "hades_default:sand"})
	end,
})
---Corals
minetest.register_node("hades_xocean:brain_block", {
	description = "Brain Coral Block",
	tiles = {"xocean_coral_brain.png"},
	groups = {cracky = 3, coral_live = 1},
	drop = "hades_xocean:brain_skeleton",
	sounds = hades_sounds.node_sound_stone_defaults(),
})
--minetest.override_item("default:coral_pink", {
minetest.register_node("hades_xocean:coral_pink", {
	description = "Brain Coral",
	drawtype = "plantlike_rooted",
	waving = 1,
	--paramtype = "light",
	paramtype2 = "wallmounted",
	tiles = {"xocean_coral_brain.png"},
	special_tiles = {{name = "xocean_brain.png", tileable_vertical = true}},
	inventory_image = "xocean_brain.png",
	groups = {snappy = 3, coral_live = 1, coral_growing = 1},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	drop = "hades_xocean:skeleton_brain",
	node_dig_prediction = "hades_xocean:brain_block",
	node_placement_prediction = "",
	sounds = hades_sounds.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" or not placer then
			return itemstack
		end

		local player_name = placer:get_player_name()
		local pos_under = pointed_thing.under
		local pos_above = pointed_thing.above
		print(dump(pointed_thing))

		if minetest.get_node(pos_under).name ~= "hades_xocean:brain_block" or
				minetest.get_node(pos_above).name ~= "hades_core:water_source" then
			return itemstack
		end

		if minetest.is_protected(pos_under, player_name) or
				minetest.is_protected(pos_above, player_name) then
			minetest.chat_send_player(player_name, "Node is protected")
			minetest.record_protection_violation(pos_under, player_name)
			return itemstack
		end

		minetest.set_node(pos_under, {name = "hades_xocean:coral_pink"})
		if not (minetest.is_creative_enabled(player_name)) then
			itemstack:take_item()
		end

		return itemstack
	end,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "hades_xocean:brain_block"})
	end,
})
minetest.register_node("hades_xocean:brain_skeleton", {
	description = "Brain Coral Skeleton Block",
	tiles = {"xocean_coral_brain_skeleton.png"},
	groups = {cracky = 3, coral_block_skeleton = 1},
	sounds = hades_sounds.node_sound_stone_defaults(),
})
minetest.register_node("hades_xocean:skeleton_brain", {
	description = "Brain Coral Skeleton",
	drawtype = "plantlike_rooted",
	waving = 1,
	--paramtype = "light",
	paramtype2 = "wallmounted",
	tiles = {"xocean_coral_brain_skeleton.png"},
	special_tiles = {{name = "xocean_brain_skeleton.png", tileable_vertical = true}},
	inventory_image = "xocean_brain_skeleton.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "hades_xocean:brain_skeleton",
	node_placement_prediction = "",
	sounds = hades_sounds.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" or not placer then
			return itemstack
		end

		local player_name = placer:get_player_name()
		local pos_under = pointed_thing.under
		local pos_above = pointed_thing.above

		if minetest.get_node(pos_under).name ~= "hades_xocean:brain_skeleton" or
				minetest.get_node(pos_above).name ~= "hades_xocean:water_source" then
			return itemstack
		end

		if minetest.is_protected(pos_under, player_name) or
				minetest.is_protected(pos_above, player_name) then
			minetest.chat_send_player(player_name, "Node is protected")
			minetest.record_protection_violation(pos_under, player_name)
			return itemstack
		end
		
		local param2 = minetest.dir_to_wallmounted(vector.subtract(pos_above, pos_under), true)
		minetest.set_node(pos_under, {name = "hades_xocean:skeleton_brain", param2 = param2})
		if not (minetest.is_creative_enabled(player_name)) then
			itemstack:take_item()
		end

		return itemstack
	end,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "hades_xocean:brain_skeleton"})
	end,
})
minetest.register_node("hades_xocean:tube_block", {
	description = "Tube Coral Block",
	tiles = {"xocean_coral_tube.png"},
	groups = {cracky = 3, coral_live = 1},
	drop = "hades_xocean:tube_skeleton",
	sounds = hades_sounds.node_sound_stone_defaults(),
})
--minetest.override_item("default:coral_cyan", {
minetest.register_node("hades_xocean:coral_cyan", {
	description = "Tube Coral",
	drawtype = "plantlike_rooted",
	waving = 1,
	--paramtype = "light",
	paramtype2 = "wallmounted",
	tiles = {"xocean_coral_tube.png"},
	special_tiles = {{name = "xocean_tube.png", tileable_vertical = true}},
	inventory_image = "xocean_tube.png",
	groups = {snappy = 3, coral_live = 1, coral_growing = 1},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	drop = "hades_xocean:skeleton_tube",
	node_dig_prediction = "hades_xocean:tube_block",
	node_placement_prediction = "",
	sounds = hades_sounds.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" or not placer then
			return itemstack
		end

		local player_name = placer:get_player_name()
		local pos_under = pointed_thing.under
		local pos_above = pointed_thing.above

		if minetest.get_node(pos_under).name ~= "hades_xocean:tube_block" or
				minetest.get_node(pos_above).name ~= "hades_core:water_source" then
			return itemstack
		end

		if minetest.is_protected(pos_under, player_name) or
				minetest.is_protected(pos_above, player_name) then
			minetest.chat_send_player(player_name, "Node is protected")
			minetest.record_protection_violation(pos_under, player_name)
			return itemstack
		end

		minetest.set_node(pos_under, {name = "hades_xocean:coral_cyan"})
		if not (minetest.is_creative_enabled(player_name)) then
			itemstack:take_item()
		end

		return itemstack
	end,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "hades_xocean:tube_block"})
	end,
})
minetest.register_node("hades_xocean:tube_skeleton", {
	description = "Tube Coral Skeleton Block",
	tiles = {"xocean_coral_tube_skeleton.png"},
	groups = {cracky = 3, coral_block_skeleton = 1},
	sounds = hades_sounds.node_sound_stone_defaults(),
})
minetest.register_node("hades_xocean:skeleton_tube", {
	description = "Tube Coral Skeleton",
	drawtype = "plantlike_rooted",
	waving = 1,
	--paramtype = "light",
  paramtype2 = "wallmounted",
	tiles = {"xocean_coral_tube_skeleton.png"},
	special_tiles = {{name = "xocean_tube_skeleton.png", tileable_vertical = true}},
	inventory_image = "xocean_tube_skeleton.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "hades_xocean:tube_skeleton",
	node_placement_prediction = "",
	sounds = hades_sounds.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" or not placer then
			return itemstack
		end

		local player_name = placer:get_player_name()
		local pos_under = pointed_thing.under
		local pos_above = pointed_thing.above

		if minetest.get_node(pos_under).name ~= "hades_xocean:tube_skeleton" or
				minetest.get_node(pos_above).name ~= "hades_core:water_source" then
			return itemstack
		end

		if minetest.is_protected(pos_under, player_name) or
				minetest.is_protected(pos_above, player_name) then
			minetest.chat_send_player(player_name, "Node is protected")
			minetest.record_protection_violation(pos_under, player_name)
			return itemstack
		end

		minetest.set_node(pos_under, {name = "hades_xocean:skeleton_tube"})
		if not (minetest.is_creative_enabled(player_name)) then
			itemstack:take_item()
		end

		return itemstack
	end,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "hades_xocean:tube_skeleton"})
	end,
})
minetest.register_node("hades_xocean:bubble_block", {
	description = "Bubble Coral Block",
	tiles = {"xocean_coral_bubble.png"},
	groups = {cracky = 3, coral_live = 1},
	drop = "hades_xocean:bubble_skeleton",
	sounds = hades_sounds.node_sound_stone_defaults(),
})
minetest.register_node("hades_xocean:bubble", {
	description = "Bubble Coral",
	drawtype = "plantlike_rooted",
	waving = 1,
	drop = "hades_xocean:skeleton_bubble",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"xocean_coral_bubble.png"},
	special_tiles = {{name = "xocean_bubble.png", tileable_vertical = true}},
	inventory_image = "xocean_bubble.png",
	groups = {snappy = 3, coral_live = 1, coral_growing = 1},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "hades_xocean:bubble_block",
	node_placement_prediction = "",
	sounds = hades_sounds.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" or not placer then
			return itemstack
		end

		local player_name = placer:get_player_name()
		local pos_under = pointed_thing.under
		local pos_above = pointed_thing.above

		if minetest.get_node(pos_under).name ~= "hades_xocean:bubble_block" or
				minetest.get_node(pos_above).name ~= "hades_core:water_source" then
			return itemstack
		end

		if minetest.is_protected(pos_under, player_name) or
				minetest.is_protected(pos_above, player_name) then
			minetest.chat_send_player(player_name, "Node is protected")
			minetest.record_protection_violation(pos_under, player_name)
			return itemstack
		end

		minetest.set_node(pos_under, {name = "hades_xocean:bubble"})
		if not (minetest.is_creative_enabled(player_name)) then
			itemstack:take_item()
		end

		return itemstack
	end,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "hades_xocean:bubble_block"})
	end,
})
minetest.register_node("hades_xocean:bubble_skeleton", {
	description = "Bubble Coral Skeleton Block",
	tiles = {"xocean_coral_bubble_skeleton.png"},
	groups = {cracky = 3, coral_block_skeleton = 1},
	sounds = hades_sounds.node_sound_stone_defaults(),
})
minetest.register_node("hades_xocean:skeleton_bubble", {
	description = "Bubble Coral Skeleton",
	drawtype = "plantlike_rooted",
	waving = 1,
	paramtype = "light",
	tiles = {"xocean_coral_bubble_skeleton.png"},
	special_tiles = {{name = "xocean_bubble_skeleton.png", tileable_vertical = true}},
	inventory_image = "xocean_bubble_skeleton.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	drop = "hades_xocean:skeleton_bubble",
	node_dig_prediction = "hades_xocean:bubble_skeleton",
	node_placement_prediction = "",
	sounds = hades_sounds.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" or not placer then
			return itemstack
		end

		local player_name = placer:get_player_name()
		local pos_under = pointed_thing.under
		local pos_above = pointed_thing.above

		if minetest.get_node(pos_under).name ~= "hades_xocean:bubble_skeleton" or
				minetest.get_node(pos_above).name ~= "hades_core:water_source" then
			return itemstack
		end

		if minetest.is_protected(pos_under, player_name) or
				minetest.is_protected(pos_above, player_name) then
			minetest.chat_send_player(player_name, "Node is protected")
			minetest.record_protection_violation(pos_under, player_name)
			return itemstack
		end

		minetest.set_node(pos_under, {name = "hades_xocean:skeleton_bubble"})
		if not (minetest.is_creative_enabled(player_name)) then
			itemstack:take_item()
		end

		return itemstack
	end,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "hades_xocean:bubble_skeleton"})
	end,
})
--minetest.override_item("default:coral_brown", {
minetest.register_node("hades_xocean:coral_brown", {
 	description = "Horn Coral Block",
	tiles = {"xocean_coral_horn.png"},
	groups = {cracky = 3, coral_live = 1},
	drop = "hades_xocean:coral_skeleton",
	sounds = hades_sounds.node_sound_stone_defaults(),
})
minetest.register_node("hades_xocean:horn", {
	description = "Horn Coral",
	drawtype = "plantlike_rooted",
	waving = 1,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"xocean_coral_horn.png"},
	special_tiles = {{name = "xocean_horn.png", tileable_vertical = true}},
	inventory_image = "xocean_horn.png",
	groups = {snappy = 3, coral_live = 1, coral_growing = 1},
	drop = "hades_xocean:skeleton_horn",
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "hades_xocean:coral_brown",
	node_placement_prediction = "",
	sounds = hades_sounds.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" or not placer then
			return itemstack
		end

		local player_name = placer:get_player_name()
		local pos_under = pointed_thing.under
		local pos_above = pointed_thing.above

		if minetest.get_node(pos_under).name ~= "hades_xocean:coral_brown" or
				minetest.get_node(pos_above).name ~= "hades_core:water_source" then
			return itemstack
		end

		if minetest.is_protected(pos_under, player_name) or
				minetest.is_protected(pos_above, player_name) then
			minetest.chat_send_player(player_name, "Node is protected")
			minetest.record_protection_violation(pos_under, player_name)
			return itemstack
		end

		minetest.set_node(pos_under, {name = "hades_xocean:horn"})
		if not (minetest.is_creative_enabled(player_name)) then
			itemstack:take_item()
		end

		return itemstack
	end,

	after_destruct  = function(pos, oldnode)
		-- minetest.set_node(pos, {name = "hades_xocean:horn_block"})
		--minetest.set_node(pos, {name = "hades_xocean:horn"})
		minetest.set_node(pos, {name = "hades_xocean:coral_brown"})
	end,
})
--minetest.override_item("default:coral_skeleton", {
minetest.register_node("hades_xocean:coral_skeleton", {
 	description = "Horn Coral Skeleton Block",
	tiles = {"xocean_coral_horn_skeleton.png"},
	groups = {cracky = 3, coral_block_skeleton = 1},
	sounds = hades_sounds.node_sound_stone_defaults(),
})
minetest.register_node("hades_xocean:skeleton_horn", {
	description = "Horn Coral Skeleton",
	drawtype = "plantlike_rooted",
	waving = 1,
	paramtype = "light",
	tiles = {"xocean_coral_horn_skeleton.png"},
	special_tiles = {{name = "xocean_horn_skeleton.png", tileable_vertical = true}},
	inventory_image = "xocean_horn_skeleton.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	-- drop = "hades_xocean:skeleton:horn",
	node_dig_prediction = "hades_xocean:horn_skeleton",
	node_placement_prediction = "",
	sounds = hades_sounds.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" or not placer then
			return itemstack
		end

		local player_name = placer:get_player_name()
		local pos_under = pointed_thing.under
		local pos_above = pointed_thing.above

		-- if minetest.get_node(pos_under).name ~= "hades_xocean:horn_skeleton" or
		if minetest.get_node(pos_under).name ~= "hades_xocean:coral_skeleton" or
				minetest.get_node(pos_above).name ~= "hades_core:water_source" then
			return itemstack
		end

		if minetest.is_protected(pos_under, player_name) or
				minetest.is_protected(pos_above, player_name) then
			minetest.chat_send_player(player_name, "Node is protected")
			minetest.record_protection_violation(pos_under, player_name)
			return itemstack
		end

		minetest.set_node(pos_under, {name = "hades_xocean:skeleton_horn"})
		if not (minetest.is_creative_enabled(player_name)) then
			itemstack:take_item()
		end

		return itemstack
	end,

	after_destruct  = function(pos, oldnode)
		-- minetest.set_node(pos, {name = "hades_xocean:horn_skeleton"})
		minetest.set_node(pos, {name = "hades_xocean:coral_skeleton"})
	end,
})
--minetest.override_item("default:coral_orange", {
minetest.register_node("hades_xocean:coral_orange", {
 	description = "Fire Coral Block",
	tiles = {"xocean_coral_fire.png"},
	groups = {cracky = 3, coral_live = 1},
	drop = "hades_xocean:fire_skeleton",
	sounds = hades_sounds.node_sound_stone_defaults(),
})
minetest.register_node("hades_xocean:fire", {
	description = "Fire Coral",
	drawtype = "plantlike_rooted",
	waving = 1,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"xocean_coral_fire.png"},
	special_tiles = {{name = "xocean_fire.png", tileable_vertical = true}},
	inventory_image = "xocean_fire.png",
	groups = {snappy = 3, coral_live = 1, coral_growing = 1},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	drop = "hades_xocean:skeleton_fire",
	node_dig_prediction = "hades_xocean:coral_orange",
	node_placement_prediction = "",
	sounds = hades_sounds.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" or not placer then
			return itemstack
		end

		local player_name = placer:get_player_name()
		local pos_under = pointed_thing.under
		local pos_above = pointed_thing.above

		if minetest.get_node(pos_under).name ~= "hades_xocean:coral_orange" or
				minetest.get_node(pos_above).name ~= "hades_core:water_source" then
			return itemstack
		end

		if minetest.is_protected(pos_under, player_name) or
				minetest.is_protected(pos_above, player_name) then
			minetest.chat_send_player(player_name, "Node is protected")
			minetest.record_protection_violation(pos_under, player_name)
			return itemstack
		end

		minetest.set_node(pos_under, {name = "hades_xocean:fire"})
		if not (minetest.is_creative_enabled(player_name)) then
			itemstack:take_item()
		end

		return itemstack
	end,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "hades_xocean:coral_orange"})
	end,
})
minetest.register_node("hades_xocean:fire_skeleton", {
 	description = "Fire Coral Skeleton Block",
	tiles = {"xocean_coral_fire_skeleton.png"},
	groups = {cracky = 3, coral_block_skeleton = 1},
	sounds = hades_sounds.node_sound_stone_defaults(),
})
minetest.register_node("hades_xocean:skeleton_fire", {
	description = "Fire Coral Skeleton",
	drawtype = "plantlike_rooted",
	waving = 1,
	paramtype = "light",
	tiles = {"xocean_coral_fire_skeleton.png"},
	special_tiles = {{name = "xocean_fire_skeleton.png", tileable_vertical = true}},
	inventory_image = "xocean_fire_skeleton.png",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	node_dig_prediction = "hades_xocean:fire_skeleton",
	node_placement_prediction = "",
	sounds = hades_sounds.node_sound_stone_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" or not placer then
			return itemstack
		end

		local player_name = placer:get_player_name()
		local pos_under = pointed_thing.under
		local pos_above = pointed_thing.above

		if minetest.get_node(pos_under).name ~= "hades_xocean:fire_skeleton" or
				minetest.get_node(pos_above).name ~= "hades_core:water_source" then
			return itemstack
		end

		if minetest.is_protected(pos_under, player_name) or
				minetest.is_protected(pos_above, player_name) then
			minetest.chat_send_player(player_name, "Node is protected")
			minetest.record_protection_violation(pos_under, player_name)
			return itemstack
		end

		minetest.set_node(pos_under, {name = "hades_xocean:skeleton_fire"})
		if not (minetest.is_creative_enabled(player_name)) then
			itemstack:take_item()
		end

		return itemstack
	end,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "hades_xocean:fire_skeleton"})
	end,
})
---Mapgen
--[[
minetest.register_decoration({
		name = "hades_xocean:brain",
		deco_type = "schematic",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 2,
		noise_params = {
			offset = 0.0001,
			scale = 0.0001,
			spread = {x = 100000, y = 100000, z = 100000},
			seed = 87112,
			octaves = 20,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -6,
		y_min = -16,
		flags = "force_placement",
		schematic = modpath .. "/schems/brain.mts",
		param2 = 48,
		param2_max = 96,
	})
minetest.register_decoration({
		name = "hades_xocean:horn",
		deco_type = "schematic",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 2,
		noise_params = {
			offset = 0.0001,
			scale = 0.0001,
			spread = {x = 100000, y = 100000, z = 100000},
			seed = 87112,
			octaves = 20,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -6,
		y_min = -16,
		flags = "force_placement",
		schematic = modpath .. "/schems/horn.mts",
		param2 = 48,
		param2_max = 96,
	})
minetest.register_decoration({
		name = "hades_xocean:bubble",
		deco_type = "schematic",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 2,
		noise_params = {
			offset = 0.0001,
			scale = 0.0001,
			spread = {x = 100000, y = 100000, z = 100000},
			seed = 87112,
			octaves = 20,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -6,
		y_min = -16,
		flags = "force_placement",
		schematic = modpath .. "/schems/bubble.mts",
		param2 = 48,
		param2_max = 96,
	})
minetest.register_decoration({
		name = "hades_xocean:tube",
		deco_type = "schematic",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 2,
		noise_params = {
			offset = 0.0001,
			scale = 0.0001,
			spread = {x = 100000, y = 100000, z = 100000},
			seed = 87112,
			octaves = 20,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -6,
		y_min = -16,
		flags = "force_placement",
		schematic = modpath .. "/schems/tube.mts",
		param2 = 48,
		param2_max = 96,
	})
minetest.register_decoration({
		name = "hades_xocean:fire",
		deco_type = "schematic",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 2,
		noise_params = {
			offset = 0.0001,
			scale = 0.0001,
			spread = {x = 100000, y = 100000, z = 100000},
			seed = 87112,
			octaves = 20,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -6,
		y_min = -16,
		flags = "force_placement",
		schematic = modpath .. "/schems/fire.mts",
		param2 = 48,
		param2_max = 96,
	})
minetest.register_decoration({
		name = "hades_xocean:brain2",
		deco_type = "schematic",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 2,
		noise_params = {
			offset = 0.0001,
			scale = 0.001,
			spread = {x = 100000, y = 100000, z = 100000},
			seed = 87112,
			octaves = 28,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -6,
		y_min = -16,
		flags = "force_placement",
		schematic = modpath .. "/schems/brain2.mts",
		param2 = 48,
		param2_max = 96,
	})
minetest.register_decoration({
		name = "hades_xocean:horn2",
		deco_type = "schematic",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 2,
		noise_params = {
			offset = 0.0001,
			scale = 0.001,
			spread = {x = 100000, y = 100000, z = 100000},
			seed = 87112,
			octaves = 28,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -6,
		y_min = -16,
		flags = "force_placement",
		schematic = modpath .. "/schems/horn2.mts",
		param2 = 48,
		param2_max = 96,
	})
minetest.register_decoration({
		name = "hades_xocean:bubble2",
		deco_type = "schematic",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 2,
		noise_params = {
			offset = 0.0001,
			scale = 0.001,
			spread = {x = 100000, y = 100000, z = 100000},
			seed = 87112,
			octaves = 28,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -6,
		y_min = -16,
		flags = "force_placement",
		schematic = modpath .. "/schems/bubble2.mts",
		param2 = 48,
		param2_max = 96,
	})
minetest.register_decoration({
		name = "hades_xocean:tube2",
		deco_type = "schematic",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 2,
		noise_params = {
			offset = 0.0001,
			scale = 0.001,
			spread = {x = 100000, y = 100000, z = 100000},
			seed = 87112,
			octaves = 28,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -6,
		y_min = -16,
		flags = "force_placement",
		schematic = modpath .. "/schems/tube2.mts",
		param2 = 48,
		param2_max = 96,
	})
minetest.register_decoration({
		name = "hades_xocean:fire2",
		deco_type = "schematic",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 2,
		noise_params = {
			offset = 0.0001,
			scale = 0.001,
			spread = {x = 100000, y = 100000, z = 100000},
			seed = 87112,
			octaves = 12,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -6,
		y_min = -16,
		flags = "force_placement",
		schematic = modpath .. "/schems/fire2.mts",
		param2 = 48,
		param2_max = 96,
	})
minetest.register_decoration({
		name = "hades_xocean:tube3",
		deco_type = "schematic",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 1  ,
		noise_params = {
			offset = 0.0001,
			scale = 0.000001,
			spread = {x = 100000, y = 100000, z = 100000},
			seed = 87112,
			octaves = 20,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -6,
		y_min = -16,
		flags = "force_placement",
		schematic = modpath .. "/schems/tube3.mts",
		param2 = 48,
		param2_max = 96,
	})
minetest.register_decoration({
		name = "hades_xocean:brain3",
		deco_type = "schematic",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 1,
		noise_params = {
			offset = 0.0001,
			scale = 0.000001,
			spread = {x = 100000, y = 100000, z = 100000},
			seed = 87112,
			octaves = 25,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -6,
		y_min = -16,
		flags = "force_placement",
		schematic = modpath .. "/schems/brain3.mts",
		param2 = 48,
		param2_max = 96,
	})
	minetest.register_decoration({
		name = "hades_xocean:seagrass",
		deco_type = "simple",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 0.4,
			spread = {x = 200, y = 200, z = 200},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -5,
		y_min = -50,
		flags = "force_placement",
		decoration = "hades_xocean:seagrass",
		param2 = 48,
		param2_max = 96,
	})
	minetest.register_decoration({
		name = "hades_xocean:fire_plant_dead",
		deco_type = "simple",
		place_on = {"hades_xocean:brain_block","hades_xocean:tube_block","hades_xocean:coral_orange","hades_xocean:coral_brown","hades_xocean:bubble_block"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 1.0,
			spread = {x = 20, y = 20, z = 20},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -5,
		y_min = -50,
		flags = "force_placement",
		decoration = "hades_xocean:skeleton_fire",
		param2 = 48,
		param2_max = 96,
	})
	minetest.register_decoration({
		name = "hades_xocean:horn_plant_dead",
		deco_type = "simple",
		place_on = {"hades_xocean:brain_block","hades_xocean:tube_block","hades_xocean:coral_orange","hades_xocean:coral_brown","hades_xocean:bubble_block"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 1.0,
			spread = {x = 20, y = 20, z = 20},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -5,
		y_min = -50,
		flags = "force_placement",
		decoration = "hades_xocean:skeleton_horn",
		param2 = 48,
		param2_max = 96,
	})
	minetest.register_decoration({
		name = "hades_xocean:bubble_plant_skeleton",
		deco_type = "simple",
		place_on = {"hades_xocean:brain_block","hades_xocean:tube_block","hades_xocean:coral_orange","hades_xocean:coral_brown","hades_xocean:bubble_block"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 1.0,
			spread = {x = 20, y = 20, z = 20},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -5,
		y_min = -50,
		flags = "force_placement",
		decoration = "hades_xocean:skeleton_bubble",
		param2 = 48,
		param2_max = 96,
	})
	minetest.register_decoration({
		name = "hades_xocean:brain_plant_skeleton",
		deco_type = "simple",
		place_on = {"hades_xocean:brain_block","hades_xocean:tube_block","hades_xocean:coral_orange","hodes_xocean:coral_brown","hades_xocean:bubble_block"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 1.0,
			spread = {x = 20, y = 20, z = 20},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -5,
		y_min = -50,
		flags = "force_placement",
		decoration = "hades_xocean:skeleton_brain",
		param2 = 48,
		param2_max = 96,
	})
	minetest.register_decoration({
		name = "hades_xocean:tube_plant",
		deco_type = "simple",
		place_on = {"hades_xocean:brain_block","hades_xocean:tube_block","hades_xocean:coral_orange","hades_xocean:coral_brown","hades_xocean:bubble_block"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 1.0,
			spread = {x = 20, y = 20, z = 20},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -5,
		y_min = -50,
		flags = "force_placement",
		decoration = "hades_xocean:skeleton_tube",
		param2 = 48,
		param2_max = 96,
	})
	minetest.register_decoration({
		name = "hades_xocean:fire_plant",
		deco_type = "simple",
		place_on = {"hades_xocean:brain_block","hades_xocean:tube_block","hades_xocean:coral_orange","hades_xocean:coral_brown","hades_xocean:bubble_block"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 1.0,
			spread = {x = 20, y = 20, z = 20},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -5,
		y_min = -50,
		flags = "force_placement",
		decoration = "hades_xocean:fire",
		param2 = 48,
		param2_max = 96,
	})
	minetest.register_decoration({
		name = "hades_xocean:horn_plant",
		deco_type = "simple",
		place_on = {"hades_xocean:brain_block","hades_xocean:tube_block","hades_xocean:coral_orange","hades_xocean:coral_brown","hades_xocean:bubble_block"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 1.0,
			spread = {x = 20, y = 20, z = 20},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -5,
		y_min = -50,
		flags = "force_placement",
		decoration = "hades_xocean:horn",
		param2 = 48,
		param2_max = 96,
	})
	minetest.register_decoration({
		name = "hades_xocean:bubble_plant",
		deco_type = "simple",
		place_on = {"hades_xocean:brain_block","hades_xocean:tube_block","hades_xocean:coral_orange","hades_xocean:coral_brown","hades_xocean:bubble_block"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 1.0,
			spread = {x = 20, y = 20, z = 20},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -5,
		y_min = -50,
		flags = "force_placement",
		decoration = "hades_xocean:bubble",
		param2 = 48,
		param2_max = 96,
	})
	minetest.register_decoration({
		name = "hades_xocean:brain_plant",
		deco_type = "simple",
		place_on = {"hades_xocean:brain_block","hades_xocean:tube_block","hades_xocean:coral_orange","hades_xocean:coral_brown","hades_xocean:bubble_block"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 1.0,
			spread = {x = 20, y = 20, z = 20},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -5,
		y_min = -50,
		flags = "force_placement",
		decoration = "hades_xocean:coral_pink",
		param2 = 48,
		param2_max = 96,
	})
	minetest.register_decoration({
		name = "hades_xocean:tube_plant",
		deco_type = "simple",
		place_on = {"hades_xocean:brain_block","hades_xocean:tube_block","hades_xocean:coral_orange","hades_xocean:coral_brown","hades_xocean:bubble_block"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 1.0,
			spread = {x = 20, y = 20, z = 20},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -5,
		y_min = -50,
		flags = "force_placement",
		decoration = "hades_xocean:coral_cyan",
		param2 = 48,
		param2_max = 96,
	})
	minetest.register_decoration({
		name = "hades_xocean:pickle",
		deco_type = "simple",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 0.04,
			spread = {x = 200, y = 200, z = 200},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -8,
		y_min = -50,
		flags = "force_placement",
		decoration = "hades_xocean:pickle",
		param2 = 48,
		param2_max = 96,
	})
--]]
---Mobs
if minetest.get_modpath("mobs") then
local l_water_level		= minetest.setting_get("water_level") - 2
	mobs:register_mob("hades_xocean:dolphin", {
		type = "animal",
		attack_type = "dogfight",
		damage = 1,
		visual_size = {x = 15, y = 15, z= 15},
		reach = 3,
		hp_min = 20,
		hp_max = 20,
		armor = 100,
		collisionbox = {-0.75, -0.5, -0.75, 0.75, 0.5, 0.75},
		visual = "mesh",
		mesh = "dolphin.b3d",
		textures = {
			{"mobs_dolphin.png"}
		},
		drops = {
        {name = "mobs:meat_raw", chance = 1, min = 2, max = 4},
    },
		makes_footstep_sound = false,
		walk_velocity = 4,
		run_velocity = 6,
		stepheight = 0.1,
		fly = true,
		fly_in = "hades_core:water_source",
		fall_speed = 0,
		rotate = 90,
		view_range = 30,
		water_damage = 0,
		lava_damage = 10,
		jump = false,
		stepheight = 0.1,
		light_damage = 0,
		animation = {
			speed_normal = 15,
	    speed_run = 25,
			stand_start = 40,
			stand_end = 100,
	    walk_start = 40,
	    walk_end = 100,
	    run_start = 40,
	    run_end = 100,
		},
		follow = {"hades_xocean:fish_edible", 
		},
		on_rightclick = function(self, clicker)
			if mobs:feed_tame(self, clicker, 8, true, true) then return end
		end
	})
	--mobs:spawn_specific("hades_xocean:dolphin",	{"default:water_source"},	{"default:water_flowing","default:water_source"},	5, 20, 30, 10000, 2, -31000, l_water_level)
	mobs:register_egg("hades_xocean:dolphin", "Dolphin", "xocean_stone.png", 1)
  minetest.override_item("hades_xocean:dolphin", {
      _tt_help = "Eat fishes.",
    })
mobs:register_mob("hades_xocean:fish", {
		type = "animal",
		hp_min = 5,
		hp_max = 5,
		armor = 100,
		visual_size = {x = 2, y = 2, z= 2},
		collisionbox = {-0.25, -0.2, -0.25, 0.25, 0.2, 0.25},
		visual = "mesh",
		mesh = "fishy.b3d",
		textures = {
			{"mobs_fishy.png"},
			{"mobs_fishy1.png"},
			{"mobs_fishy2.png"},
			{"mobs_fishy3.png"}
		},
		drops = {
        {name = "hades_xocean:fish_edible", chance = 1, min = 1, max = 1},
    },
		makes_footstep_sound = false,
		walk_velocity = 2,
		run_velocity = 3,
		stepheight = 0.1,
		fly = true,
		fly_in = "hades_core:water_source",
		fall_speed = 0,
		view_range = 30,
		water_damage = 0,
		lava_damage = 10,
		light_damage = 0,
		animation = {
			speed_normal = 15,
	    speed_run = 25,
			stand_start = 40,
			stand_end = 100,
	    walk_start = 40,
	    walk_end = 100,
	    run_start = 40,
	    run_end = 100,
		},
		follow = {"hades_waterplants:seaweed", "hades_waterplants:waterlily",
			"hades_xocean:sand_with_kelp", "hades_xocean:seagrass",
		},
		on_rightclick = function(self, clicker)
			if mobs:feed_tame(self, clicker, 4, true, true) then return end
		end
	})
	--mobs:spawn_specific("hades_xocean:fish",	{"default:water_source"},	{"default:water_flowing","default:water_source"},	2, 20, 30, 10000, 5, -31000, l_water_level)
	mobs:register_egg("hades_xocean:fish", "Tropical Fish (Kob)", "xocean_fish.png", 0)
  minetest.override_item("hades_xocean:fish", {
      _tt_help = "Eat water plants.",
    })
mobs:register_mob("hades_xocean:fish2", {
		type = "animal",
		hp_min = 5,
		hp_max = 5,
		armor = 100,
		visual_size = {x = 2, y = 2, z= 2},
		collisionbox = {-0.25, -0.2, -0.25, 0.25, 0.2, 0.25},
		visual = "mesh",
		mesh = "fishy.b3d",
		textures = {
			{"mobs_fishy4.png"},
			{"mobs_fishy5.png"},
			{"mobs_fishy6.png"}
		},
		drops = {
        {name = "hades_xocean:fish_edible", chance = 2, min = 1, max = 2},
    },
		makes_footstep_sound = false,
		walk_velocity = 2,
		run_velocity = 3,
		stepheight = 0.1,
		fly = true,
		fly_in = "hades_core:water_source",
		fall_speed = 0,
		view_range = 30,
		water_damage = 0,
		lava_damage = 10,
		light_damage = 0,
		animation = {
			speed_normal = 15,
	    speed_run = 25,
			stand_start = 40,
			stand_end = 100,
	    walk_start = 40,
	    walk_end = 100,
	    run_start = 40,
	    run_end = 100,
		},
		follow = {"hades_waterplants:seaweed", "hades_waterplants:waterlily",
			"hades_xocean:sand_with_kelp", "hades_xocean:seagrass",
		},
		on_rightclick = function(self, clicker)
			if mobs:feed_tame(self, clicker, 4, true, true) then return end
		end
	})
	--mobs:spawn_specific("hades_xocean:fish2",	{"default:water_source"},	{"default:water_flowing","default:water_source"},	2, 20, 30, 10000, 5, -31000, l_water_level)
	mobs:register_egg("hades_xocean:fish2", "Tropical Fish (SunStreak)", "xocean_fish2.png", 0)
  minetest.override_item("hades_xocean:fish2", {
      _tt_help = "Eat water plants.",
    })
mobs:register_mob("hades_xocean:fish3", {
		type = "animal",
		hp_min = 5,
		hp_max = 5,
		armor = 100,
		visual_size = {x = 2, y = 2, z= 2},
		collisionbox = {-0.25, -0.2, -0.25, 0.25, 0.2, 0.25},
		visual = "mesh",
		mesh = "fishy.b3d",
		textures = {
			{"mobs_fishy7.png"},
			{"mobs_fishy8.png"},
			{"mobs_fishy9.png"}
		},
		drops = {
        {name = "hades_xocean:fish_edible", chance = 2, min = 1, max = 2},
    },
		makes_footstep_sound = false,
		walk_velocity = 2,
		run_velocity = 3,
		stepheight = 0.1,
		fly = true,
		fly_in = "hades_core:water_source",
		fall_speed = 0,
		view_range = 30,
		water_damage = 0,
		lava_damage = 10,
		light_damage = 0,
		animation = {
			speed_normal = 15,
	    speed_run = 25,
			stand_start = 40,
			stand_end = 100,
	    walk_start = 40,
	    walk_end = 100,
	    run_start = 40,
	    run_end = 100,
		},
		follow = {"hades_waterplants:seaweed", "hades_waterplants:waterlily",
			"hades_xocean:sand_with_kelp", "hades_xocean:seagrass",
		},
		on_rightclick = function(self, clicker)
			if mobs:feed_tame(self, clicker, 4, true, true) then return end
		end
	})
	--mobs:spawn_specific("hades_xocean:fish3",	{"default:water_source"},	{"default:water_flowing","default:water_source"},	2, 20, 30, 10000, 5, -31000, l_water_level)
	mobs:register_egg("hades_xocean:fish3", "Tropical Fish (Dasher)", "xocean_fish3.png", 0)
  minetest.override_item("hades_xocean:fish3", {
      _tt_help = "Eat water plants.",
    })
mobs:register_mob("hades_xocean:fish4", {
		type = "animal",
		hp_min = 5,
		hp_max = 5,
		armor = 100,
		visual_size = {x = 2, y = 2, z= 2},
		collisionbox = {-0.25, -0.2, -0.25, 0.25, 0.2, 0.25},
		visual = "mesh",
		mesh = "fishy.b3d",
		textures = {
			{"mobs_fishy10.png"},
			{"mobs_fishy11.png"},
			{"mobs_fishy12.png"}
		},
		drops = {
        {name = "hades_xocean:fish_edible", chance = 2, min = 1, max = 2},
    },
		makes_footstep_sound = false,
		walk_velocity = 2,
		run_velocity = 3,
		stepheight = 0.1,
		fly = true,
		fly_in = "hades_core:water_source",
		fall_speed = 0,
		view_range = 30,
		water_damage = 0,
		lava_damage = 10,
		light_damage = 0,
		animation = {
			speed_normal = 15,
	    speed_run = 25,
			stand_start = 40,
			stand_end = 100,
	    walk_start = 40,
	    walk_end = 100,
	    run_start = 40,
	    run_end = 100,
		},
		follow = {"hades_waterplants:seaweed", "hades_waterplants:waterlily",
			"hades_xocean:sand_with_kelp", "hades_xocean:seagrass",
		},
		on_rightclick = function(self, clicker)
			if mobs:feed_tame(self, clicker, 4, true, true) then return end
		end
	})
	--mobs:spawn_specific("hades_xocean:fish4",	{"default:water_source"},	{"default:water_flowing","default:water_source"},	2, 20, 30, 10000, 5, -31000, l_water_level)
	mobs:register_egg("hades_xocean:fish4", "Tropical Fish (Snapper)", "xocean_fish4.png", 0)
  minetest.override_item("hades_xocean:fish4", {
      _tt_help = "Eat water plants.",
    })
end

-- Let the server console know the initialization is done
core.log("[Xocean] Initialization is complete.")
