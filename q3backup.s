.pos 0x1000
                 ld   $s, r0              # r0 = &s
                 ld   0x0(r0), r0         # r0 = s (base add)
                 ld   $n, r7              # r7 = &n
                 ld   0x0(r7), r7         # r7 = n
                 mov  r7, r6              # r6 = n
                 mov  r0, r1              # r1 = s
AVG:             beq  r6, bubble2         # if n == 0 then end
                 ld   0x4(r1), r2         # r2 = grade 1
                 ld   0x8(r1), r3         # r3 = grade 2
                 ld   0xc(r1), r4         # r4 = grade 3
                 ld   0x10(r1), r5        # r5 = grade 4
                 add  r2, r3              # r3 = grade 1 + grade 2
                 add  r3, r4              # r4 = r3 + grade 3
                 add  r4, r5              # r5 = r4 + grade 4
                 shr  $2, r5              # r5 = r5 / 4
                 st   r5, 0x14(r1)        # s.avg = avg
ListLoop:        dec  r6                  # r7 = n--
                 ld   $0x18, r2           # r2 = 24
                 add  r2, r1              # r1 = next student add&
                 br   AVG                 # restart avg loop
condition:       nop                      # assume r1 is add, if stu1 - stu2 > 0 swap
                 ld   0x14(r1), r2        # r2 = stu1_ag
                 ld   0x2c(r1), r3        # r3 = stu2_ag
                 not  r3                  # r3 = ~r2
                 inc  r3                  # r3 = -stu2_ag
                 add  r3, r2              # r2 = stu1_ag - stu2_ag
                 bgt  r2, Swap            # if stu1_ag - stu2_ag == 0 then swap
                 br   bubble1             
Swap:            ld   0x0(r1), r2         # r2 = sid #1
                 ld   0x18(r1), r3        # r3 = sid#2
                 st   r3, 0x0(r1)         # sid#1 = sid#2
                 st   r2, 0x18(r1)        # sid#2 = sid#1
                 ld   0x1c(r1), r3        # r3 = stu 2 grade 1
                 ld   0x4(r1), r2         # r2 = stu 1 grade 1
                 st   r3, 0x4(r1)         # stu1_g1 = stu2_g1
                 st   r2, 0x1c(r1)        # stu2_g1 = stu2_g1
                 ld   0x20(r1), r3        # r3 = stu2 grade 2
                 ld   0x8(r1), r2         # r2 = stu1 grade 2
                 st   r3, 0x8(r1)         # stu1_g2 = stu2_g2
                 st   r2, 0x20(r1)        # stu2_g2 = stu1_g2
                 ld   0x24(r1), r3        # r3 = stu2 grade 3
                 ld   0xc(r1), r2         # r2 = stu1_grade 3
                 st   r3, 0xc(r1)         # stu1_g3 = stu2_g3
                 st   r2, 0x24(r1)        # stu2_g3 = stu1_g3
                 ld   0x28(r1), r3        # r3 = stu2 grade 4
                 ld   0x10(r1), r2        # r2 = stu1_grade 4
                 st   r3, 0x10(r1)        # stu1_g4 = stu2_g4
                 st   r2, 0x28(r1)        # stu2_g4 = stu1_g4
                 ld   0x2c(r1), r3        # r3 = stu2 avg grade
                 ld   0x14(r1), r2        # r2 = stu1_ag
                 st   r3, 0x14(r1)        # stu1_ag = stu2_ag
                 st   r2, 0x2c(r1)        # stu2_ag = stu1_ag
                 br   bubble1             
begin:           mov  r0, r1              # inner loop r1 = s
                 mov  r7, r6              # r6 = n
                 dec  r6                  # r6 = n-1
                 dec  r6                  
                 br   condition           
bubble1:         beq  r6, bubble2loop     # n = 0
                 dec  r6                  # r6 = n-1
                 ld   $0x18, r2           # r2 = 24
                 add  r2, r1              # r1 = next stu
                 br   condition           
bubble2:         mov  r7, r5              # r5 = n
bubble2loop:     dec  r5                  
                 beq  r5, median          
                 br   begin               
median:          shr  $1, r7              # r7 = n/2
                 ld   $m, r2              # r2 = &m
                 mov  r7, r6              # r6 = n/2
                 shl  $4, r7              # r7 = (n/2)*16
                 shl  $3, r6              # r6 = (n/2)*8
                 add  r6, r7              # r7 = offset
                 add  r7, r0              # r0 = add + offset
                 ld   0x0(r0), r0         # r0 = median sid
                 st   r0, 0x0(r2)         # m = median sid
                 halt                     
.pos 0x2000
n:               .long 0x5                # just one stu
m:               .long 0x12d              # put the answer here
s:               .long 0x3000             # address of the array
.pos 0x3000
base:            .long 0x65               # student ID
                 .long 0xa                # grade 0
                 .long 0xa                # grade 1
                 .long 0xa                # grade 2
                 .long 0xa                # grade 3
                 .long 0xa                # computed average
base1:           .long 0xc9               # student ID #2
                 .long 0x14               # grade 0
                 .long 0x14               # grade 1
                 .long 0x14               # grade 2
                 .long 0x14               # grade 3
                 .long 0x14               # computed average
base2:           .long 0x12d              # student ID #3
                 .long 0x1e               # grade 0
                 .long 0x1e               # grade 1
                 .long 0x1e               # grade 2
                 .long 0x1e               # grade 3
                 .long 0x1e               # computed average
base3:           .long 0x191              # student ID #4
                 .long 0x28               # grade 0
                 .long 0x28               # grade 1
                 .long 0x28               # grade 2
                 .long 0x28               # grade 3
                 .long 0x28               # computed average
base4:           .long 0x1f5              
                 .long 0x32               
                 .long 0x32               
                 .long 0x32               
                 .long 0x32               
                 .long 0x32               
