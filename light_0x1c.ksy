meta:
  id: light_0x1c
  endian: le
  bit-endian: le

# LIGHT "L1_LDEF"

seq:
  - id: name_reference
    type: s4
  - id: light_def_reference
    type: u4
  - id: flags
    type: u4

# instances:
#   name:
#     type: string_hash_reference(name_reference)
