meta:
  id: dm_sprite_def2_0x36
  endian: le
  bit-endian: le

seq:
  - id: name_reference
    type: s4
  - id: flags
    type: u4
  - id: material_list_reference
    type: u4
  - id: mesh_animation_reference
    type: u4
  - id: unk1
    type: u4
  # points to bminfo?
  - id: unk2
    type: s4

  - id: center
    type: vec3

  - id: unk3
    type: u4
  - id: unk4
    type: u4
  - id: unk5
    type: u4

  - id: max_distance
    type: f4

  - id: min_position
    type: vec3
  - id: max_position
    type: vec3

  - id: vertex_count
    type: u2
  - id: texture_coordinate_count
    type: u2
  - id: normals_count
    type: u2
  - id: colors_count
    type: u2
  - id: polygon_count
    type: u2
  - id: vertex_piece_count
    type: u2
  - id: polygon_texture_count
    type: u2
  - id: vertex_texture_count
    type: u2

  - id: size9
    type: u2
  - id: raw_scale
    type: u2
  - id: vertices
    type: vertex
    repeat: expr
    repeat-expr: vertex_count
  - id: texture_coordinates
    type: texture_coordinate
    repeat: expr
    repeat-expr: texture_coordinate_count

instances:
  # name:
  #   type: string_hash_reference(name_reference)
  scale:
    value: 1.0 / (1 << raw_scale)
types:
  vec3:
    seq:
      - id: x
        type: f4
      - id: y
        type: f4
      - id: z
        type: f4
  vertex:
    seq:
      - id: raw_x
        type: s4
      - id: raw_y
        type: s4
      - id: raw_z
        type: s4
    instances:
      x:
        value: raw_x * _parent.scale
      y:
        value: raw_y * _parent.scale
      z:
        value: raw_z * _parent.scale
  texture_coordinate:
    # TODO: fix for old/new wld versions
    seq:
      - id: u
        type: s4
      - id: v
        type: s4
