meta:
  id: polyhedron_0x18
  endian: le
  bit-endian: le

# POLYHEDRON
#   DEFINITION "prepe_POLYHDEF"
# ENDPOLYHEDRON

seq:
  - id: name_reference
    type: s4
  - id: definition_reference
    type: s4
  - id: polyhedron_flags
    type: polyhedron_flags
  - id: scale_factor
    type: f4
    if: polyhedron_flags.has_scale_factor

types:
  polyhedron_flags:
    seq:
      - id: has_scale_factor
        type: b1
      - id: unk
        type: b31

# instances:
#   name:
#     type: string_hash_reference(name_reference)
#   definition:
#     type: string_hash_reference(definition_reference)
