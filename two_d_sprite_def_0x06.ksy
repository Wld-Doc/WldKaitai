meta:
  id: two_d_sprite_def_0x06
  endian: le
  bit-endian: le
  imports:
    - wld_common

# 2DSPRITEDEF
doc: |
  #### Example
  ```
  2DSPRITEDEF
    2DSPRITETAG I_SWORDSPRITE
    CENTEROFFSET 0.0 1.0 0.0
    NUMFRAMES 2
    SLEEP 100
    SPRITESIZE 1.0 1.0
    NUMPITCHES 2
    PITCH 1
      PITCHCAP 512
      NUMHEADINGS 2
      HEADING 1
        HEADINGCAP 64
        FRAME "isword.bmp"  sword11
        FRAME "isword.bmp"  sword11
      ENDHEADING 1
      HEADING 2
        HEADINGCAP 128
        FRAME "isword.bmp" sword21
        FRAME "isword.bmp"  sword11
      ENDHEADING 2
    ENDPITCH 1
    PITCH 2
      PITCHCAP 256
      NUMHEADINGS 1
      HEADING 1
        HEADINGCAP 64
        FRAME "isword.bmp"  sword11
        FRAME "isword.bmp"  sword11
      ENDHEADING 1
    ENDPITCH 2
    // Default instance: render info
    RENDERMETHOD TEXTURE3
    // RENDERINFO block is optional
    RENDERINFO
      //TWOSIDED
      PEN 52
      BRIGHTNESS 1.000
      SCALEDAMBIENT 1.000
      UVORIGIN 0.5 0.4 0.3
      UAXIS 1.0 0.22 0.33 0.44
      VAXIS 1.0 0.25 0.35 0.45
    ENDRENDERINFO
  END2DSPRITEDEF
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
  - id: num_pitches
    type: s4
    doc: |
      The number of pitches
  - id: sprite_size_x
    type: f4
    doc: |
      Scale the sprite by this amount in the x direction?
  - id: sprite_size_y
    type: f4
    doc: |
      Scale the sprite by this amount in the y direction?
  - id: sphere_fragment
    type: s4
    doc: |
      When SPHERE or SPHERELIST is defined this references a 0x16 fragment.
      When POLYHEDRON is defined this references a 0x16 fragment.
  - id: depth_scale
    type: f4
    if: flags.has_depth_scale
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
  - id: pitches
    type: sprite_pitch(num_frames)
    repeat: expr
    repeat-expr: num_pitches
  - id: render_method
    type: wld_common::render_method_attrs
  - id: render_info
    type: wld_common::render_info

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
      - id: flag04
        type: b1
      - id: flag05
        type: b1
      - id: skip_frames
        type: b1
      - id: has_depth_scale
        type: b1
      - id: unk
        type: b24
  sprite_pitch:
    params:
      - id: num_frames
        type: u4
    seq:
      - id: pitch_cap
        type: s4
      - id: num_headings
        type: b31
      - id: top_or_bottom_view
        type: b1
      - id: headings
        type: sprite_heading(num_frames)
        repeat: expr
        repeat-expr: num_headings
  sprite_heading:
    params:
      - id: num_frames
        type: u4
    seq:
      - id: heading_cap
        type: s4
      - id: frames
        type: u4
        repeat: expr
        repeat-expr: num_frames

# instances:
#   name:
#     type: string_hash_reference(name_reference)
