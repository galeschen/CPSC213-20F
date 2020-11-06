# int i   = -1;
# int n   = 5;
# int a[] = (int[]) {10, 20, 30, 40, 50};
# int b[] = (int[]) {11, 20, 28, 44, 48}
# int c   = 0;

# for (i = 0; i<n; i++)
#  if (a[i] > b[i])
#    c += 1;

# instructions
.pos 0x100
	ld $i, r0	    # r0 = address of i
	ld $0, r1           # r1 = 0
        st r1, (r0)         # i = 0
        ld $a, r2           # r2 = address of a
        ld $c, r3           # r3 = address of c
        ld $n, r4           # r4 = address of n
        ld (r4), r4         # r4 = n 
        ld $b, r5           # r5 = address of b

loop:   ld (r0), r1         # r1 = i
        ld (r2, r1, 4), r6  # r6 = a[i]
        ld (r5, r1, 4), r7  # r7 = b[i]
        not r7
        inc r7              # r7 = -b[i]
        add r6, r7          # r7 = a[i] - b[i]
        bgt r7, then        # if a[i] - b[i] > 0, jump to then
        j else

then:   ld (r3), r7         # r7 = value of c
        inc r7              # r7 = c + 1
        st r7, (r3)         # c += 1

else:   inc r1              # r1 = i + 1
        st r1, (r0)         # i = i + 1
        not r1
        inc r1              # r1 = -i
        add r4, r1          # r1 = n - i
        bgt r1, loop        # if n > i, jump to loop
        halt



# global variables
.pos 0x1000
    i:  .long   -1
    n:  .long   5
    a:  .long   10
        .long   20
        .long   30
        .long   40
        .long   50
    b:  .long   11
        .long   20
        .long   28
        .long   44
        .long   48
    c:  .long   0
