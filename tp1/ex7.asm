DEFAULT REL

extern printf
extern scanf

segment .data
    prompt db "Entrer un entier signé : ", 0
    output db "Le nombre de 1 dans sa representation binaire : ", 0
    longIntFormat db "%ld", 0
    linefeed db 10, 0

segment .bss
    chosen resq 1
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
    lea rdi, [chosen]
    call read_int

    ; Count the number of 1s in the binary representation of chosen
  mov rax, 1         ; Initialize mask with the rightmost bit set
mov rcx, 64        ; Number of bits in chosen

count_loop:
    test rdi, rax   ; Test if bit is set
    jz skip_increment  ; If not set, skip incrementing count
    inc byte [result]  ; Increment count of set bits
skip_increment:
    shl rax, 1        ; Shift mask to next bit
    loop count_loop   ; Loop until all bits checked



    ; Print the result
    lea rdi, [output]
    call print_string
    movzx rdi, byte [result]  ; Load the count value
    call print_int

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
