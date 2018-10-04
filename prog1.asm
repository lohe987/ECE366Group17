# FAST ISA Program 1 by Yihua PU
# Compute 6^P mod Q
# P = Mem[0]
# Q = Mem[1]
# Mem[2] = Result

init R0, 0
init R1, 1

loop:
init R2, 0
ld R3,(R2)   # R3 = P
add R2, R1   # R2 = R2 + R1
add R1, R1   # R1 = R1 + R1
add R1, R2   # R1 = R1 + R2, here R1 = 6 * R1

init R2, 1
add R0, R2  # R0 = R0 + 1   

beqR out     # if R0  = P: jump out of the loop
init R3, 0
add R3, R0   # make R3 equal R0
beqR loop    #  continue the loop

out:
init R0, 1
ld R2, (R0) # R2 = Q
xor R2, R2
add R2, R0  # R2 = -Q
init R3, 0

mins:
add R1, R2  # R1 = R1 - Q
init R0, 0
add R0, R1  # make R0 = R1
rsf R0, 8
rsf R0, 7   # R0 = the MSB of R1
beq mins    # if R0 == R3, that is, R1 > 0: continue the loop

# Here R0 = 1, R1 <0, add back a Q, store the result
ld R2, (R1) # R2 = Q
add R1, R2
add R0, R0
st R1, (R0)

