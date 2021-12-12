
local S = minetest.get_translator("xocean")

local function add_metamorphosis_report(node_name, report)
  local def = minetest.registered_nodes[node_name]
  if def._metamorphosis_report then
    report = def._metamorphosis_report.."\n\n"..report
  end
  minetest.override_item(node_name, {
      _metamorphosis_report = report
    })
end

function half_time_calc(interval, chance, treshold)
  local steps = math.log(0.5)/math.log((chance-1)/chance)
  -- 1.41 like calculation error compensation for param_treshold 15
  return math.floor(1.41*(treshold+1)*steps*interval/360+0.5)/10
end

local param_treshold = 15 

-- make ocean stone from silver_sandstone
minetest.register_abm({ 
  label = "Create ocean stone",
  nodenames = {"hades_default:silver_sandstone"},
  neighbors = {"group:water"},
  interval = 389,
  chance = 3727,
  action = function(pos, node)
    if (minetest.find_node_near(pos, 1, {"group:air"}) == nil) then
      node.param1 = node.param1 + 1;
      if (node.param1>param_treshold) then
        minetest.set_node(pos, {name="hades_xocean:ocean_stone"})
      else
        minetest.swap_node(pos, node)
      end
    end
  end,
})

add_metamorphosis_report("hades_default:silver_sandstone",
    string.format(S("Silver sandstone metamorphoses into ocean stone. It requires contact with water and without air. Half-metamorphose time is %i hours."),half_time_calc(389, 3727, param_treshold))
  )

add_metamorphosis_report("hades_xocean:ocean_stone", 
    S("Ocean stone arise by metamorphosis from silver sandstone.")
  )
-- craft corale blocks
minetest.register_craft({
	output = 'hades_xocean:brain_block',
	recipe = {
		{'hades_xocean:coral_pink', 'hades_xocean:coral_pink', 'hades_xocean:coral_pink'},
		{'hades_xocean:coral_pink', 'hades_xocean:ocean_cobble', 'hades_xocean:coral_pink'},
		{'hades_xocean:coral_pink', 'hades_xocean:coral_pink', 'hades_xocean:coral_pink'},
		},
})
minetest.register_craft({
	output = 'hades_xocean:bubble_block',
	recipe = {
		{'hades_xocean:bubble', 'hades_xocean:bubble', 'hades_xocean:bubble'},
		{'hades_xocean:bubble', 'hades_xocean:ocean_cobble', 'hades_xocean:bubble'},
		{'hades_xocean:bubble', 'hades_xocean:bubble', 'hades_xocean:bubble'},
		},
})
minetest.register_craft({
	output = 'hades_xocean:coral_brown',
	recipe = {
		{'hades_xocean:horn', 'hades_xocean:horn', 'hades_xocean:horn'},
		{'hades_xocean:horn', 'hades_xocean:ocean_cobble', 'hades_xocean:horn'},
		{'hades_xocean:horn', 'hades_xocean:horn', 'hades_xocean:horn'},
		},
})
minetest.register_craft({
	output = 'hades_xocean:coral_orange',
	recipe = {
		{'hades_xocean:fire', 'hades_xocean:fire', 'hades_xocean:fire'},
		{'hades_xocean:fire', 'hades_xocean:ocean_cobble', 'hades_xocean:fire'},
		{'hades_xocean:fire', 'hades_xocean:fire', 'hades_xocean:fire'},
		},
})
minetest.register_craft({
	output = 'hades_xocean:tube_block',
	recipe = {
		{'hades_xocean:coral_cyan', 'hades_xocean:coral_cyan', 'hades_xocean:coral_cyan'},
		{'hades_xocean:coral_cyan', 'hades_xocean:ocean_cobble', 'hades_xocean:coral_cyan'},
		{'hades_xocean:coral_cyan', 'hades_xocean:coral_cyan', 'hades_xocean:coral_cyan'},
		},
})


-- kill corals
local coral_skeletons = {
  ["hades_xocean:brain_block"]="hades_xocean:brain_skeleton",
  ["hades_xocean:coral_pink"]="hades_xocean:skeleton_brain",
  ["hades_xocean:bubble_block"]="hades_xocean:bubble_skeleton",
  ["hades_xocean:bubble"]="hades_xocean:skeleton_bubble",
  ["hades_xocean:coral_brown"]="hades_xocean:coral_skeleton",
  ["hades_xocean:horn"]="hades_xocean:skeleton_horn",
  ["hades_xocean:coral_orange"]="hades_xocean:fire_skeleton",
  ["hades_xocean:fire"]="hades_xocean:skeleton_fire",
  ["hades_xocean:tube_block"]="hades_xocean:tube_skeleton",
  ["hades_xocean:coral_cyan"]="hades_xocean:skeleton_tube",
  -- aquaz support
  ["hades_aquaz:rhodophyta_base"]="hades_aquaz:rhodophyta_base_skeleton",
  ["hades_aquaz:psammocora_base"]="hades_aquaz:psammocora_base_skeleton",
  ["hades_aquaz:sarcophyton_base"]="hades_aquaz:sarcophyton_base_skeleton",
  ["hades_aquaz:carnation_base"]="hades_aquaz:carnation_base_skeleton",
  ["hades_aquaz:fiery_red_base"]="hades_aquaz:fiery_red_base_skeleton",
  ["hades_aquaz:acropora_base"]="hades_aquaz:acropora_base_skeleton",
  ["hades_aquaz:rhodophyta"]="hades_aquaz:rhodophyta_skeleton",
  ["hades_aquaz:psammocora"]="hades_aquaz:psammocora_skeleton",
  ["hades_aquaz:sarcophyton"]="hades_aquaz:sarcophyton_skeleton",
  ["hades_aquaz:carnation"]="hades_aquaz:carnation_skeleton",
  ["hades_aquaz:fiery_red"]="hades_aquaz:fiery_red_skeleton",
  ["hades_aquaz:acropora"]="hades_aquaz:acropora_skeleton",
  ["hades_aquaz:pink_birdnest_coral"]="hades_aquaz:pink_birdnest_coral_skeleton",
  ["hades_aquaz:sea_blade_coral"]="hades_aquaz:sea_blade_coral_skeleton",
  --["hades_aquaz:"]="hades_aquaz:_skeleton",
}
local check_pos = {
  {x = 0, y =1, z = 0},
	{x = 1, y =0, z = 0},
	{x = -1, y =0, z = 0},
	{x = 0, y =0, z = 1},
	{x = 0, y =0, z = -1},
  {x = 0, y =-1, z = 0},
}
local coral_light_limit = 4
minetest.register_abm({ 
  label = "Kill coral",
  nodenames = {"group:coral_live"},
  interval = 17,
  chance = 31,
  action = function(pos, node)
    if (minetest.find_node_near(pos, 1, {"air"}) ~= nil)
				or (minetest.find_node_near(pos, 1, {"group:water"}) == nil) then
      minetest.swap_node(pos, {name=coral_skeletons[node.name]})
    else
      if minetest.get_item_group(node.name, "coral_growing") then
        local dir = minetest.wallmounted_to_dir(node.param2%8)
        local check = vector.subtract(pos, dir)
        check = minetest.get_node(check)
        if ((check.param1%16)<coral_light_limit) then
          minetest.swap_node(pos, {name=coral_skeletons[node.name]})
        end
      else
        local light_good = false
        for _,check in pairs(check_pos) do
          local get_pos = vector.add(pos, check)
          local node = minetest.get_node(get_pos)
          if (node.name=="hades_core:water_source") and ((node.param1%16)>=coral_light_limit) then
            light_good = true
            break
          end
        end
        if not light_good then
          minetest.set_node(pos, {name=coral_skeletons[node.name]})
        end
      end
    end
  end,
})

-- grow corals
local coral_grow = {
  ["hades_xocean:coral_pink"]="hades_xocean:brain_block",
  ["hades_xocean:bubble"]="hades_xocean:bubble_block",
  ["hades_xocean:horn"]="hades_xocean:coral_brown",
  ["hades_xocean:fire"]="hades_xocean:coral_orange",
  ["hades_xocean:coral_cyan"]="hades_xocean:tube_block",
  -- hades_aquaz support
  ["hades_aquaz:rhodophyta"]="hades_aquaz:rhodophyta_base",
  ["hades_aquaz:psammocora"]="hades_aquaz:psammocora_base",
  ["hades_aquaz:sarcophyton"]="hades_aquaz:sarcophyton_base",
  ["hades_aquaz:carnation"]="hades_aquaz:carnation_base",
  ["hades_aquaz:fiery_red"]="hades_aquaz:fiery_red_base",
  ["hades_aquaz:acropora"]="hades_aquaz:acropora_base",
  ["hades_aquaz:aquamarine_coral"]="hades_aquaz:aquamarine_base",
  ["hades_aquaz:pink_birdnest_coral"]="hades_xocean:brain_skeleton",
  ["hades_aquaz:sea_blade_coral"]="hades_xocean:bubble_skeleton",
  --["hades_aquaz:"]="hades_aquaz:_base",
}
local coral_param_treshold = 31 
local function find_grow_pos(pos)
	local max_light = coral_light_limit-1
	local sel_pos = nil
	for _,check in pairs(check_pos) do
		local get_pos = vector.add(pos, check)
		local node = minetest.get_node(get_pos)
    local day_light = node.param1%16 
		if (node.name=="hades_core:water_source") and (day_light>max_light) then
			max_light = day_light
			sel_pos = get_pos
		end
	end
	return sel_pos
end
minetest.register_abm({ 
  label = "Grow coral",
  nodenames = {"group:coral_growing"},
  neighbors = {"hades_core:water_source"},
  interval = 677,
  chance = 1109,
  action = function(pos, node)
    if (minetest.find_node_near(pos, 1, {"air"}) ~= nil)
				or (minetest.find_node_near(pos, 1, {"group:water"}) == nil) then
      return
    end
    local dir = minetest.wallmounted_to_dir(node.param2%8)
    local check = vector.subtract(pos, dir)
    check = minetest.get_node(check)
		if ((check.param1%16)>=coral_light_limit) then
			node.param2 = node.param2 + 8
			if (node.param2/8 >= coral_param_treshold) then
				local new_coral = minetest.wallmounted_to_dir(node.param2%8)
				new_coral = vector.subtract(pos, new_coral)
				local dir = find_grow_pos(new_coral)
				if (dir~=nil) then
					local param2 = minetest.dir_to_wallmounted(vector.subtract(new_coral, dir))
					minetest.set_node(new_coral, {name=node.name, param2=param2})
				else
					minetest.set_node(new_coral, {name=coral_grow[node.name]})
				end
				
				dir = find_grow_pos(pos)
				if (dir~=nil) then
					local param2 = minetest.dir_to_wallmounted(vector.subtract(pos, dir))
					minetest.swap_node(pos, {name=node.name, param2=param2})
				else
					minetest.swap_node(pos, {name=coral_grow[node.name]})
				end
			else
				minetest.swap_node(pos, node)
			end
    end
  end,
})

-- grow coral block
local coral_block_grow = {
  ["hades_xocean:brain_block"]="hades_xocean:coral_pink",
  ["hades_xocean:bubble_block"]="hades_xocean:bubble",
  ["hades_xocean:coral_brown"]="hades_xocean:horn",
  ["hades_xocean:coral_orange"]="hades_xocean:fire",
  ["hades_xocean:tube_block"]="hades_xocean:coral_cyan",
  -- hades_aquaz support
  ["hades_aquaz:rhodophyta_base"]="hades_aquaz:rhodophyta",
  ["hades_aquaz:psammocora_base"]="hades_aquaz:psammocora",
  ["hades_aquaz:sarcophyton_base"]="hades_aquaz:sarcophyton",
  ["hades_aquaz:carnation-base"]="hades_aquaz:carnation",
  ["hades_aquaz:fiery_red_base"]="hades_aquaz:fiery_red",
  ["hades_aquaz:acropora_base"]="hades_aquaz:acropora",
  ["hades_aquaz:aquamarine_base"]="hades_aquaz:aquamarine_coral",
  ["hades_xocean:brain_skeleton"]="hades_aquaz:pink_birdnest_coral",
  ["hades_xocean:bubble_skeleton"]="hades_aquaz:sea_blade_coral",
  --["hades_aquaz:"]="hades_aquaz:_base",
}
minetest.register_abm({ 
  label = "Grow coral block",
  nodenames = {"group:coral_block_growing"},
  neighbors = {"hades_core:water_source"},
  interval = 757,
  chance = 1499,
  action = function(pos, node)
    if (minetest.find_node_near(pos, 1, {"air"}) ~= nil)
				or (minetest.find_node_near(pos, 1, {"group:water"}) == nil) then
      return
    end
    local dir = find_grow_pos(pos)
    if (dir~=nil) then
      local meta = minetest.get_meta(pos)
      local new_coral = meta:get("coral_grow_to") or coral_block_grow[node.name]
      local param2 = minetest.dir_to_wallmounted(vector.subtract(pos, dir))
      minetest.swap_node(pos, {name=new_coral, param2=param2})
    end
  end,
})

-- grow kelp
local kelp_light_limit = 2
local kelp_light_center = 8.5
local kelp_param_limit = 6*16
minetest.register_abm({ 
  label = "Grow kelp",
  nodenames = {"group:kelp_growing"},
  interval = 46,
  chance = 20,
  action = function(pos, node)
    -- check above nodes
    local height = math.ceil(node.param2/16)
    local above_pos = vector.new(pos)
    for y = (pos.y+1),(pos.y+height) do
      above_pos.y = y
      local above = minetest.get_node(above_pos)
      if  (above.name~="hades_core:water_source")
          or ((above.param1%16)<kelp_light_limit) then
        -- kill and return
        y = y - pos.y - 1
        if y == 0 then
          minetest.set_node(pos, {name="hades_default:sand"})
        else
          node.param2 = y*16-8
          minetest.swap_node(pos, node)
        end
        return
      end
    end
	  node.param2 = node.param2 + 1
    height = math.ceil(node.param2/16)
    above_pos.y = pos.y + height
    local above = minetest.get_node(above_pos)
    local day_light = node.param1%16
    if  (node.param2<=kelp_param_limit)
        and (above.name=="hades_core:water_source")
        and (day_light>=kelp_light_limit) then
      minetest.swap_node(pos, node)
    else
      -- no space for grow, try to spreed
      height = math.ceil((node.param2-1)/16)
      above_pos.y = pos.y + height
      
      local pos0 = {x=pos.x-6,y=above_pos.y-8,z=pos.z-6}
      local pos1 = {x=pos.x+6,y=above_pos.y+2,z=pos.z+6}
      
      local found_pos = minetest.find_nodes_in_area(pos0, pos1, "group:kelp")
      if #found_pos > (((7-math.abs(day_light-kelp_light_center))/7)*144) then
        return
      end
      
      found_pos = minetest.find_nodes_in_area(pos0, pos1, "hades_default:sand")
      
      if #found_pos > 0 then
        found_pos = found_pos[math.random(#found_pos)]
        found_pos.y = found_pos.y + 1
        local found_node = minetest.get_node(found_pos)
        if  (found_node.name=="hades_core:water_source")
            and ((found_node.param1%16)>=kelp_light_limit) then
          found_pos.y = found_pos.y - 1
          minetest.set_node(found_pos, {name=node.name, param2 = 1})
        end
      end
      
    end
  end,
})

-- grow seagrass

local seagrass_light_limit = 9
minetest.register_abm({ 
  label = "Grow seagrass",
  nodenames = {"group:seagrass_growing"},
  interval = 45,
  chance = 47,
  action = function(pos, node)
    pos.y = pos.y + 1
    local node_above = minetest.get_node(pos)
    pos.y = pos.y - 1
    local day_light = node_above.param1%16
    if  (node_above.name=="hades_core:water_source") 
				and (day_light>=seagrass_light_limit) then
      -- spreed
      local pos0 = {x=pos.x-6,y=pos.y-8,z=pos.z-6}
      local pos1 = {x=pos.x+6,y=pos.y+2,z=pos.z+6}
      
      local found_pos = minetest.find_nodes_in_area(pos0, pos1, "group:seagrass")
      if #found_pos > (((day_light-seagrass_light_limit+1)/(15-seagrass_light_limit))*144) then
        return
      end
      
      found_pos = minetest.find_nodes_in_area(pos0, pos1, "hades_default:sand")
      if #found_pos > 0 then
        found_pos = found_pos[math.random(#found_pos)]
        found_pos.y = found_pos.y + 1
        local found_node = minetest.get_node(found_pos)
        if  (found_node.name=="hades_core:water_source")
            and ((found_node.param1%16)>=seagrass_light_limit) then
          found_pos.y = found_pos.y - 1
          minetest.set_node(found_pos, {name=node.name})
        end
      end
    else
      -- die (no water, no light)
      minetest.set_node(pos, {name="hades_default:sand"})
    end
  end,
})

