                                        # int t;
                                        # int array[2];

                                        # void swap() {
                                        # t = array[0];
                                        # array[0] = array[1];
                                        # array[1] = t;
                                        # }

.pos 0x100                              # for information that does not result in machine code
                ld $array, r0           # r0 = address of array[0]
                ld (r0), r1             # r1 = array[0]
                ld $0x1, r2             # r2 = 1
                ld (r0, r2, 4), r3      # r3 = array[1]
                st r1, (r0, r2, 4)      # array[1] = array[0]
                st r3, (r0)             # array[0] = array[1]
                halt
.pos 0x1000
array:          .long 0x2               # array[0]
                .long 0xffffffff        # array[1]