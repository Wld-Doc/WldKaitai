meta:
  id: sphere_0x16
  endian: le
  bit-endian: le

# SPHERE

# Subfragment
# ACTORINST
# ...
# SPHERE 0.100000
# ...
# ENDACTORINST

seq:
  # Not sure about this field.
  - id: name_reference
    type: s4
  - id: radius
    type: f4
