meta:
  id: simple_sprite_def_0x04
  endian: le
  bit-endian: le

# SIMPLESPRITEDEF
doc: |
  #### Example
  ```
  SIMPLESPRITEDEF
    SIMPLESPRITETAG %s
    NUMFRAMES %d
    // repeated NUMFRAMES times
    FRAME "%s" "%s"
    CURRENTFRAME %d
    SLEEP %d
    SKIPFRAMES ON
  ENDSIMPLESPRITEDEF
  ```

seq:
  - id: name_reference
    type: s4

  # bit 2 => CURRENTFRAME %d
  # bit 3 => SLEEP %d
  # bit 3 and 5 => SKIPFRAMES ON
  - id: flags
    type: s4
    # type: b16le

  # NUMFRAMES %d
  - id: frame_count
    type: u4

  # SLEEP %d
  - id: sleep
    type: u4
    if: animated == 1

  # points to 0x03 objects
  - id: frame_references
    type: u4
    repeat: expr
    repeat-expr: frame_count

instances:
  # SIMPLESPRITETAG "%s"
  # name:
  #   type: string_hash_reference(name_reference)
  #   # TODO: should it check if name_reference is 0
  animated:
    value: (flags & 0b1000) >> 3
  skip_frames:
    value: (flags & 0b101000) != 0
