
hades_xocean = {
  fishes = {
    ["hades_xocean:dolphin"] = true,
    ["hades_xocean:fish"] = true,
    ["hades_xocean:fish2"] = true,
    ["hades_xocean:fish3"] = true,
    ["hades_xocean:fish4"] = true,
  },
}

function hades_xocean.add_fish(fish_name)
  hades_xocean.fishes[fish_name] = true
end

minetest.register_privilege("xocean_fix_fish", {
    description = "Allow player to use /fix_nearby_fishes command.",
    give_to_signleplayer = false,
    give_to_admin = false,
  })

local command_fix_nearby_fishes = {
    params = "<entityname>",
    description = "Find fishes nearby (5) and check if they are in water. If not, move them to nearby water. Uses registere list of fishes or by parameter <entityname> specified fish entity name.",
    privs = {xocean_fix_fish=true},
    func = function (name, param)
        -- check param
        local fishes = hades_xocean.fishes
        if (param~=nil) and (param~="") then
          fishes = {[param]=true} 
        end
        
        local player = minetest.get_player_by_name(name);
        local objects = minetest.get_objects_inside_radius(player:get_pos(), 5);
        local fixed_fishes = 0;
        local find_fishes = 0;
        for _,object in pairs(objects) do
          local luaentity = object:get_luaentity()
          if luaentity and (fishes[luaentity.name]) then
            local fish_pos = object:get_pos();
            find_fishes = find_fishes + 1;
            local node = minetest.get_node(fish_pos)
            if (node.name~="hades_core:water_source") then
              local find_pos = minetest.find_node_near(fish_pos, 5, {"hades_core:water_source"})
              if find_pos then
                fixed_fishes = fixed_fishes + 1
                object:move_to(find_pos)
              else
                minetest.chat_send_player(name, "Fish on "..minetest.pos_to_string(fish_pos, 1).." can't be fixed. No water source found in radius 5 around fish.")
              end
            end
          end
        end
        return true, "Fixed fishes "..fixed_fishes.."/"..find_fishes..".";
      end
  };
minetest.register_chatcommand("fix_nearby_fishes", command_fix_nearby_fishes)

