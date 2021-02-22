.pos 0x1000
                 ld   $i, r0              # # r0 = &i
                 ld   $c, r2              # #r2 = &c
                 ld   $0x0, r1            # # r1 = 0
                 st   r1, 0x0(r0)         # # i = 0
                 st   r1, 0x0(r2)         # # c= 0
                 ld   $a, r2              # #r2 = &a
                 ld   $b, r3              # #r3 = &b
                 ld   $n, r0              # #r0 = &n
                 ld   0x0(r0), r0         # #r0 = n
                 not  r0                  # #r0 = ~n
                 inc  r0                  # #r0 = -n
L0:              beq  r0, L3              # # if r0 == 0
                 mov  r1, r6              # r6 = i
                 shl  $2, r6              # r6 = i * 4
                 mov  r2, r4              # #r4 = &a
                 mov  r3, r5              # #r5 = &b
                 add  r6, r4              # r4 = &(a + i)
                 add  r6, r5              # r5 = &(b + i)
                 ld   0x0(r4), r4         # r4 = a[i]
                 ld   0x0(r5), r5         # r5 = b[i]
                 not  r5                  # r5 = ~b[i]
                 inc  r5                  # r5 = -b[i]
                 add  r5, r4              # r4 = a[i] - b[i]
                 bgt  r4, L1              # a[i] - b[i] > 0
                 br   L2                  # #go to L2 if not
L1:              ld   $c, r7              # r7 = &c
                 ld   0x0(r7), r6         # r6 = c
                 inc  r6                  # r4 = c+1
                 st   r6, 0x0(r7)         # c = c+1
L2:              ld   $i, r5              # r5 = &i
                 inc  r1                  # r1 = i+1
                 st   r1, 0x0(r5)         # i = i +1
                 inc  r0                  # r0 = -n + 1
                 br   L0                  # go back to start loop
L3:              st   r1, 0x0(r0)         
                 halt                     
.pos 0x2000
i:               .long 0x4                # # Globals
n:               .long 0x5                
c:               .long 0x2                
.pos 0x3000
a:               .long 0xa                # #Arrays
                 .long 0x14               
                 .long 0x1e               
                 .long 0x28               
                 .long 0x32               
b:               .long 0xb                
                 .long 0x14               
                 .long 0x1c               
                 .long 0x2c               
                 .long 0x30               
