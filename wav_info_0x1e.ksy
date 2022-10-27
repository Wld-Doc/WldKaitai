meta:
  id: wav_info_0x1e
  endian: le
  bit-endian: le
  imports:
    - wld_common

seq:
  - id: name_reference
    type: s4
  - id: filename_length
    type: u2
  - id: filename
    type: wld_common::xor_string(filename_length, 0)
