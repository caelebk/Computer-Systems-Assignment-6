.pos 0x100
start:           ld   $sb, r5             # r5 = &sb set stack pointer to bottom of stack
                 inca r5                  # move stack pointer 4 up, (deallo 4 bytes)
                 gpc  $0x6, r6            # r6 = return address
                 j    main                # jump to main
                 halt                     # END
f:               deca r5                  # allocate 4 bytes to stack
                 ld   $0x0, r0            # r0 = 0
                 ld   0x4(r5), r1         # r1 = *(x+r4)
                 ld   $0x80000000, r2     # r2 = 0x80000000
f_loop:          beq  r1, f_end           # if r1 == 0 goto f_end
                 mov  r1, r3              # r3 = r1
                 and  r2, r3              # r2 & r3
                 beq  r3, f_if1           # if r3 == 0 goto f_if1
                 inc  r0                  # r0 = r0+1
f_if1:           shl  $1, r1              # r1 = r1*2
                 br   f_loop              # goto f_loop
f_end:           inca r5                  # deallocate 4 bytes from stack
                 j    0x0(r6)             # jumpto return address
main:            deca r5                  # allocate 4 bytes to the stack
                 deca r5                  # allocate 4 bytes to the stack
                 st   r6, 0x4(r5)         # store return address to bottom of stack
                 ld   $0x8, r4            # r4 =8
main_loop:       beq  r4, main_end        # if r4 == 0 then go to main_end
                 dec  r4                  # r4 = [0,7]
                 ld   $x, r0              # r0 = &x
                 ld   (r0, r4, 4), r0     # r0 = *(x+r4)
                 deca r5                  # allocate 4 bytes to the stack
                 st   r0, 0x0(r5)         # store *(x+r4) at top of stack (arg1)
                 gpc  $0x6, r6            # r6 = pc + 6 = return address
                 j    f                   # jump to f
                 inca r5                  # deallocate 4 bytes from the stack
                 ld   $y, r1              # r1 = &y
                 st   r0, (r1, r4, 4)     # m[r1 + r4*4] = r0
                 br   main_loop           # goto main_loop
main_end:        ld   0x4(r5), r6         # r6 = (4 bytes below stack) = return adress
                 inca r5                  # deallocate 4 bytes
                 inca r5                  # deallocate 4 bytes
                 j    0x0(r6)             # jumpto halt
.pos 0x2000
x:               .long 0x1                
                 .long 0x2                
                 .long 0x3                
                 .long 0xffffffff         
                 .long 0xfffffffe         
                 .long 0x0                
                 .long 0xb8               
                 .long 0x1444dbe2         
y:               .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
.pos 0x8000
                 .long 0x0                # These are here so you can see (some of) the stack contents.
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
                 .long 0x1444dbe2         
                 .long 0x0                
sb:              .long 0x110              
