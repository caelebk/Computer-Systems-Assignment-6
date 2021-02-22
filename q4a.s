.pos 0x0
                 ld   $sb, r5             # r5 = &sb bottom of stack
                 inca r5                  # r5 = &sb + 4 put pointer 4 above
                 gpc  $0x6, r6            # r6 = pc + 6
                 j    0x300               # jump to function @ 0x300
                 halt                     
.pos 0x100
                 .long 0x1000             # Base address of global var (array)
.pos 0x200
                 ld   0x0(r5), r0         # r0 = first arg
                 ld   0x4(r5), r1         # r1 = second arg(offset of memory location of global var base)
                 ld   $0x100, r2          # r2 = 256
                 ld   0x0(r2), r2         # r2 = 4096 #finding memory base loc for global var
                 ld   (r2, r1, 4), r3     # r3 = data at the memory base + offset of the global var
                 add  r3, r0              # r0 = data at the memory loc + arg 1
                 st   r0, (r2, r1, 4)     # m[0x100 + 0x4 * 4] = arg1 + data (stores it in same data loc)
                 j    0x0(r6)             # jump to return address
.pos 0x300
                 ld   $0xfffffff4, r0     # r0 = -12
                 add  r0, r5              # r5 = r5 - 12 allocate space on stack
                 st   r6, 0x8(r5)         # store the return address in an offset of 8 above stack pointer
                 ld   $0x1, r0            # r0 = 1
                 st   r0, 0x0(r5)         # store 1 at the stack pointer (local var 1)
                 ld   $0x2, r0            # r0 = 2
                 st   r0, 0x4(r5)         # store 2 at the 4 bytes below the stack pointer (local var 2)
                 ld   $0xfffffff8, r0     # r0 = -8
                 add  r0, r5              # allocate 8 more bytes on the stack
                 ld   $0x3, r0            # r0 = 3
                 st   r0, 0x0(r5)         # store 3 at the stack pointer (arg 1)
                 ld   $0x4, r0            # r0 = 4
                 st   r0, 0x4(r5)         # store 4 at 4 below the stack pointer (arg 2)
                 gpc  $0x6, r6            # r6 = pc + 6 (store return address)
                 j    0x200               # jump to 0x200
                 ld   $0x8, r0            # r0 = 8
                 add  r0, r5              # deallocate 8 bytes from the stack by moving stack pointer down 8 bytes
                 ld   0x0(r5), r1         # r1 = get the first local var
                 ld   0x4(r5), r2         # r2 = get the second local var
                 ld   $0xfffffff8, r0     # r0 = -8
                 add  r0, r5              # allocate 8 spaces onto the stack by moving the stack 8 bytes up
                 st   r1, 0x0(r5)         # store r1 into the stack pointer (arg1 of new func)
                 st   r2, 0x4(r5)         # store r2 into 4 below the stack pointer (arg2 of new func)
                 gpc  $0x6, r6            # r6 = pc + 6 = return address
                 j    0x200               # jump to 200
                 ld   $0x8, r0            # r0 = 8
                 add  r0, r5              # deallocate 8 spaces from stack by moving pointer 8 bytes down
                 ld   0x8(r5), r6         # r6 = value 8 bytes below stack pointer (return address)
                 ld   $0xc, r0            # r0 = 12
                 add  r0, r5              # deallocate last 12 bytes of the stack
                 j    0x0(r6)             # jump to return address which is halt.
.pos 0x1000
                 .long 0x0                
                 .long 0x0                
                 .long 0x1                
                 .long 0x0                
                 .long 0x3                
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
                 .long 0x1                
                 .long 0x2                
                 .long 0x1                
                 .long 0x2                
sb:              .long 0x10               
