	DEFAULT REL
	
	extern printf
	extern scanf
	
	segment .data
prompt db "Are you a man or a woman (0 or 1) : ", 0
	manResult db "Hello, sir!", 10, 0
	womanResult db "Hello, madam!", 10, 0
    otherResult db "Hello, person!", 10, 0
	longIntFormat db "%ld", 0
	linefeed db 10
	
	segment .bss
	result resb 1
	
	segment .text
	global main
	
main:
	; Call the function to save callee - saved registers
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	
	lea rdi, [prompt]
	call print_string
	lea rdi, [result]
	call read_int
	
	movzx rax, byte [result]
	cmp rax, 0
	je man

    cmp rax, 1
    je woman
    
	lea rdi, [otherResult]
	jmp exit
	
man:
	lea rdi, [manResult]
	jmp exit
	
woman:
	lea rdi, [womanResult]
	jmp exit
	
exit:
	call print_string
	lea rdi, [linefeed]
	call print_string

	pop r12
    pop rbx
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
