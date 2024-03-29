	DEFAULT REL
	
	extern printf
	extern scanf
	
	segment .data
    prompt db "Positive number: ", 0
	resultString db "Is number a power of 2: ", 0
    yesString db "Yes", 0
    noString db "No", 0
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

    mov rbx, [result]
    test rbx, rbx
    jz not_power_of_2

    ; To check: if n is a power of 2, then n & (n - 1) == 0
    ; Unless n is zero, hence the test above
    dec rbx
    and rbx, [result]
    test rbx, rbx
    jz is_power_of_2

not_power_of_2:
    lea rdi, [resultString]
    call print_string

    lea rdi, [noString]
    call print_string

    lea rdi, [linefeed]
    call print_string

    jmp end_program

is_power_of_2:
    lea rdi, [resultString]
    call print_string

    lea rdi, [yesString]
    call print_string

    lea rdi, [linefeed]
    call print_string

end_program:
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
