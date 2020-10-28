# int  a[3];
# int  s[5];
# int  tos;
# int  tmp;

.pos 0x100
    # tmp = 0;
    ld $tmp, r0         # ro = address of tmp
    ld $0x0, r1         # r1 = 0
    st r1, (r0)         # tmp = 0

    # tos = 0;
    ld $tos, r0         # r0 = address of tos
    st r1, (r0)         # tos = 0

    # s[tos] = a[0];
    ld $a, r0           # r0 = address of a[0]
    ld $s, r1           # r1 = address of s[0]
    ld (r0), r2         # r2 = a[0]
    ld $tos, r0         # r0 = address of tos
    ld (r0), r3         # r3 = tos
    st r2, (r1, r3, 4)  # s[tos] = a[0]

    # tos++;
    inc r3              # r3 = tos + 1
    st r3, (r0)         # tos = tos + 1

    # s[tos] = a[1];
    ld $a, r0           # r0 = address of a[0]
    ld 4(r0), r1        # r1 = a[1]
    ld $tos, r0         # r0 = address of tos
    ld (r0), r2         # r2 = tos
    ld $s, r3           # r3 = address of s[0]
    st r1, (r3, r2, 4)  # s[tos] = a[1]

    # tos++;
    ld $tos, r0         # r0 = address of tos
    ld (r0), r1         # r1 = tos
    inc r1              # r1 = tos++
    st r1, (r0)         # tos = tos++

    # s[tos] = a[2];
    ld $a, r0           # r0 = address of a
    ld 8(r0), r1        # r1 = a[2]
    ld $s, r0           # r0 = address of s[0]
    ld $tos, r2         # r2 = address of tos
    ld (r2), r3         # r3 = tos
    st r1, (r0, r3, 4)  # s[tos] = a[2]

    # tos++;
    ld $tos, r0         # r0 = address of tos
    ld (r0), r1         # r1 = tos
    inc r1              # r1 = tos++
    st r1, (r0)         # tos = tos++

    # tos--;
    ld $tos, r0         # r0 = address of tos
    ld (r0), r1         # r1 = tos
    dec r1              # r1 = tos--
    st r1, (r0)         # tos = tos--

    # tmp = s[tos];
    ld $tos, r0         # r0 = address of tos
    ld (r0), r1         # r1 = tos
    ld $s, r0           # r0 = address of s[0]
    ld (r0, r1, 4), r2  # r2 = s[tos]
    ld $tmp, r0         # r0 = address of tmp
    st r2, (r0)         # tmp = s[tos]

    # tos--;
    ld $tos, r0         # r0 = address of tos
    ld (r0), r1         # r1 = tos
    dec r1              # r1 = tos--
    st r1, (r0)         # tos = tos--

    # tmp = tmp + s[tos];
    ld $tos, r0         # r0 = address of tos
    ld (r0), r1         # r1 = tos
    ld $s, r0           # r0 = address of s[0]
    ld (r0, r1, 4), r2  # r2 = s[tos]
    ld $tmp, r0         # r0 = address of tmp
    ld (r0), r1         # r1 = tmp
    add r1, r2          # r2 = tmp + s[tos]
    st r2, (r0)         # tmp = tmp + s[tos]

    # tos--;
    ld $tos, r0         # r0 = address of tos
    ld (r0), r1         # r1 = tos
    dec r1              # r1 = tos--
    st r1, (r0)         # tos = tos--

    # tmp = tmp + s[tos];
    ld $tos, r0         # r0 = address of tos
    ld (r0), r1         # r1 = tos
    ld $s, r0           # r0 = address of s[0]
    ld (r0, r1, 4), r2  # r2 = s[tos]
    ld $tmp, r0         # r0 = address of tmp
    ld (r0), r1         # r1 = tmp
    add r1, r2          # r2 = tmp + s[tos]
    st r2, (r0)         # tmp = tmp + s[tos]

    halt

.pos 0x200
# data area
tos:    .long 0         # tos
tmp:    .long 0         # tmp
a:      .long 0         # a[0]
        .long 0         # a[1]
        .long 0         # a[2]
s:      .long 0         # s[0]
        .long 0         # s[1]
        .long 0         # s[2]
        .long 0         # s[3]
        .long 0         # s[4]