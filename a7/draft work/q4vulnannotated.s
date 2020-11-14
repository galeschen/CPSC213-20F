.pos 0x1000
start:           ld   $stacktop, r5       
                 gpc  $0x6, r6            # r6 = pc + 6
                 j    main                # call main()
                 halt                     
main:            deca r5                  # allocate callee part of main's frame
                 st   r6, 0x0(r5)         # store return address to stack
                 ld   $0xffffff80, r0     # r0 = -128 = - size of buffer
                 add  r0, r5              # allocating space for buffer
                 deca r5                  # allocate caller part of print's frame
                 ld   $str1, r0           # r0 = &str1
                 st   r0, 0x0(r5)         # store &str1 on stack
                 gpc  $0x6, r6            # set return address
                 j    print               # call print(&str1)
                 inca r5                  # deallocate caller part of print's frame
                 ld   $0x0, r0            # r0 = 0
                 mov  r5, r1              # r1 = sp
                 ld   $0x100, r2          # r2 = 256
                 sys  $0                  # system call: read
                 mov  r0, r4              # r4 = 0
                 deca r5                  # allocate caller part of print's frame
                 ld   $str2, r0           # r0 = &str2
                 st   r0, 0x0(r5)         # store &str2 on stack
                 gpc  $0x6, r6            # set return address
                 j    print               # call print(&str2)
                 inca r5                  # deallocate caller part of print's frame
                 ld   $0x1, r0            # r0 = 1
                 mov  r5, r1              # r1 = sp
                 mov  r4, r2              # r2 = whatever is in r4 at this point?
                 sys  $1                  # sytem call: write
                 ld   $0x80, r0           # deallocate buffer
                 add  r0, r5              # deallocate buffer
                 ld   0x0(r5), r6         # loading return address
                 inca r5                  # deallocate callee part of main
                 j    0x0(r6)             # jump to start
print:           ld   0x0(r5), r0         # r0 = &str1
                 ld   0x4(r0), r1         # r1 = str1[1] = buffer
                 ld   0x0(r0), r2         # r2 = str1[0] = size
                 ld   $0x1, r0            # r0 = fd = 1 (standard out)
                 sys  $1                  # system call: write
                 j    0x0(r6)             
.pos 0x1800
proof:           deca r5                  # allocate callee part of proof's frame
                 ld   $str3, r0           # r0 = &str3
                 st   r0, 0x0(r5)         # store &str3 on stack
                 gpc  $0x6, r6            # r6 = pc + 6
                 j    print               # call print()
                 halt                     

.pos 0x2000
str1:
  .long 30
  .long _str1
_str1:
  .long 0x57656c63          # Welc
  .long 0x6f6d6521          # ome!
  .long 0x20506c65          # Ple
  .long 0x61736520          # ase
  .long 0x656e7465          # ente
  .long 0x72206120          # r a
  .long 0x6e616d65          # name
  .long 0x3a0a0000          # :

str2:
  .long 11
  .long _str2
_str2:
  .long 0x476f6f64          # Good
  .long 0x206c7563          # luc
  .long 0x6b2c2000          # k,

str3:
  .long 43
  .long _str3
_str3:
  .long 0x54686520          # The
  .long 0x73656372          # secr
  .long 0x65742070          # et p
  .long 0x68726173          # hras
  .long 0x65206973          # e is 
  .long 0x20227371          # "sq
  .long 0x7565616d          # ueam
  .long 0x69736820          # ish 
  .long 0x6f737369          # ossi
  .long 0x66726167          # frag
  .long 0x65220a00          # e"

.pos 0x4000
stack:
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
stacktop:
  .long 0
