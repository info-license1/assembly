	DEFAULT REL
	
	extern printf
	extern scanf
	
	segment .data
prompt1 db "First number : ", 0
prompt2 db "Second number : ", 0
orOut db "OR : ", 0
andOut db "AND : ", 0
xorOut db "XOR : ", 0
	longIntFormat db "%ld", 0
    linefeed db 10, 0
	
	segment .bss
	num1 resq 1
	num2 resq 1
	orResult resq 1
	andResult resq 1
	xorResult resq 1
	
	segment .text
	global main
	
main:
    push rbp
    mov rbp, rsp
	push rbx
    push r12
	
	; Get the 2 numbers and print their OR, AND, and XOR
	lea rdi, [prompt1]
	call print_string
	lea rdi, [num1]
	call read_int
	
	mov rbx, [num1]
	
	lea rdi, [prompt2]
	call print_string
	lea rdi, [num2]
	call read_int
	
	mov rcx, [num2]
	
	mov rax, rbx
	or rax, rcx
	mov [orResult], rax
	
	mov rax, rbx
	and rax, rcx
	mov [andResult], rax
	
	mov rax, rbx
	xor rax, rcx
	mov [xorResult], rax
	
	lea rdi, [orOut]
	call print_string
	mov rdi, [orResult]
	call print_int

	lea rdi, [linefeed]
	call print_string
	
	lea rdi, [andOut]
	call print_string
	mov rdi, [andResult]
	call print_int

	lea rdi, [linefeed]
	call print_string
	
	lea rdi, [xorOut]
	call print_string
	mov rdi, [xorResult]
	call print_int

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
