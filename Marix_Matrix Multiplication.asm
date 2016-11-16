# Kenneth Baldridge
# Matrix Multiplication 
# Program for multiplying two matrices with a minimal size of 16 x 16 elements

.data
#Assume an N x N matrix.   Matrix size = N
matrix_size: .word 16

# matrix A
matrix_A: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
          .word 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
          .word 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47
          .word 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63
          .word 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79
          .word 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95
          .word 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111
          .word 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127
          .word 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143
          .word 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159
          .word 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175
          .word 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191
          .word 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207
          .word 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223
          .word 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239
          .word 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255

# Matrix B (identity matrix)
matrix_B: .word 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	  .word 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
          .word 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
          .word 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
          .word 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
          .word 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
          .word 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0
          .word 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0
          .word 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0
          .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0
          .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0
          .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0
          .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0
          .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0
          .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0
          .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
          
intro: .asciiz "This program multiplies two hardcoded matrices A and B and produces matrix C.\n"
displayMatrixA: .asciiz "Matrix A is:\n"
displayMatrixB: .asciiz "Matrix B is:\n"
displayMatrixC: .asciiz "The product of matrix A and B is:\n"
nl: .asciiz "\n"
space: .asciiz " "
test: .asciiz "\n***test***\n"

.text
.globl main

main:
li $v0, 4
la $a0, intro
syscall

jal makeStack # for matric C
jal multiply

#print out the three matrices#
# Show matrix A
li $v0, 4
la $a0, displayMatrixA
syscall
li $t1, 0 # row count
lw $t3, matrix_size
li $t4, 0
ARowIn:
bge $t1, $t3, ARowOut
	li $t2, 0 # column count
	AColIn:
	bge $t2, $t3, AColOut
		lw $a0,  matrix_A($t4)
		li $v0, 1
		syscall
		la $a0, space
		li $v0, 4
		syscall
		add $t2, $t2, 1
		add $t4, $t4, 4
		j AColIn
	AColOut:
		la $a0, nl
		li $v0, 4
		syscall
		add $t1, $t1, 1
		j ARowIn
ARowOut:

# Show matrix B
li $v0, 4
la $a0, displayMatrixB
syscall
li $t1, 0 # row count
lw $t3, matrix_size
li $t4, 0
BRowIn:
bge $t1, $t3, BRowOut
	li $t2, 0 # column count
	BColIn:
	bge $t2, $t3, BColOut
		lw $a0, matrix_B($t4)
		li $v0, 1
		syscall
		la $a0, space
		li $v0, 4
		syscall
		add $t2, $t2, 1
		add $t4, $t4, 4
		j BColIn
	BColOut:
		la $a0, nl
		li $v0, 4
		syscall
		add $t1, $t1, 1
		j BRowIn
BRowOut:

# Show matrix C
li $v0, 4
la $a0,displayMatrixC
syscall
li $t1, 0 # row count
lw $t3, matrix_size
CRowIn:
bge $t1, $t3, CRowOut
	li $t2, 0 # column count
	CColIn:
	bge $t2, $t3, CColOut
		lw $a0, 0($sp)
		li $v0, 1
		syscall
		la $a0, space
		li $v0, 4
		syscall
		add $t2, $t2, 1
		add $sp, $sp, 4
		j CColIn
	CColOut:
		la $a0, nl
		li $v0, 4
		syscall
		add $t1, $t1, 1
		j CRowIn
CRowOut:

li $v0, 10
syscall

makeStack:
lw $t0, matrix_size
mul $t0, $t0, $t0
mul $t0,$t0,-4
add $sp,$sp,$t0
add $s3, $sp, 0
jr $ra

multiply:
li $t0, 0 # index
li $t1, 0 # row count (will include base offset)
li $t2, 0 # col count (will include base offset)
lw $t4, matrix_size
li $t5, 0 # matrix C index
li $s2, 0
mul $t6, $t4, 4

mul $t8, $t4, $t4
size_loop:
	bge $t1, $t8, size_out
		row_loop: # goes through each row but only changes when we've gone through every column
			bge $t2, $t6, row_out
			col_loop: # goes through each element in the same column
				bge $t0, $t4, col_out
				#get value from matrix A
				add $t3, $t1, $t0
				mul $t3, $t3, 4      
				lw $s0, matrix_A($t3) # pull value from matrix A
				
				#get value from matrix B
				mul $t3, $t4, 4
				mul $t3, $t3, $t0
				add $t3, $t2, $t3
				lw $s1, matrix_B($t3) # pull value from matrix B
				
				mul $t7 $s0, $s1 #multiply values
				add $s2, $s2, $t7 #add to total
				add $t0, $t0, 1 # increment index by 1 for next value in column.
			j col_loop
			col_out:

				sw $s2, ($s3) # $s3 points to current location in stack.
				li $t0, 0   # clear index		
				li $s2, 0   #clear sum
				add $t2, $t2, 4 # move column cownt to next column
				add $s3, $s3, 4 # move $s3-stack pointer to next location.
		j row_loop
		row_out:
			li $t2, 0 # reset index
			add $t1, $t1, $t4 # increment crow offset for next row
		j size_loop
	size_out:
	jr $ra
