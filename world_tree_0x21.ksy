meta:
  id: world_tree_0x21
  endian: le
  bit-endian: le
  imports:
    - wld_common

doc: |
  #### Example
  ```
  WORLDTREE
  NUMWORLDNODES 1
    WORLDNODE
      NORMALABCD 0.000000 1.000000 0.000001 76.969200
      WORLDREGIONTAG 0
      FRONTTREE 2
      BACKTREE 626
    ENDWORLDNODE
  ENDWORLDTREE
  ```

seq:
  - id: name_reference
    type: u4

  # NUMWORLDNODES %d
  - id: world_node_count
    type: u4

  # WORLDNODE
  - id: world_nodes
    type: world_node
    repeat: expr
    repeat-expr: world_node_count

types:
  world_node:
    seq:
      # NORMALABCD %f %f %f %f
      - id: normal_abcd
        type: wld_common::normal_abcd

      # WORLDREGIONTAG %d
      - id: region_tag
        type: u4
      # TODO: revisit with more examples and add conditions when region isn't zero

      # FRONTTREE %d
      - id: front_tree
        type: u4
        # if: region_tag == 0

      # BACKTREE %d
      - id: back_tree
        type: u4
        # if: region_tag == 0
