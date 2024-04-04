	DEFAULT REL
	
	extern printf
	extern scanf
	
	segment .data
prompt db "Enter a number: ", 0
	evenResult db "The number is even", 0
	oddResult db "The number is odd", 0
	longIntFormat db "%ld", 0
	linefeed db 10, 0
	
	segment .bss
	result resb 1
	
	segment .text
	global main
	
main:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	
	lea rdi, [prompt]
	call print_string
	lea rdi, [result]
	call read_int
	
	mov rax, [result]
	test rax, 1
	jnz .odd
	
	lea rdi, [evenResult]
	call print_string
	
	jmp .end
	
.odd:
	lea rdi, [oddResult]
	call print_string
	
	jmp .end
	
.end:
	lea rdi, [linefeed]
	call print_string
	
	pop r12
	pop rbx
	mov rsp, rbp
	pop rbp
	
	mov rax, 0
	ret
	
print_string:
	enter 0, 0
	mov rax, 0
	call printf wrt ..plt
	mov rax, 0
	leave
	ret
	
print_int:
	enter 0, 0
	mov rsi, rdi
	lea rdi, [longIntFormat]
	mov rax, 0
	call printf wrt ..plt
	mov rax, 0
	leave
	ret
	
read_int:
	enter 0, 0
	mov rsi, rdi
	lea rdi, [longIntFormat]
	mov rax, 0
	call scanf wrt ..plt
	mov rax, 0
	leave
	ret
