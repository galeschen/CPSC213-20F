.pos 0x1000
code:
# v0 = s.x[i]; 1
ld $v0, r0                  # r0 = address of v0
ld $s, r1                   # r1 = address of s
ld $i, r2                   # r2 = address of i
ld (r2), r2                 # r2 = i
ld (r1, r2, 4), r3          # r3 = s.x[i]
st r3, (r0)                 # v0 = s.x[i]

# v1 = s.y[i]; 2
ld $v1, r0                  # r0 = address of v1
ld 8(r1), r1                # r1 = address of s.y[0]
ld (r1, r2, 4), r4          # r4 = s.y[i]
st r4, (r0)                 # v1 = s.y[i]

# v2 = s.z->x[i]; 2
ld $v2, r0                  # r0 = address of v2
ld $s, r1                   # r1 = address of s
ld 12(r1), r5               # r5 = address of s.z->x[0]
ld (r5, r2, 4), r6          # r6 = s.z->x[i]
st r6, (r0)                 # v2 = s.z->x[i] 

# v3 = s.z->z->y[i]; 4
ld $v3, r0                  # r0 = address of v3
ld 12(r5), r5               # r5 = address of s.z->z->x[0]
ld 8(r5), r5                # r5 = address of s.z->z->y[0]
ld (r5, r2, 4), r6          # r6 = s.z->z->y[i]
st r6, (r0)                 # v3 = s.z->z->y[i]

halt



.pos 0x2000
static:
i:          .long 0
v0:         .long 0
v1:         .long 0
v2:         .long 0
v3:         .long 0
s:          .long 0         # s->x[0]
            .long 0         # s->x[1]
            .long s_y       # s->y
            .long s_z       # s->z


.pos 0x3000
heap:
s_y:        .long 0         # s.y[0]
            .long 0         # s.y[1] 

s_z:        .long 0         # s.z->x[0] 
            .long 0         # s.z->x[1] 
            .long 0         # s.z->y 
            .long s_z_z     # s.z->z 

s_z_z:      .long 0         # s.z.z->x[0] 
            .long 0         # s.z.z->x[1] 
            .long s_z_z_y   # s.z.z.y
            .long 0         # s.z.z->z 

s_z_z_y:    .long 0         # s.z.z.y[0]
            .long 0         # s.z.z.y[1] 