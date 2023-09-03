.globl main

.macro ret0
    li a7, 10
    ecall
.end_macro

.macro newline
    li a7, 11
    li a0, 10
    ecall
.end_macro

.macro exponent(%x %y)    # *(s5,0) for n=0
    # compute exponent
    li %x, %y             # initialize s5=0 for n=0
    li t0, 2              # load 2 for 2*n
    mul %x, %x, t0        # 2*n
    addi %x, %x, 1        # 2*n + 1

    mv t5, %x    # copy exponent to t5, for numerator_loop
    mv t2, %x    # copy exponent to t2, for factorial num-1
    mv t3, %x    # copy exponent to t3, for factorial num * num-1
    mv t4, %x    # copy exponent to t4, for denominator_loop
.end_macro

.data
INPUT: .float 0.785398163
msg0: .asciz "Term 0 = "
msg1: .asciz "Term 1 = "
msg2: .asciz "Term 2 = "
msg3: .asciz "Term 3 = "
msg4: .asciz "Term 4 = "
msg5: .asciz "Term 5 = "
msg6: .asciz "Answer = "

.text
main:
    la t4, INPUT           # load address INPUT variable
    flw ft4, (t4)          # load INPUT variable in float
    fmv.s ft5, ft4         # use for loop n=0
    fmv.s ft6, ft4         # use for loop n=1
    fmv.s ft7, ft4         # use for loop n=2
    fmv.s ft8, ft4         # use for loop n=3
    fmv.s ft9, ft4         # use for loop n=4
    fmv.s ft10, ft4        # use for loop n=5

    li s11, 1              # initialize s11 to 1 for stoping loops
    exponent(s5 0)         # compute exponent for n=0
    j numerator_loop0

numerator_loop0:
    beq t5, s11 denominator_loop0    # end loop if t5 == 1
    fmul.s ft5, ft5, ft4             # multiply by input variable
    addi t5, t5, -1                  # subtract 1 for loop counter
    j numerator_loop0

denominator_loop0:
    beq t4, s11 term0        # end loop if t4 == 1
    addi t2, t2, -1          # num-1 -> next digit
    mul t3, t3, t2           # num = num * num-1
    addi t4, t4, -1          # subtract 1 for loop counter
    j denominator_loop0

term0:
    fcvt.s.w ft3, t3        # convert factorial to fp 
    fdiv.s fs5, ft5, ft3    # divide numerator/denominator

    la a0, msg0    # print term 0 message
    li a7, 4
    ecall

    fmv.s fa0, fs5    # print term 0 answer
    li a7, 2
    ecall
    newline

    exponent(s6 1)    # compute exponent for n=1
    j numerator_loop1

numerator_loop1:
    beq t5, s11 denominator_loop1    # end loop if t5 == 1
    fmul.s ft6, ft6, ft4             # multiply by input variable      
    addi t5, t5, -1                  # subtract 1 for loop counter
    j numerator_loop1

denominator_loop1:
    beq t4, s11 term1        # end loop if t4 == 1
    addi t2, t2, -1          # num-1 -> next digit
    mul t3, t3, t2           # num = num * num-1
    addi t4, t4, -1          # subtract 1 for loop counter
    j denominator_loop1

term1:
    fcvt.s.w ft3, t3        # convert factorial to fp 
    fdiv.s fs6, ft6, ft3    # divide numerator/denominator

    la a0, msg1    # print term 1 message
    li a7, 4
    ecall

    fmv.s fa0, fs6    # print term 1 answer
    li a7, 2
    ecall
    newline

    exponent(s7 2)    # compute exponent for n=2
    j numerator_loop2

numerator_loop2:
    beq t5, s11 denominator_loop2     # end loop if t5 == 1
    fmul.s ft7, ft7, ft4              # multiply by input variable        
    addi t5, t5, -1                   # subtract 1 for loop counter
    j numerator_loop2

denominator_loop2:
    beq t4, s11 term2        # end loop if t4 == 1
    addi t2, t2, -1          # num-1 --> next digit
    mul t3, t3, t2           # num = num * num-1
    addi t4, t4, -1          # subtract 1 for loop counter
    j denominator_loop2

term2:
    fcvt.s.w ft3, t3        # convert factorial to fp 
    fdiv.s fs7, ft7, ft3    # divide numerator/denominator

    la a0, msg2    # print term 2 message
    li a7, 4
    ecall

    fmv.s fa0, fs7    # print term 2 answer
    li a7, 2
    ecall
    newline

    exponent(s8 3)    # compute exponent for n=3
    j numerator_loop3

numerator_loop3:
    beq t5, s11 denominator_loop3    # end loop if t5 == 1
    fmul.s ft8, ft8, ft4             # multiply by input variable
    addi t5, t5, -1                  # subtract 1 for loop counter
    j numerator_loop3

denominator_loop3:
    beq t4, s11 term3         # end loop if t4 == 1
    addi t2, t2, -1           # num-1 --> next digit
    mul t3, t3, t2            # num = num * num-1
    addi t4, t4, -1           # subtract 1 for loop counter
    j denominator_loop3

term3:
    fcvt.s.w ft3, t3        # convert factorial to fp 
    fdiv.s fs8, ft8, ft3    # divide numerator/denominator

    la a0, msg3    # print term 3 message
    li a7, 4
    ecall

    fmv.s fa0, fs8    # print term 3 answer
    li a7, 2
    ecall
    newline

    exponent(s9 4)    # compute exponent for n=4
    j numerator_loop4

numerator_loop4:
    beq t5, s11 denominator_loop4    # end loop if t5 == 1
    fmul.s ft9, ft9, ft4             # multiply by ft4(input variable)         
    addi t5, t5, -1                  # subtract 1 for loop counter
    j numerator_loop4

denominator_loop4:
    beq t4, s11 term4        # end loop if t4 == 1
    addi t2, t2, -1          # num-1 --> next digit
    mul t3, t3, t2           # num = num * num-1
    addi t4, t4, -1          # subtract 1 for loop counter
    j denominator_loop4

term4:
    fcvt.s.w ft3, t3        # convert factorial to fp 
    fdiv.s fs9, ft9, ft3    # divide numerator/denominator

    la a0, msg4    # print term 4 answer
    li a7, 4
    ecall

    fmv.s fa0, fs9    # print term 4 answer
    li a7, 2
    ecall
    newline

    exponent(s10 5)    # compute exponent for n=5
    j numerator_loop5

numerator_loop5:
    beq t5, s11 denominator_loop5    # end loop if t5 == 1
    fmul.s ft10, ft10, ft4           # multiply by ft4(input variable)         
    addi t5, t5, -1                  # subtract 1 for loop counter
    j numerator_loop5

denominator_loop5:
    beq t4, s11 term5        # end loop if t4 == 1
    addi t2, t2, -1          # num-1 --> next digit
    mul t3, t3, t2           # num = num * num-1
    addi t4, t4, -1          # subtract 1 for loop counter
    j denominator_loop5

term5:
    fcvt.s.w ft3, t3          # convert factorial to fp 
    fdiv.s fs10, ft10, ft3    # divide numerator/denominator

    la a0, msg5    # print term 5 message
    li a7, 4
    ecall

    fmv.s fa0, fs10    # print term 5 answer
    li a7, 2
    ecall
    newline
 
    call end

end:
    # summation
    fcvt.s.w fs11, x0        # fs11 = 0.0
    fadd.s fs11, fs11, fs5
    fadd.s fs11, fs11, fs6
    fadd.s fs11, fs11, fs7
    fadd.s fs11, fs11, fs8
    fadd.s fs11, fs11, fs9
    fadd.s fs11, fs11, fs10

    # print final answer
    la a0, msg6
    fmv.s fa1, fs11
    li a7, 60
    ecall

    ret0
