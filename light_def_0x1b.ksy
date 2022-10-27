meta:
  id: light_def_0x1b
  endian: le
  bit-endian: le

doc: |
  #### Example
  ```
  LIGHTDEFINITION
    TAG "FX_BLUE"
    NUMFRAMES 1
    LIGHTLEVELS 0.800000
    SLEEP 30000
    COLOR  0.000000 0.000000 1.000000
  ENDLIGHTDEFINITION
  ```

seq:
  - id: name_reference
    type: s4
  - id: flags
    type: light_flags
  # NUMFRAMES
  - id: frame_count
    type: u4
  # CURRENTFRAME %d
  - id: current_frame
    type: u4
    if: flags.has_current_frame
  # SLEEP %d
  - id: sleep
    type: u4
    if: flags.has_sleep
  # LIGHTLEVELS %f
  - id: light_levels
    type: f4
    repeat: expr
    repeat-expr: frame_count
    if: flags.has_light_levels
  # COLOR  %f %f %f
  - id: colors
    type: color_rgb
    repeat: expr
    repeat-expr: frame_count
    if: flags.has_color and frame_count != 0

types:
  color_rgb:
    seq:
      - id: red
        type: f4
      - id: green
        type: f4
      - id: blue
        type: f4
  light_flags:
    seq:
      - id: has_current_frame
        type: b1
      - id: has_sleep
        type: b1
      - id: has_light_levels
        type: b1
      # SKIPFRAMES ON
      - id: skip_frames
        type: b1
      - id: has_color
        type: b1
      - id: padding
        type: b27

# instances:
#   name:
#     type: string_hash_reference(name_reference)

