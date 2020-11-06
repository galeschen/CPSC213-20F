# BUBBLE SORT CODE:
# void sort (int* a, int n) {
# for (int i=n-1; i>0; i--)
# for (int j=1; j<=i; j++)
# if (a[j-1] > a[j]) {
# int t = a[j];
# a[j] = a[j-1];
# a[j-1] = t;
# }
#}

.pos 0x100
# average loops: 
# for (i = 0, i < n, i++) {get s[i], sum all of s[i]'s grades, then avg}
avg_set_up:	ld $s, r0               # r0 = &s
                ld (r0), r0             # r0 = &base
                ld $0, r1               # r1 = 0 = i
                ld $n, r2               # r2 = address of n
                ld (r2), r2             # r2 = n

avg_loop:       mov r1, r3              # r3 = i
                mov r1, r4              # r4 = i
                shl $3, r3              # r3 = i * 8
                shl $4, r4              # r4 = i * 16
                add r4, r3              # r3 = i * 24    
                add r0, r3              # r3 = &s[i]

                # averaging grade for s[i]
                ld 4(r3), r4            # r4 = s[i].grade[0]
                ld 8(r3), r7            # r7 = s[i].grade[1]
                add r4, r7              # r7 = s[i].grade[0] + s[i].grade[1]
                ld 12(r3), r4           # r4 = s[i].grade[2]
                add r4, r7              # r7 = s[i].grade[2] + r7
                ld 16(r3), r4           # r4 = s[i].grade[3]
                add r4, r7              # r7 = s[i].grade[3] + r7
                shr $2, r7              # r7 = sum of all grades, divided by number of grades (4)
                st r7, 20(r3)           # s[i].average = r7

                # should we continue the loop?
                inc r1                  # r1 = i++
                mov r1, r3              # r3 = i
                not r3
                inc r3                  # r3 = -i
                add r2, r3              # r3 = n - i
                bgt r3, avg_loop        # if i<n, jump back to avg loop

#  for (int i=n-1; i>0; i--)
sort_setup:     ld $n, r1               # r1 = &n
                ld (r1), r1             # r1 = n

sort_comp:      dec r1                  # r1 = i - 1
                beq r1, sort_end        # if i reaches 0, then we're done
                j in_loop_setup

sort_end:       j median


# for (int j=1; j<=i; j++)
in_loop_setup:  ld $0, r2               # r2 = j = 0

in_loop_comp:   inc r2                  # r2 = j + 1
                mov r1, r3              # r3 = i
                not r3                  
                inc r3                  # r3 = -i
                add r2, r3              # r3 = j - i
                bgt r3, in_loop_end     # if j > i, then we're done
                j compare        

in_loop_end:    j sort_comp              



#  if (s[j-1].average > s[j].average)
compare:        ld $s, r0               # r0 = &s
                ld (r0), r0             # r0 = *s = &base
                ld $20, r4              # r4 = 20
                mov r2, r5              # r5 = j
                mov r2, r6              # r6 = j

                shl $3, r5              # r5 = j * 8
                shl $4, r6              # r6 = j * 16
                add r6, r5              # r5 = j * 24  
                add r4, r5              # r5 = (j*24)+20
                shr $2, r5
                ld (r0, r5, 4), r5      # r5 = s[j].average  

                mov r2, r6              # r6 = j
                dec r6                  # r6 = j-1
                mov r6, r7              # r7 = j-1
                shl $3, r6              # r6 = (j-1) * 8
                shl $4, r7              # r7 = (j-1) * 16
                add r7, r6              # r6 = (j-1) * 24  
                add r4, r6              # r6 = ((j-1)*24)+20
                shr $2, r6           
                ld (r0, r6, 4), r6      # r6 = s[j-1].average

                mov r5, r4              # r4 = s[i].average           
                not r4
                inc r4
                add r6, r4              # r4 = s[j-1].average - s[j].average 

                bgt r4, swap            # if s[j-1].average > s[j].average, then swap      
                j in_loop_comp          # if not, check for next j  




# int t = a[j];
# a[j] = a[j-1];
# a[j-1] = t;
swap:           ld $s, r3               # r3 = &s
                ld (r3), r3             # r3 = &base
                mov r2, r0              # r0 = j
                shl $3, r0              # r0 = j * 8
                mov r2, r5              # r5 = j

                mov r2, r4              # r4 = j
                dec r4                  # r4 = j-1
                mov r4, r6              # r6 = j-1
                shl $3, r6              # r6 = (j-1) * 8

                shl $4, r4              # r4 = (j-1) * 16
                add r6, r4              # r4 = (j-1) * 24  
                shl $4, r5              # r5 = j * 16
                add r0, r5              # r5 = j * 24  

                add r3, r5              # r5 = &s[j].studentID
                add r3, r4              # r4 = &s[j-1].studentID
                ld (r5), r6             # r6 = s[j].studentID
                ld (r4), r7             # r7 = s[j-1].studentID
                st r7, (r5)             # s[j].studentID = s[j-1].studentID
                st r6, (r4)             # s[j-1].studentID = s[j].studentID

                inca r5                 # r5 = &s[j].grade1
                inca r4                 # r4 = &s[j-1].grade1
                ld (r5), r6             # r6 = s[j].grade1
                ld (r4), r7             # r7 = s[j-1].grade1
                st r7, (r5)             # s[j].grade1 = s[j-1].grade1
                st r6, (r4)             # s[j-1].grade1 = s[j].grade1

                inca r5                 # r5 = &s[j].grade2
                inca r4                 # r4 = &s[j-1].grade2
                ld (r5), r6             # r6 = s[j].grade2
                ld (r4), r7             # r7 = s[j-1].grade2
                st r7, (r5)             # s[j].grade2 = s[j-1].grade2
                st r6, (r4)             # s[j-1].grade2 = s[j].grade2

                inca r5                 # r5 = &s[j].grade3
                inca r4                 # r4 = &s[j-1].grade3
                ld (r5), r6             # r6 = s[j].grade3
                ld (r4), r7             # r7 = s[j-1].grade3
                st r7, (r5)             # s[j].grade3 = s[j-1].grade3
                st r6, (r4)             # s[j-1].grade3 = s[j].grade3

                inca r5                 # r5 = &s[j].grade4
                inca r4                 # r4 = &s[j-1].grade4
                ld (r5), r6             # r6 = s[j].grade4
                ld (r4), r7             # r7 = s[j-1].grade4
                st r7, (r5)             # s[j].grade4 = s[j-1].grade4
                st r6, (r4)             # s[j-1].grade4 = s[j].grade4

                inca r5                 # r5 = &s[j].average
                inca r4                 # r4 = &s[j-1].average
                ld (r5), r6             # r6 = s[j].average
                ld (r4), r7             # r7 = s[j-1].average
                st r7, (r5)             # s[j].average = s[j-1].average         
                st r6, (r4)             # s[j-1].average = s[j].average
                j in_loop_comp




median:         ld $n, r0               # r0 = &n
                ld (r0), r0             # r0 = n
                shr $1, r0              # r0 = n/2, assume list has odd number of students
                mov r0, r4              # r4 = n/2
                shl $3, r0              # r0 = n/2 * 8
                shl $4, r4              # r4 = n/2 * 16
                add r4, r0              # r5 = n/2 * 24  
                ld $s, r3
                ld (r3), r3
                add r0, r3              # r3 = &s[n/2].studentID
                ld (r3), r4             # r4 = s[n/2].studentID
                ld $m, r5               # r5 = &m
                st r4, (r5)             # m = s[n/2].studentID   
                halt  
        


# global variables
.pos 0x2000
n:      .long   5               # number of students
m:      .long   0               # median student's id
s:      .long   base            # address of dynamic array of students
base:   .long   1000            # student ID (4 bytes)
        .long   81              # grade 0 (4 bytes)
        .long   60              # grade 1 (4 bytes)
        .long   50              # grade 2 (4 bytes)
        .long   90              # grade 3 (4 bytes)
        .long   0               # computed average (4 bytes)

        .long   1001            # student ID
        .long   80              # grade 0
        .long   59              # grade 1
        .long   78              # grade 2
        .long   70              # grade 3
        .long   0               # computed average

        .long   1002            # student ID
        .long   64              # grade 0
        .long   60              # grade 1
        .long   66              # grade 2
        .long   100              # grade 3
        .long   0               # computed average

        .long   1003            # student ID
        .long   34              # grade 0
        .long   10              # grade 1
        .long   78              # grade 2
        .long   63              # grade 3
        .long   0               # computed average

        .long   1004            # student ID
        .long   35              # grade 0
        .long   95              # grade 1
        .long   75              # grade 2
        .long   20              # grade 3
        .long   0               # computed average