meta:
  id: four_d_sprite_def_0x0a
  endian: le
  bit-endian: le

# 4DSPRITEDEF
doc: |
  #### Example
  ```
  4DSPRITEDEF
    4DSPRITETAG "PIZZA_4DDEF"
    NUMFRAMES 2
    SIMPLESPRITE "SPRITE01"
    SIMPLESPRITE "SPRITE02"
    CURRENTFRAME 2
    SLEEP 4
    SKIPFRAMES ON
    CENTEROFFSET 1.1 1.2 1.3
    SPHERE 0.1
    BOUNDINGRADIUS 0.13
  END4DSPRITEDEF
  ```

seq:
  - id: name_reference
    type: s4
    doc: |
      The name of this sprite
  - id: flags
    type: sprite_flags
  - id: num_frames
    doc: |
      The number of frames present in each heading
    type: u4
  - id: sphere_fragment
    type: s4
    doc: |
      When SPHERE or SPHERELIST is defined this references a 0x16 fragment.
      When POLYHEDRON is defined this references a 0x16 fragment.
  - id: center_offset_x
    type: f4
    if: flags.has_center_offset
  - id: center_offset_y
    type: f4
    if: flags.has_center_offset
  - id: center_offset_z
    type: f4
    if: flags.has_center_offset
  - id: bounding_radius
    type: f4
    if: flags.has_bounding_radius
  - id: current_frame
    type: u4
    if: flags.has_current_frame
  - id: sleep
    type: s4
    if: flags.has_sleep
  - id: sprite_fragments
    type: u4
    if: flags.has_sprites
    repeat: expr
    repeat-expr: num_frames

types:
  sprite_flags:
    seq:
      - id: has_center_offset
        type: b1
      - id: has_bounding_radius
        type: b1
      - id: has_current_frame
        type: b1
      - id: has_sleep
        type: b1
      - id: has_sprites
        type: b1
      - id: flag05
        type: b1
      - id: skip_frames
        type: b1
      - id: unk
        type: b25

# instances:
#   name:
#     type: string_hash_reference(name_reference)
