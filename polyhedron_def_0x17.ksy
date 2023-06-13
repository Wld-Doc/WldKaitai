meta:
  id: polyhedron_def_0x17
  endian: le
  bit-endian: le
  imports:
    - wld_common

  # POLYHEDRONDEFINITION
  #   TAG "BARREL3_POLYHDEF"
  #   BOUNDINGRADIUS 3.263896
  #   SCALEFACTOR 1.000000
  #   NUMVERTICES 8
  #     XYZ -1.270844 -1.340667 -2.690833
  #     XYZ 1.218169 -1.340667 -2.690833
  #     XYZ -1.270844 1.294759 -2.690833
  #     XYZ 1.218169 1.294759 -2.690833
  #     XYZ -1.270844 -1.340667 2.392483
  #     XYZ 1.218169 -1.340667 2.392483
  #     XYZ -1.270844 1.294759 2.392483
  #     XYZ 1.218169 1.294759 2.392483
  #   NUMFACES 6
  #     FACE
  #       NUMVERTICES 4
  #       VERTEXLIST 4 3 1 2
  #     ENDFACE
  #     FACE
  #       NUMVERTICES 4
  #       VERTEXLIST 8 6 5 7
  #     ENDFACE
  #     FACE
  #       NUMVERTICES 4
  #       VERTEXLIST 6 2 1 5
  #     ENDFACE
  #     FACE
  #       NUMVERTICES 4
  #       VERTEXLIST 8 4 2 6
  #     ENDFACE
  #     FACE
  #       NUMVERTICES 4
  #       VERTEXLIST 7 3 4 8
  #     ENDFACE
  #     FACE
  #       NUMVERTICES 4
  #       VERTEXLIST 5 1 3 7
  #     ENDFACE
  # ENDPOLYHEDRONDEFINITION

seq:
  - id: name_reference
    type: s4
  - id: flags
    type: polyhedron_flags
  - id: num_vertices
    type: u4
  - id: num_faces
    type: u4
  - id: bounding_radius
    type: f4
  - id: scale_factor
    type: f4
    if: flags.has_scale_factor
  - id: vertices
    type: wld_common::xyz
    repeat: expr
    repeat-expr: num_vertices
  - id: faces
    type: face
    repeat: expr
    repeat-expr: num_faces

types:
  face:
    seq:
      - id: num_vertices
        type: u4
      - id: verticies
        type: u4
        repeat: expr
        repeat-expr: num_vertices
      - id: normal_abcd
        type: wld_common::normal_abcd
        if: _parent.flags.has_normal_abcd

  polyhedron_flags:
    seq:
      - id: has_scale_factor
        type: b1
      - id: has_normal_abcd
        type: b1
      - id: unk
        type: b30
