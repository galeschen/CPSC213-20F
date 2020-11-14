.pos 0x100
main:            ld   $stackBtm, r5       # r5 = stackptr
                 inca r5                  # sp = address of word after stack
                 gpc  $0x6, r6            # r6 = pc + 6
                 j    copy                # jmp to copy
                 halt                     
.pos 0x200
copy:            deca r5                  # allocate callee part of copy's frame
                 st   r6, 0x0(r5)         # save ra on stack
                 ld   $0xfffffff8, r0     # int dst[2];
                 add  r0, r5              # r5 = &dst[0]
                 mov  r5, r3              # r3 = &dst[0]
                 deca r5                  # r5 = &i (top of frame)
                 ld   $0x0, r0            # r0 = 0 (value of i)
                 st   r0, 0x0(r5)         # i = 0
                 ld   $src, r1            # r1 = &src
copy_loop:       ld   (r1, r0, 4), r2     # r2 = src[i]
                 beq  r2, end_copy        # if src[i] == 0, then end loop
                 st   r2, (r3, r0, 4)     # dst[i] = src[i]
                 inc  r0                  
                 st   r0, 0x0(r5)         # i++
                 j    copy_loop           
end_copy:        ld   $0x0, r3            # r3 = 0
                 st   r3, (r3, r0, 4)     # dst[i] = 0
                 ld   0xc(r5), r6         # r6 = return address
                 ld   $0xc, r0            # r0 = size of callee part of copy's frame
                 add  r0, r5              # deallocate callee part of copy's frame
                 j    0x0(r6)             
.pos 0x2000
src:             .long 0x1                # jump to return address
                 .long 0x1
                 .long 0x2010
                 .long 0x0
                 .long 0x0000ffff     # r0 = -1
                 .long 0xffff0100     # r1 = -1
                 .long 0xffffffff
                 .long 0x0200ffff     # r2 = -1
                 .long 0xffff0300     # r3 = -1
                 .long 0xffffffff
                 .long 0x0400ffff     # r4 = -1
                 .long 0xffff0500     # r5 = -1
                 .long 0xffffffff
                 .long 0x0600ffff     # r6 = -1
                 .long 0xffff0700
                 .long 0xffffffff     # r7 = -1
                 .long 0xf0000000
.pos 0x3000
stackTop:        .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                # i
                 .long 0x0                # dst[0]
                 .long 0x0                # dst[1]
stackBtm:        .long 0x0                # return address
