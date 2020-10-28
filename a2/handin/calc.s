.pos 0x100
                 ld   $i, r0              # r0 = address of i
                 ld   0x0(r0), r4         # r4 = i
                 ld   $data, r1           # r1 = address of data
                 ld   $y, r2              # r2 = address of y
                 ld   (r1, r4, 4), r3     # r3 = data[i]
                 inc  r4                  # r4 = r4 + 1
                 ld   (r1, r4, 4), r5     # r5 = data[i+1]
                 add  r3, r5              # r5 = data[i] + data[i+1]
                 st   r5, 0x0(r2)         # y = r5
                 ld   $0xff, r0           # r0 = 0xff
                 and  r5, r0              # r0 = r5 & r0
                 ld   $x, r1              # r1 = address of x
                 st   r0, 0x0(r1)         # x = r0
                 halt                     
.pos 0x1000
i:               .long 0x1                # i
.pos 0x2000
x:               .long 0x2                # x
.pos 0x3000
y:               .long 0x3                # y
.pos 0x4000
data:            .long 0x1                # data[0]
                 .long 0x2                # data[1]
                 .long 0x3                # data[2]
                 .long 0x4                # data[3]
