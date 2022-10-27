meta:
  id: sphere_list_def_0x19
  endian: le
  bit-endian: le

doc: |
  #### Example
  ```
  SPHERELISTDEFINITION
    TAG "LSCOL_SPHRLDEF"
    BOUNDINGRADIUS 10.021014
    SCALEFACTOR 1.000000
    NUMSPHERES 2
    SPHERE 6.827923 -3.505810 -0.299793 1.759825
    SPHERE 3.354883 -3.505810 -0.299793 1.759825
  ENDSPHERELISTDEFINITION
  ```

seq:
  - id: name_reference
    type: s4
  - id: flags
    type: sphere_list_flags
  - id: num_spheres
    type: u4
  - id: bounding_radius
    type: f4
  - id: scale_factor
    type: f4
    if: flags.has_scale_factor
  - id: spheres
    type: sphere
    repeat: expr
    repeat-expr: num_spheres

types:
  sphere_list_flags:
    seq:
      - id: has_scale_factor
        type: b1
      - id: padding
        type: b31
  sphere:
    seq:
      # maybe x, y, z, radius?
      - id: unk
        type: f4
        repeat: expr
        repeat-expr: 4
