meta:
  id: palette_file_0x01
  endian: le
  bit-endian: le
  imports:
    - wld_common

# DEFAULTPALETTEFILE "palette.bmp"

seq:
  - id: filename_length
    type: u2
  - id: filename
    type: wld_common::xor_string(filename_length, 0)
