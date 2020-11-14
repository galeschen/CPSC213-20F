gpc  $0x8, r0            # r0 = location of /bin/sh
ld   $0x8, r1            # r1 = length of /bin/sh
sys  $2                  # run /bin/sh
.long 0x2f62696e
.long 0x2f736800
