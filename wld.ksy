meta:
  id: wld
  file-extension: wld
  endian: le
  imports:
    - palette_file_0x01
    - file_info_0x03
    - simple_sprite_def_0x04
    - simple_sprite_0x05
    - two_d_sprite_def_0x06
    - particle_sprite_def_0x0c
    - particle_sprite_0x0d
    - track_def_0x12
    - track_0x13
    - sphere_0x16
    - polyhedron_0x18
    - sphere_list_def_0x19
    - sphere_list_0x1a
    - light_def_0x1b
    - light_0x1c
    - wav_info_0x1e
    # - sound_def_0x1f
    - world_tree_0x21
    - region_0x22
    - point_light_0x28
    # - dm_sprite_def2_0x36

seq:
  - id: header
    type: header
    doc: WLD file header
  - id: string_hash
    type: xor_string(header.string_hash_bytes, header.string_count)
  - id: objects
    type: wld_object
    repeat: expr
    repeat-expr: header.object_count
  - id: footer
    contents: [0xff, 0xff, 0xff, 0xff]

# Uncomment to lookup a string reference
# instances:
#   string_lookup_debug:
#     type: string_hash_reference(-1)

types:
  header:
    seq:
      - id: magic
        contents: [0x02, 0x3d, 0x50, 0x54]
      - id: version
        type: u4
      - id: object_count
        type: u4
      - id: region_count
        type: u4
      - id: max_object_bytes
        type: u4
      - id: string_hash_bytes
        type: u4
      - id: string_count
        type: u4

  xor_string:
    params:
      - id: length
        type: u2
      - id: count
        type: u2
    seq:
      - id: decoded
        size: length
        # wasn't able to get the key stored as a value instance
        process: xor([0x95, 0x3A, 0xC5, 0x2A, 0x95, 0x7A, 0x95, 0x6A])
        type: decoded_string_raw(count)
    types:
      decoded_string_raw:
        params:
          - id: repeats
            type: u2
        seq:
          - id: strings
            type: strz
            encoding: ASCII
            repeat: expr
            repeat-expr: repeats + 1
        instances:
          raw:
            pos: 0
            type: str
            encoding: ASCII
            size-eos: true

  string_hash_reference:
    doc: Decode and return the string at `position` in the `string_hash`
    params:
      - id: position
        type: u2
    instances:
      string:
        io: _root.string_hash.decoded._io
        pos: position * -1
        type: strz
        encoding: ASCII

  wld_object:
    -webide-representation: '{object_type} - {length:dec}b'
    seq:
      - id: length
        type: u4
      - id: object_type
        type: u4
      - id: body
        size: length
        type:
          switch-on: object_type
          cases:
            0x01: palette_file_0x01 # DEFAULTPALETTEFILE
            # 0x02: user_data_0x02 # TODO: USERDATA
            0x03: file_info_0x03 # FRAME and BMINFO
            0x04: simple_sprite_def_0x04 # SIMPLESPRITEDEF
            0x05: simple_sprite_0x05 # SIMPLESPRITEINST
            0x06: two_d_sprite_def_0x06 # 2DSPRITEDEF
            # 0x07: two_d_sprite_0x07 # TODO: 2DSPRITE
            # 0x08: three_d_sprite_def_0x08 # TODO: 3DSPRITEDEF
            # 0x09: three_d_sprite_0x09 # TODO: 3DSPRITE
            # 0x0a: four_d_sprite_def_0x0a # TODO: 4DSPRITEDEF
            # 0x0b: four_d_sprite_0x0b # TODO: 4DSPRITE ?
            0x0c: particle_sprite_def_0x0c # PARTICLESPRITEDEF
            0x0d: particle_sprite_0x0d # PARTICLESPRITETAG
            # 0x0e: composite_sprite_def_0x0e # TODO: COMPOSITESPRITEDEF
            # 0x0f: composite_sprite_0x0f # TODO: COMPOSITESPRITE
            # 0x10 hierarchical_sprite_def_0x10 # TODO: HIERARCHICALSPRITEDEF
            # 0x11 hierarchical_sprite_0x11 # TODO: HIERARCHICALSPRITE
            0x12: track_def_0x12 # TRACKDEFINITION
            0x13: track_0x13 # TRACKINSTANCE
            # 0x14: actor_def_0x14 # TODO: ACTORDEF
            # 0x15: actor_0x15 # TODO: ACTORINST
            0x16: sphere_0x16 # SPHERE
            # 0x17: polyhedron_def_0x17 # TODO: POLYHEDRONDEFINITION
            0x18: polyhedron_0x18 # POLYHEDRON
            0x19: sphere_list_def_0x19 # SPHERELISTDEFINITION
            0x1a: sphere_list_0x1a # SPHERELIST
            0x1b: light_def_0x1b # LIGHTDEFINITION
            0x1c: light_0x1c # LIGHT
            # 0x1d: point_light_0x1d # TODO: POINTLIGHT
            0x1e: wav_info_0x1e
            # 0x1f: sound_def_0x1f # TODO: SOUNDDEFINITION
            # 0x20: sound_0x20 # TODO: SOUNDINSTANCE
            0x21: world_tree_0x21 # WORLDTREE
            0x22: region_0x22 # REGION
            # 0x23: active_geometry_region_0x23 # TODO: ACTIVEGEOMETRYREGION
            # 0x24: sky_region_0x24 # TODO: SKYREGION
            # 0x25: directional_light_0x25 # TODO: DIRECTIONALLIGHT
            # 0x26 blit_sprite_def_0x26 # TODO: BLITSPRITEDEFINITION
            # 0x27 blit_sprite_0x27 # TODO: BLITSPRITE
            0x28: point_light_0x28 # POINTLIGHT
            # 0x29: zone_0x29 # TODO: ZONE
            # 0x2a: ambient_light_0x2a # TODO: AMBIENTLIGHT
            # 0x2b: directional_light_0x2b # TODO: DIRECTIONALLIGHT
            # 0x36: dm_sprite_def2_0x36 # TODO: DMSPRITEDEF2

            _: object_type_unknown
    instances:
      name:
        type:
          switch-on: object_type
          cases:
            0x03: string_hash_reference(body.as<file_info_0x03>.name_reference)
            0x04: string_hash_reference(body.as<simple_sprite_def_0x04>.name_reference)
            0x06: string_hash_reference(body.as<two_d_sprite_def_0x06>.name_reference)
            0x0c: string_hash_reference(body.as<particle_sprite_def_0x0c>.name_reference)
            0x0d: string_hash_reference(body.as<particle_sprite_0x0d>.name_reference)
            0x12: string_hash_reference(body.as<track_def_0x12>.name_reference)
            0x13: string_hash_reference(body.as<track_0x13>.name_reference)
            # 0x16: string_hash_reference(body.as<sphere_0x16>.name_reference)
            0x18: string_hash_reference(body.as<polyhedron_0x18>.name_reference)
            0x19: string_hash_reference(body.as<sphere_list_def_0x19>.name_reference)
            0x1a: string_hash_reference(body.as<sphere_list_0x1a>.name_reference)
            0x1b: string_hash_reference(body.as<light_def_0x1b>.name_reference)
            0x1e: string_hash_reference(body.as<wav_info_0x1e>.name_reference)
            0x21: string_hash_reference(body.as<world_tree_0x21>.name_reference)
            0x22: string_hash_reference(body.as<region_0x22>.name_reference)
            0x28: string_hash_reference(body.as<point_light_0x28>.name_reference)

  object_type_unknown: { }
