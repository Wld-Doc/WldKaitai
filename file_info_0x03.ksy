meta:
  id: file_info_0x03
  endian: le
  bit-endian: le
  imports:
    - wld_common

# FRAME and BMINFO
# FRAME "filename" "name"
seq:
  - id: name_reference
    type: s4
  - id: size1
    type: u4
  - id: filenames_length
    type: u2
  - id: filenames
    type: wld_common::xor_string(filenames_length, size1)
instances:
  # name:
  #   type: wld::string_hash_reference(name_reference)
  filename:
    value: filenames.decoded.strings.first
