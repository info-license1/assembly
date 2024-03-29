	DEFAULT REL
	
	extern printf
	extern scanf
	
	segment .data
    prompt1 db "First number: ", 0
    prompt2 db "Second number: ", 0
    prompt3 db "Third number: ", 0
	resultString db "Result: ", 0
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

    lea rdi, [prompt1]
    call print_string
    lea rdi, [result]
    call read_int

    mov r12, [result]

    lea rdi, [prompt2]
    call print_string
    lea rdi, [result]
    call read_int

    add r12, [result]

    lea rdi, [prompt3]
    call print_string
    lea rdi, [result]
    call read_int

    add r12, [result]

    lea rdi, [resultString]
    call print_string
    mov rdi, r12
    call print_int
    
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
