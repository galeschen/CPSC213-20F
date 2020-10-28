                                    # int a, b;
                                    # void math() {
                                    # a = ((((b + 1) + 4) / 2) & b) << 2;
                                    # }

.pos 0x100
                ld $b, r0           # r0 = address of b
                ld (r0), r1         # r1 = b
                ld (r0), r2         # r2 = b
                inc r1              # r1 = r1 + 1
                inca r1             # r1 = r1 + 4
                shr $0x1, r1        # r1 = r1 >> 1 (r1/2)
                and r1, r2          # r2 = r1 & r2
                shl $0x2, r2        # r2 = r2 << 2
                ld $a, r1           # r1 = address of a
                st r2, (r1)         # a = r2
                halt                #halt


.pos 0x1000
a:               .long 0x1        # a
.pos 0x2000
b:               .long 0x2        # b
