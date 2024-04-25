	DEFAULT REL
	
	extern printf
	extern scanf

	segment .data
    prompt1 db "Premier entier m : ", 0
    prompt2 db "Second entier n : ", 0
    promptOut1 db "Plus grand : ", 0
    promptOut2 db "Plus petit : ", 0
	longIntFormat db "%ld", 0
	newLine db 10, 0
	
	segment .bss
	valeur1 resq 1
	valeur2 resq 1
	
	segment .text
	global main
main:
	push rbp
	mov rbp, rsp
	push rbx
	push r12

	lea rdi, [prompt1]
	call print_string
	lea rdi, [valeur1]
	call read_int

    mov rcx, [valeur1]

	lea rdi, [prompt2]
	call print_string
	lea rdi, [valeur2]
	call read_int

    mov rdx, [valeur2]
	
	; Écrire un programme prog.asm qui demande à l'utilisateur deux entiers signés m et n et affiche la plus grande valeur entre 4*m+7-3*n et -5*m+3*n+3 puis la plus petite.

    ; 4*m+7-3*n
    mov rax, 4
    imul rcx
    add rax, 7
    sub rax, 3
    imul rdx
    mov r12, rax

    ; -5*m+3*n+3
    mov rax, -5
    imul rcx
    add rax, 3
    imul rdx
    add rax, 3

    cmp r12, rax
    jg plusGrand
    jmp plusPetit

plusGrand:
    lea rdi, [promptOut1]
    call print_string
    mov rdi, r12
    call print_int
    jmp end

plusPetit:
    lea rdi, [promptOut2]
    call print_string
    mov rdi, rax
    call print_int
    jmp end
	
	

end:
    lea rdi, [newLine]
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
