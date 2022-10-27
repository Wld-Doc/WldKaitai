meta:
  id: point_light_0x28
  endian: le
  bit-endian: le

# POINTLIGHT

seq:
  # TAG
  - id: name_reference
    type: s4
  - id: light_reference
    type: s4

  # bit 5 => STATIC
  # bit 6 => STATICINFLUENCE
  # bit 7 => NUMREGIONS and REGIONS
  - id: flags
    type: point_light_flags

  # XYZ %f, %f, %f
  - id: x
    type: f4
  - id: y
    type: f4
  - id: z
    type: f4

  # RADIUSOFINFLUENCE
  - id: radius
    type: f4

  # NUMREGIONS %d
  # - id: region_count
  #   type: u4
  #   if: flags.has_regions

  # REGIONS %d
  # values are offset by 1
  # REGIONS 0, 3, 5
  # becomes -1, 2, 4
  # - id: regions
  #   type: s4
  #   repeat: expr
  #   repeat-expr: region_count
  #   if: flags.has_regions

types:
  point_light_flags:
    seq:
      - id: padding
        type: b6
      - id: is_static
        type: b1
      - id: static_influence
        type: b1
      - id: has_regions
        type: b1
      - id: unk
        type: b23

# instances:
#   name:
#     type: string_hash_reference(name_reference)
#     if: name_reference != 0

