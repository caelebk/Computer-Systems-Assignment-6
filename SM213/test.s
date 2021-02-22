.pos 0x1000
li:              gpc  $0x2, r2            # r2 = 2;
                 nop                      
                 nop                      
                 nop                      
                 halt                     
si:              ld   $data, r1           
                 ld   $0x0, r2            
                 ld   $0x3, r3            
                 ld   $0x1, r4            
                 st   r3, 0x4(r1)         # m[data + 0] <= 3
                 st   r4, (r1, r4, 4)     # m[data + 4] <= 1
                 halt                     
rmov:            ld   $0x1, r1            
                 mov  r1, r2              # r2 <= 1
                 halt                     
add:             ld   $0x1, r1            
                 ld   $0x2, r2            
                 add  r1, r2              # r2 <= 1 + 2
                 halt                     
and:             ld   $0xa, r1            
                 ld   $0x6, r2            
                 and  r1, r2              # r2 <= 10 & 6 == 0b1010 & 0b0110 == 0b0010 == 2
                 halt                     
inc:             ld   $0x1, r1            
                 inc  r1                  # r1 <= 1 + 1
                 halt                     
inca:            ld   $0x1, r1            
                 inca r1                  # r1 <= 1 + 4
                 halt                     
dec:             ld   $0x2, r1            
                 dec  r1                  # r1 <= 2 - 1
                 halt                     
deca:            ld   $0x5, r1            
                 deca r1                  # r1 <= 5 - 4
                 halt                     
not:             ld   $0xffff0000, r1     
                 not  r1                  # r1 <= ! 0xffff0000 == 0x0000ffff
                 halt                     
shl:             ld   $0x12345678, r1     
                 shl  $17, r1             # r1 <= 0x1234567 << 17 == 0xacf0000
                 halt                     
.pos 0x2000
data:            .long 0x1                
                 .long 0x2                
