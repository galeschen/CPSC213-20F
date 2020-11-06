.pos 0x100
start:
    ld $sb, r5              # stack pointer sp = address of last word of stack
    inca    r5              # sp = address of word after stack
    gpc $6, r6              # ra = pc + 6
    j main                  # call main
    halt

f:
    # callee prologue: 
    deca r5                 # allocate callee part of f's frame
    # 4 implies there is one LOCAL VARIABLE (maybeee)
    ld $0, r0               # r0 = 0 = b
    # here is one local variable, called b, which will start at 0.
    ld 4(r5), r1            # r1 = a0
    ld $0x80000000, r2      # r2 = 0x80000000
    # no ra, i think?
f_loop:
    # this is a while loop. while a0 != 0, you keep looping.
    beq r1, f_end           # if a0 = 0, jump to f_end
    mov r1, r3              # r3 = a0
    and r2, r3              # r3 = a0 & 0x80000000
    # inside the loop, you have an if statement. this checks is a0 & r3 == 0
    beq r3, f_if1           # if (a0 & 0x80000000 == 0), jump to f_if1 
    inc r0                  # r0 = b + 1
    # increment your local variable b.
f_if1:
    # if a0 & r3 == 0, then multiply a0 by 2
    shl $1, r1              # a0 = a0 * 2
    br f_loop               # branch to f_loop
f_end:
    # callee epilogue: undo everying the callee did... maybe :3c
    inca r5                 # deallocate callee part of f's frame
    j(r6)                   # return b

main:
    # callee prologue:
    # allocate stack space for return address and locals
    # save return address to stack
    # why are we doing deca twice? we're decrementing by 8, so we one have local variable, and a ra
    deca r5                 # allocate callee part of main's frame
    deca r5                 # allocate callee part of main's frame
    st r6, 4(r5)            # store return address to stack
    # we are setting a return address
    ld $8, r4               # r4 = 8 = a
    # here is one local variable, called a, which will start at 8?
main_loop:
    beq r4, main_end        # if (a == 0), jump to main_end
    dec r4                  # r4 = a - 1
    ld $x, r0               # r0 = &x
    ld (r0,r4,4), r0        # r0 = a0 = x[a]

    # caller prologue. main will call f
    # setting arguments
    deca r5                 # allocate caller part of f's frame
    st r0, (r5)             # store a0 on stack
    gpc $6, r6              # ra = pc + 6
    j f                     # call f(a0), which at this point = x[a]

    # caller epilogue. undoing what caller prologue did.
    inca r5                 # deallocate caller part of f's frame
    ld $y, r1               # r1 = &y
    st r0, (r1,r4,4)        # y[a] = r0
    br main_loop            # branch to main_loop
main_end:
    # callee epilogue:
    # jump back to ra
    ld 4(r5), r6            # load return address from stack
    inca r5                 # deallocate callee part of main's frame
    inca r5                 # deallocate callee part of main's frame
    j (r6)                  # return

.pos 0x2000
x:
    .long 1
    .long 2
    .long 3
    .long -1
    .long -2
    .long 0
    .long 184
    .long 340057058

y:
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

