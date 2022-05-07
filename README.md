# 32b-SC-MIPS
32-bit Single Cycle MIPS Processor (Computer Architecture Course)

## Instruction Set

* ### R-Type
    | inst [31:26] | inst [25:21] | inst [20-16] | inst [15:11] | inst [5:0] |
    | :----------: | :----------: | :----------: | :----------: | :--------: |
    |    000000    | #Register-A  | #Register-B  | #Register-D  |  Function  |

    | Function |  Code  |
    | :------: | :----: |
    |   add    | 000001 |
    |   sub    | 000010 |
    |   and    | 000100 |
    |    or    | 001000 |
    |   slt    | 010000 |

* ### addi
    | inst [31:26] | inst [25:21] | inst [20-16] | inst [15:0] |
    | :----------: | :----------: | :----------: | :---------: |
    |    000001    | #Register-A  | #Register-D  |  Immediate  |

* ### slti
    | inst [31:26] | inst [25:21] | inst [20-16] | inst [15:0] |
    | :----------: | :----------: | :----------: | :---------: |
    |    000010    | #Register-A  | #Register-D  |  Immediate  |

* ### lw
    | inst [31:26] | inst [25:21] | inst [20-16] | inst [15:0] |
    | :----------: | :----------: | :----------: | :---------: |
    |    000011    | #Register-A  | #Register-D  |   Offset    |

* ### sw
    | inst [31:26] | inst [25:21] | inst [20-16] | inst [15:0] |
    | :----------: | :----------: | :----------: | :---------: |
    |    000100    | #Register-A  | #Register-B  |   Offset    |

* ### beq
    | inst [31:26] | inst [25:21] | inst [20-16] | inst [15:0] |
    | :----------: | :----------: | :----------: | :---------: |
    |    000101    | #Register-A  | #Register-B  |   Offset    |

* ### jump
    | inst [31:26] | inst [25:0] |
    | :----------: | :---------: |
    |    000110    |  Address/4  |

* ### jr
    | inst [31:26] | inst [25:21] |
    | :----------: | :----------: |
    |    000111    | #Register-A  |

* ### jal
    | inst [31:26] | inst [25:0] |
    | :----------: | :---------: |
    |    00100    |  Address/4  |
