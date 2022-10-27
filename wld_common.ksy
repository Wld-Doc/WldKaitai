meta:
  id: wld_common
  endian: le
  bit-endian: le
  imports:
    - simple_sprite_0x05

types:

  normal_abcd:
    seq:
      - id: a
        type: f4
      - id: b
        type: f4
      - id: c
        type: f4
      - id: d
        type: f4

  render_info:
    seq:
      - id: flags
        type: render_flags
      - id: pen
        type: s4
        if: flags.has_pen
      - id: brightness
        type: f4
        if: flags.has_brightness
      - id: scaled_ambient
        type: f4
        if: flags.has_scaled_ambient
      - id: simple_sprite
        type: simple_sprite_0x05
        if: flags.has_simple_sprite
      - id: uv_info
        type: uv_info
        if: flags.has_uv_info
      - id: uv_map
        type: uv_map
        if: flags.has_uv_map

    types:
      render_flags:
        seq:
          - id: has_pen
            type: b1
          - id: has_brightness
            type: b1
          - id: has_scaled_ambient
            type: b1
          - id: has_simple_sprite
            type: b1
          - id: has_uv_info
            type: b1
          - id: has_uv_map
            type: b1
          - id: is_two_sided
            type: b1
          - id: padding
            type: b25

      uv_info:
        seq:
          - id: uv_origin_x
            type: f4
          - id: uv_origin_y
            type: f4
          - id: uv_origin_z
            type: f4
          - id: u_axis_x
            type: f4
          - id: u_axis_y
            type: f4
          - id: u_axis_z
            type: f4
          - id: v_axis_x
            type: f4
          - id: v_axis_y
            type: f4
          - id: v_axis_z
            type: f4

      uv_map:
        seq:
          - id: entry_count
            type: u4
          - id: entries
            type: uv_entry
            repeat: expr
            repeat-expr: entry_count

        types:
          uv_entry:
            seq:
              - id: v
                type: f4
              - id: u
                type: f4

  render_method_attrs:
    seq:
      - id: draw_style
        type: b2
        enum: draw_style
      - id: lighting
        type: b3
        enum: lighting
      - id: shading
        type: b2
        enum: shading
      - id: texture_style
        type: b4
        enum: texture_style
      - id: unused1
        doc: These bits cause WLDCOM.EXE to crash when decompiling if set
        type: b5
      - id: unused2
        type: b15
      - id: user_defined
        type: b1
    enums:
      draw_style:
        0b00: transparent
        0b01: unknown
        0b10: wireframe
        0b11: solid
      lighting:
        0b000: zero_intensity
        0b001: unknown1
        0b010: constant
        0b011: xxxxx
        0b100: ambient
        0b101: scaled_ambient
        0b111: invalid
      shading:
        0b00: none1
        0b01: none2
        0b10: gouraud1
        0b11: gouraud2
      texture_style:
        0b0001: xxxxxxxx
        0b0010: texture1
        0b0011: transtexture1
        0b0100: texture2
        0b0101: transtexture2
        0b0110: texture3
        0b0111: xxxxxxxx
        0b1000: texture4
        0b1001: transtexture4
        0b1010: texture5
        0b1011: transtexture5
        0b1100: unknown1
        0b1101: unknown2
        0b1110: unknown3
        0b1111: xxxxx

  sphere:
    seq:
      - id: f1
        type: f4
      - id: f2
        type: f4
      - id: f3
        type: f4
      - id: f4
        type: f4

  xor_string:
    params:
      - id: length
        type: u2
      - id: count
        type: u2
    seq:
      - id: decoded
        size: length
        # wasn't able to get the key stored as a value instance
        process: xor([0x95, 0x3A, 0xC5, 0x2A, 0x95, 0x7A, 0x95, 0x6A])
        type: decoded_string_raw(count)
    types:
      decoded_string_raw:
        params:
          - id: repeats
            type: u2
        seq:
          - id: strings
            type: strz
            encoding: ASCII
            repeat: expr
            repeat-expr: repeats + 1
        instances:
          raw:
            pos: 0
            type: str
            encoding: ASCII
            size-eos: true

  xyz:
    seq:
      - id: x
        type: f4
      - id: y
        type: f4
      - id: z
        type: f4
