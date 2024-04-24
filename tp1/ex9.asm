; Écrire un programme qui demande 10 entiers signés à l'utilisateur,
; stocke les éléments dans un tableau
; puis affiche les éléments du tableau dans l'ordre inverse.

	DEFAULT REL
	
	extern printf
	extern scanf
	
	segment .data
    prompt db "Enter an integer: ", 0
    output db "The integers in reverse order are: ", 0
	longIntFormat db "%ld", 0
	linefeed db 10, 0
	
	segment .bss
	array resq 10
	
	segment .text
	global main
	
main:
	push rbp
	mov rbp, rsp
	push rbx
	push r12

    lea rdi, [prompt]
    call print_string

    mov r12, 0
    mov rbx, 0
    mov rdi, array
    mov rsi, 0
    mov rdx, 10
    call read_int

    mov rdi, 0
    mov rbx, 9
    lea rdi, [output]
    call print_string

print_loop:
    mov rdi, [array + rbx * 8]
    call print_int
    mov rdi, linefeed
    call print_string
    dec rbx
    cmp rbx, rdi
    jge print_loop

    pop r12
    pop rbx
    pop rbp
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