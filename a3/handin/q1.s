# int  i,j;
# int* p;
# int  a[10];

.pos 0x100
    # i  = a[3];
    ld $a, r0           # r0 = address of a
    ld 12(r0), r1       # r1 = a[3]
    ld $i, r2           # r2 = address of i
    st r1, (r2)         # i = a[3]

    # i  = a[i];
    ld (r2), r1         # r1 = i
    ld (r0, r1, 4), r1  # r1 = a[i]
    st r1, (r2)         # i = a[i]

    # p  = &j;
    ld $j, r0           # r0 = address of j
    ld $p, r1           # r1 = address of p
    st r0, (r1)         # p = &j

    # *p = 4;
    ld $0x4, r1          # r1 = 4
    st r1, (r0)          # j = 4 (where j = *p)

    # p  = &a[a[2]];
    ld $a, r0           # r0 = address of a
    ld 8(r0), r2        # r2 = value of a[2]
    shl $2, r2          # r2 = a[2] * 4
    add r0, r2          # r2 = address of a[a[2]]
    ld $p, r0           # r0 = address of p
    st r2, (r0)         # p = &a[a[2]]

    # *p = *p + a[4];
    ld $a, r0           # r0 = address of a[0]
    ld 16(r0), r1       # r1 = a[4]
    ld $p, r2           # r2 = address of p
    ld (r2), r3         # r3 = p = address of a[a[2]]
    ld (r3), r4         # r4 = *p
    add r1, r4          # r1 = *p + a[4]
    st r4, (r3)         # *p = *p + a[4]

    halt



.pos 0x200
# data area
i:  .long 0         # i
j:  .long 0         # j
p:  .long 0         # p
a:  .long 0         # a[0]
    .long 0         # a[1]
    .long 0         # a[2]
    .long 0         # a[3]
    .long 0         # a[4]
    .long 0         # a[5]
    .long 0         # a[6]
    .long 0         # a[7]
    .long 0         # a[8]
    .long 0         # a[9]