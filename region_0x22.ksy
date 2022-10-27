meta:
    id: region_0x22
    file-extension: wld
    endian: le
    bit-endian: le
    imports:
      - wld_common

# REGION

seq:
  - id: name_reference
    type: s4
  - id: flags
    type: region_flags
  - id: ambient_light
    type: u4
  - id: num_region_vertex
    type: u4
  - id: num_proximal_regions
    type: u4
  - id: num_render_vertices
    type: u4
  - id: num_walls
    type: u4
  - id: num_obstacles
    type: u4
  - id: num_cutting_obstacles
    type: u4
  - id: num_vis_node
    type: u4
  - id: num_vis_list
    type: u4
  - id: region_vertices
    type: wld_common::xyz
    repeat: expr
    repeat-expr: num_region_vertex
  - id: proximal_regions
    type: proximal_region
    repeat: expr
    repeat-expr: num_proximal_regions
  # TODO: come back to this
  # - id: render_vertices
  #   type: xyz
  #   repeat: expr
  #   repeat-expr: num_render_vertices
  - id: walls
    type: wall
    repeat: expr
    repeat-expr: num_walls
  - id: obstacles
    type: obstacle
    repeat: expr
    repeat-expr: num_obstacles
  - id: vis_nodes
    type: vis_node
    repeat: expr
    repeat-expr: num_vis_node
  - id: visible_lists
    type: visible_list
    repeat: expr
    repeat-expr: num_vis_list
  - id: sphere
    if: flags.has_sphere
    type: wld_common::sphere
  - id: reverb_volume
    type: f4
    if: flags.has_reverb_volume
  - id: reverb_offset
    type: u4
    if: flags.has_reverb_offset
  - id: user_data_size
    type: u4
  - id: user_data
    size: user_data_size
  - id: mesh_reference
    type: u4
    if: flags.has_mesh_reference

types:
  region_flags:
    seq:
      - id: has_sphere
        type: b1
      - id: has_reverb_volume
        type: b1
      - id: has_reverb_offset
        type: b1
      - id: region_fog
        type: b1
      - id: enable_gouraud2
        type: b1
      - id: encoded_visibility
        type: b1
      - id: has_mesh_reference
        type: b1
      - id: has_byte_entries
        type: b1
      - id: padding
        type: b24

  proximal_region:
    seq:
      - id: unk
        type: u4
      - id: unk2
        type: f4

  wall:
    seq:
      - id: flags
        type: wall_flags
      - id: num_vertices
        type: u4
      - id: vertex_list # 0 based in the binary, 1 based in ascii
        type: u4
        repeat: expr
        repeat-expr: num_vertices
      - id: render_method
        # should be its own type to handle the > 80000000000 user defined etc
        # size: 4
        type: wld_common::render_method_attrs
      - id: render_info
        type: wld_common::render_info
      - id: normal_abcd
        type: wld_common::normal_abcd
        if: flags.has_render_normal

    types:
      wall_flags:
        seq:
          - id: has_floor
            type: b1
          - id: has_render_normal
            type: b1
          - id: padding
            type: b30

  # FUN_0040b170
  # document other obstacle types
  obstacle:
    seq:
      - id: flags
        type: obstacle_flags
      - id: next_region
        type: u4
      - id: type
        type: s4
        enum: obstacle_type
      - id: num_vertices
        type: u4
        if: 'type == obstacle_type::edge_polygon or type == obstacle_type::edge_polygon_normal_abcd'
      - id: vertex_list # 0 based in the binary, 1 based in ascii
        type: u4
        repeat: expr
        repeat-expr: num_vertices
      - id: normal_abcd
        type: wld_common::normal_abcd
        if: type == obstacle_type::edge_polygon_normal_abcd
      - id: edge_wall
        type: edge_wall
        if: type == obstacle_type::edge_wall
      # TODO: come back to this
      # - id: user_data_size
      #   if: flags.has_user_data
      # - id: user_data
      #   size: user_data_size
      #   if: flags.has_user_data
      #   # size: 'flags.has_user_data ? user_data_size : 0'

    enums:
      obstacle_type:
        8: xy_vertex
        9: xyz_vertex
        10: xy_line
        11: xy_edge
        12: xyz_edge
        13: plane
        14: edge_polygon
        18: edge_wall
        -15: edge_polygon_normal_abcd

    types:
      obstacle_flags:
        seq:
          - id: has_floor
            type: b1
          - id: is_geometery_cutting
            type: b1
          - id: has_userdata
            type: b1
          - id: padding
            type: b29

      edge_wall:
        # might be a single u4, need to poke the data
        seq:
          - id: unk1
            type: u2
          - id: unk2
            type: u2

  vis_node:
    seq:
      - id: normal_abcd
        type: wld_common::normal_abcd
      - id: vis_list_index
        type: u4
      - id: front_tree
        type: u4
      - id: back_tree
        type: u4

  visible_list:
    seq:
      - id: range_count
        type: u2
      - id: ranges
        type:
          switch-on: entry_size
          cases:
            1: u1
            2: u2
        repeat: expr
        repeat-expr: range_count
    instances:
      entry_size:
        value: '_parent.flags.has_byte_entries ? 1 : 2'
