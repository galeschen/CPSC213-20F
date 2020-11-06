.pos 0x0
                # set up (how main begins)
main:           ld   $sb, r5           # stack pointer sp = address of last word of stack
                inca r5                # sp = address of word after stack    
                gpc  $6, r6            # ra = pc + 6             
                j    0x300             # call b
                halt                   
.pos 0x100
#s
ap:             .long 0x00001000      
.pos 0x200
                # normally there would be a callee prologue for foo here:
                # not decrementing stack, so we know there are no local variables
                # no return address either (no st r6, x(r5))
                # whatever is at 0x100, 
foo:            ld   (r5), r0          # r0 = a0
                ld   4(r5), r1         # r1 = a1
                ld   $0x100, r2        # r2 = 0x100               
                ld   (r2), r2          # r2 = 0x1000
                ld   (r2, r1, 4), r3   # r3 = array[a1]
                add  r3, r0            # r0 = array[a1] + a0
                st   r0, (r2, r1, 4)   # array[a1] = array[a1] + a0
                # callee epilogue for foo:
                j    (r6)              # return
.pos 0x300
                # callee prologue for b
                # if you jump to a particular fn position, then you trust that
                # whatever jumped to that instruction will have already set up its parameters
                # allocate stack space for return address and locals
                # save return address to stack
b:              ld   $-12, r0          # r0 = -12 = -(size of callee part of b's frame)
                # two local variables, one ra
                add  r0, r5            # allocate callee part of b's frame
                st   r6, 8(r5)         # store return address to stack
                # r6, x(r5) is a tell tale sign of storing ra to stack.

                ld   $1, r0            # r0 = a0 = 1
                st   r0, (r5)          # l0 = a0
                ld   $2, r0            # r0 = a1 = 2
                st   r0, 4(r5)         # l1 = a1

                # caller prologue for foo
                # things that happen before the gpc jump are setting up the parameters.
                # function that calls another function has to point sp to 
                # point to the parameters of the function
                # it's calling, then set the parameters of the fn
                ld   $-8, r0           # r0 = -8 = -(size of callee part of foo's frame)
                # -8 implies that foo takes in 2 ARGUMENTS.
                add  r0, r5            # r0 = allocate caller part of foo's frame
                ld   $3, r0            # r0 = a2 = 3
                st   r0, (r5)          # l2 = a2, save arg on stack
                ld   $4, r0            # r0 = a3 = 4
                st   r0, 4(r5)         # l3 = a3, save arg on stack
                gpc  $6, r6            # ra = pc + 6 
                j    0x200             # call foo(3,4)

                # caller epilogue for foo
                # undoing what the caller prologue did.
                ld   $8, r0            # r0 = 8 = size of caller part of foo's frame
                add  r0, r5            # deallocate caller part of foo's frame
                 
                ld   (r5), r1          # r1 = a0
                ld   4(r5), r2         # r2 = a1

                # caller prologue for foo
                # so you know that you are saving parameters again.
                ld   $-8, r0           # r0 = -8 = -size of caller part of foo's frame
                add  r0, r5            # allocate caller part of foo's frame 
                st   r1, (r5)          # save a0 on stack, saving argument for foo
                st   r2, 4(r5)         # save a1 on stack, saving argument for foo
                gpc  $6, r6            # ra = pc + 6
                j    0x200             # call foo(a0,a1)

                # caller epilogue for foo
                ld   $8, r0            # r0 = 8 = size of caller part of foo's frame
                add  r0, r5            # deallocate caller part of foo's frame   
                ld   8(r5), r6         # load return address from stack

                #callee epilogue for b
                # undoing what callee prologue did.
                # jumps back to return address
                ld   $12, r0           # r0 = 12 = size of callee part of b's frame
                add  r0, r5            # deallocate callee parts of b's frame  
                j    (r6)              # return
.pos 0x1000
array:          .long 0
                .long 0
                .long 0
                .long 0
                .long 0
                .long 0
                .long 0
                .long 0
                .long 0
                .long 0
.pos 0x8000
# These are here so you can see (some of) the stack contents.
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
sb: .long 0
