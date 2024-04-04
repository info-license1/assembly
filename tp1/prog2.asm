	DEFAULT REL
	
	extern printf
	extern scanf
	
	segment .data
    prompt1 db "Premier nombre: ", 0
    prompt2 db "Second nombre: ", 0
    prompt3 db "Troisieme nombre: ", 0
    promptOut db "Produit: ", 0
    newLine db 10, 0
    longIntFormat db "%ld", 0

    segment .bss
    result resq 1
	
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

    mov rbx, [result]

    lea rdi, [prompt2]
    call print_string
    lea rdi, [result]
    call read_int

    imul rbx, [result]

    lea rdi, [prompt3]
    call print_string
    lea rdi, [result]
    call read_int

    imul rbx, [result]

    lea rdi, [promptOut]
    call print_string
    lea rdi, [rbx]
    call print_int

    lea rdi, [newLine]
    call print_string

    pop r12
    pop rbx
    pop rbp

    mov rax, 1
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
