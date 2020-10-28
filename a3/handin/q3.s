# int  a;
# int* p;
# int  b[5];

.pos 0x100
    # a = 3;
    ld $3, r0           # r0 = 3
    ld $a, r1           # r1 = address of a
    st r0, (r1)         # a = 3

    # p = &a;
    ld $a, r0           # r0 = address of a
    ld $p, r1           # r1 = address of p
    st r0, (r1)         # p = &a

    # *p = *p - 1;
    ld (r0), r1         # r1 = a = *p
    dec r1              # r1 = *p - 1
    st r1, (r0)         # *p = *p - 1 (aka a = a-1)

    # p = &b[0];
    ld $b, r0           # r0 = address of b[0]
    ld $p, r1           # r1 = address of p
    st r0, (r1)         # p = &b[0]

    # p++;
    ld $b, r0           # r0 = address of b[0]
    inca r0             # r0 = b[1]
    ld $p, r1           # r1 = address of p
    st r0, (r1)         # p = p++ (b[1])

    # p[a] = b[a];     
    ld $b, r0           # r0 = address of b[0]
    ld $a, r1           # r1 = address 0f a
    ld (r1), r2         # r2 = a
    ld (r0, r2, 4), r3  # r3 = b[a]
    ld $p, r0           # r0 = address of p
    ld (r0), r0         # r0 = p
    st r3, (r0, r2, 4)  # p[a] = b[a]

    # *(p+3) = b[0];    
    ld $b, r0           # r0 = address of b[0]
    ld (r0), r1         # r1 = b[0]
    ld $p, r0           # r0 = address of p
    ld $12, r2          # r2 = 12, because we are doing pointer arithmetic
    ld (r0), r3         # r3 = p
    add r2, r3          # r3 = p + 12
    st r1, (r3)         # *(p+3) = b[0]
    
    halt


.pos 0x2000
a:      .long 0     #a
p:      .long 0     #p
b:      .long 0     #b[0]
        .long 0     #b[1]
        .long 0     #b[2]
        .long 0     #b[3]
        .long 0     #b[4]