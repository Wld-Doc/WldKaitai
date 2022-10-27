meta:
  id: track_def_0x12
  endian: le
  bit-endian: le

# TRACKDEFINITION
doc: |
  #### Example
  ```
  TRACKDEFINITION
    TAG "TK0306MDUMMY01_TRACKDEF"
    NUMFRAMES 1
    FRAMETRANSFORM 1.000000 0 0 0 0.000000 0.000000 0.000000
  ENDTRACKDEFINITION
  ```

seq:
  # TAG
  - id: name_reference
    type: s4
  # unk
  - id: flags
    type: u4
  # NUMFRAMES %d
  - id: frame_count
    type: u4
  - id: frames
    type: frame_transform
    repeat: expr
    repeat-expr: frame_count
    # TODO: handle fields added by flags
types:
  frame_transform:
    seq:
      - id: rotate_denominator
        type: f4
      - id: rotate_x_numerator
        type: f4
      - id: rotate_y_numerator
        type: f4
      - id: rotate_z_numerator
        type: f4
      - id: shift_x_numerator
        type: f4
      - id: shift_y_numerator
        type: f4
      - id: shift_z_numerator
        type: f4
      - id: shift_denominator
        type: f4

# instances:
#   name:
#     type: string_hash_reference(name_reference)
