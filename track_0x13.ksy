meta:
  id: track_0x13
  endian: le
  bit-endian: le

# TRACKINSTANCE
doc: |
  #### Example
  ```
  TRACKINSTANCE
    TAG "TK0306MDUMMY01_TRACK"
    DEFINITION "TK0306MDUMMY01_TRACKDEF"
  ENDTRACKINSTANCE
  ```

seq:
  # TAG
  - id: name_reference
    type: s4
  - id: track_reference
    type: u4
  - id: flags
    type: track_flags
  - id: sleep
    type: u4
    if: flags.sleep

types:
  track_flags:
    seq:
      - id: sleep
        type: b1
      - id: reverse
        type: b1
      - id: interpolate
        type: b1
      - id: padding
        type: b29

# instances:
#   name:
#     type: string_hash_reference(name_reference)

