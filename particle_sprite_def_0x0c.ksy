meta:
  id: particle_sprite_def_0x0c
  endian: le
  bit-endian: le
  imports:
    - wld_common

# PARTICLESPRITEDEF

doc: |
  #### Example
  ```
  PARTICLESPRITEDEF
    PARTICLESPRITETAG COLLDISP_PARTICLESPRITEDEF
    // CENTEROFFSET 3.0 4.0 5.0
    // LARGEDOTS ON
    NUMVERTICES  1
    XYZPEN  0.000000  0.000000  1.000000  79
    RENDERMETHOD USERDEFINED 9
    RENDERINFO
      BRIGHTNESS 1.0
    ENDRENDERINFO
    // BOUNDINGRADIUS 0.500000
  ENDPARTICLESPRITEDEF
  ```

seq:
  - id: name_reference
    type: s4
  - id: flags
    type: particle_sprite_flags
  - id: num_vertices
    type: u4
  - id: unk
    type: u4
  - id: center_offset
    type: center_offset
    if: flags.has_center_offset
  - id: bounding_radius
    type: f4
    if: flags.has_bounding_radius
  - id: vertices
    type: wld_common::xyz
    repeat: expr
    repeat-expr: num_vertices
  - id: render_method
    type: wld_common::render_method_attrs
  - id: render_info
    type: wld_common::render_info
  - id: pen
    type: u1
    repeat: expr
    repeat-expr:  num_vertices
types:
  particle_sprite_flags:
    seq:
      - id: has_center_offset
        type: b1
      - id: has_bounding_radius
        type: b1
      # large_dots? I dont think LARGEDOTS ON gets stored here.
      - id: tmp
        type: b30

  # CENTEROFFSET 1.0 2.0 3.0
  center_offset:
    seq:
      - id: x
        type: f4
      - id: y
        type: f4
      - id: z
        type: f4
