	DEFAULT REL
	
	extern printf
	extern scanf
	
	segment .data
prompt db "Are you a man or a woman (0 or 1) : ", 0
	manResult db "Hello, sir!", 10, 0
	womanResult db "Hello, madam!", 10, 0
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
	
	; Print the prompt
	lea rdi, [prompt]
	call print_string
	
	; Read the result
	lea rdi, [result]
	call read_int
	
	; Check if the user is a man or a woman
	movzx rax, byte [result]
	cmp rax, 0
	je man
	jne woman
	
man:
	; Print greeting for man
	lea rdi, [manResult]
	call print_string
	jmp exit
	
woman:
	; Print greeting for woman
	lea rdi, [womanResult]
	call print_string
	jmp exit
	
exit:
	; Call the function to restore callee - saved registers
	pop r12
    pop rbx
    pop rbp
	
	; Exit properly
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
